import 'package:amazon_clone/common/bloc/common_state.dart';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/admin_screen.dart';
import 'package:amazon_clone/features/auth/cubit/login_cubit.dart';
import 'package:amazon_clone/features/auth/cubit/signup_cubit.dart';
import 'package:amazon_clone/features/auth/model/user_role_enum.dart';
import 'package:amazon_clone/features/auth/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Auth { signIn, signUp }

class AuthScreenWidget extends StatefulWidget {
  static const String routeName = "/auth-screen";

  const AuthScreenWidget({super.key});

  @override
  State<AuthScreenWidget> createState() => _AuthScreenWidgetState();
}

class _AuthScreenWidgetState extends State<AuthScreenWidget> {
  Auth _auth = Auth.signUp;

  final _signUpFromKey = GlobalKey<FormState>();
  final _signInFromKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //final bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonErrorState) {
              showSnackBar(
                context: context,
                text: state.message,
                backgroundColor: Colors.red,
              );
            } else if (state is CommonLoadingState) {
              const CircularProgressIndicator();
            } else if (state is CommonSuccessState) {
              showSnackBar(
                context: context,
                text: "User signed up successfully",
                backgroundColor: Colors.green,
              );
              _emailController.text = "";
              _nameController.text = "";
              _passwordController.text = "";
              setState(() {
                _auth = Auth.signIn;
              });
            }
          },
        ),
        BlocListener<LoginCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonSuccessState<User>) {
              showSnackBar(
                context: context,
                text: "User logged in successfully",
                backgroundColor: Colors.green,
              );

              final userRole = state.item.currentRole;
              if (userRole == UserRole.user) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const BottomBar()),
                  (route) => false,
                );
              } else if (userRole == UserRole.admin) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
                  (route) => false,
                );
              }

              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => const BottomBar()),
              //     (route) => false);
            }
            if (state is CommonErrorState) {
              showSnackBar(
                context: context,
                text: state.message.toString(),
                backgroundColor: Colors.red,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              ListTile(
                tileColor: _auth == Auth.signUp
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signUp)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFromKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_signUpFromKey.currentState!.validate()) {
                              context.read<SignupCubit>().signupUser(
                                    email: _emailController.text,
                                    name: _nameController.text,
                                    password: _passwordController.text,
                                  );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signIn)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFromKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: "Sign In",
                          onTap: () {
                            if (_signInFromKey.currentState!.validate()) {
                              context.read<LoginCubit>().loginUser(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
