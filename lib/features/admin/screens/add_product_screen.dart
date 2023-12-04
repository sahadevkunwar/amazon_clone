import 'dart:io';

import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/cubit/admin_cubit.dart';
import 'package:amazon_clone/features/admin/cubit/fetch_product_cubit.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  String category = 'Mobiles';
  List<File> images = [];
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  // void selectImages() async {
  //   var res = await pickImages();
  //   setState(() {
  //     images = res;
  //   });
  // }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  final _addFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text(
              'Add Product',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: BlocListener<AdminCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
              if (state is CommonErrorState) {
                showSnackBar(
                  context: context,
                  text: state.message,
                  backgroundColor: Colors.red,
                );
              }
              if (state is CommonSuccessState) {
                context.read<FetchProductCubit>().fetchAllProduct();

                showSnackBar(
                  context: context,
                  text: "Product added successfully",
                  backgroundColor: Colors.green,
                );

                setState(() {
                  productNameController.text = '';
                  descriptionController.text = '';
                  priceController.text = '';
                  quantityController.text = '';
                  images.clear();
                });
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const AdminScreen()),
                    (route) => false);
              }
            }
          },
          child: SingleChildScrollView(
            child: Form(
                key: _addFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      images.isNotEmpty
                          ? CarouselSlider(
                              items: images.map((i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 200,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                selectImages();
                              },
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.folder_open, size: 40),
                                      SizedBox(height: 15),
                                      Text(
                                        'Select product images',
                                        style: TextStyle(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: productNameController,
                        hintText: 'Product Name',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: descriptionController,
                        hintText: 'Description',
                        maxLines: 7,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: priceController,
                        hintText: 'Price',
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Price cannot be empty ";
                          }
                          if (double.tryParse(val) == null) {
                            return "Please enter a valid Price";
                          }

                          // Additional validation for a value less than zero
                          if (double.tryParse(val) == null ||
                              double.parse(val) < 0) {
                            return "Price must be greater than or equal to zero";
                          }
                          if (double.tryParse(val) == null) {
                            return "Please enter a valid Price";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: quantityController,
                        hintText: 'Quantity',
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Quantity cannot be empty ";
                          }
                          // Check if the value is a valid number
                          if (double.tryParse(val) == null) {
                            return "Please enter a valid Quantity";
                          }
                          // Additional validation for a value less than zero
                          if (double.tryParse(val) == null ||
                              double.parse(val) < 0) {
                            return "Value must be greater than or equal to zero";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton(
                            value: category,
                            items: productCategories.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                category = newValue!;
                              });
                            }),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: "Sell",
                          onTap: () {
                            if (_addFormKey.currentState!.validate() &&
                                images.isNotEmpty) {
                              context.read<AdminCubit>().postProduct(
                                    name: productNameController.text,
                                    description: descriptionController.text,
                                    images: images,
                                    price: double.parse(priceController.text),
                                    quantity:
                                        double.parse(quantityController.text),
                                    category: category,
                                  );
                            } else {
                              // Show a snackbar or some indication that images are required
                              showSnackBar(
                                context: context,
                                text: "Please select at least one image",
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          backColors: Colors.amber,
                          foreColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
