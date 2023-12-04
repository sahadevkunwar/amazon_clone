import 'package:amazon_clone/common/utils/custom_loading_placeholder.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
          ///here code of navigation of details page
          // Navigator.of(context).push(PageTransition(
          //     child: ProductDetailScreen(productId: product.id),
          //     type: PageTransitionType.fade));
        },
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  CarouselSlider(
                    items: product.images.map((i) {
                      return Builder(
                        builder: (BuildContext context) =>
                            // Image.network(
                            //   i,
                            //   fit: BoxFit.cover,
                            //   height: 170,
                            //   width: MediaQuery.of(context)
                            //       .size
                            //       .width, // Set width to screen width
                            //   alignment: Alignment.center,
                            // ),

                            CachedNetworkImage(
                          imageUrl: i,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.green, BlendMode.dst)),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CustomLoadingPlaceholder(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 80,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 3, bottom: 0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Rs.${product.price}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
