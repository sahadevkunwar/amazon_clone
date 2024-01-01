import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/admin/cubit/admin_cubit.dart';
import 'package:amazon_clone/features/admin/cubit/delete_cubit.dart';
import 'package:amazon_clone/features/admin/cubit/fetch_product_cubit.dart';
import 'package:amazon_clone/features/admin/repository/admin_repository.dart';
import 'package:amazon_clone/features/auth/cubit/login_cubit.dart';
import 'package:amazon_clone/features/auth/cubit/signup_cubit.dart';
import 'package:amazon_clone/features/auth/data_source/signup_repo.dart';
import 'package:amazon_clone/features/auth/data_source/user_repo.dart';
import 'package:amazon_clone/features/home/cubit/fetch_deal_of_day_cubit.dart';
import 'package:amazon_clone/features/home/cubit/fetch_product_category.dart';
import 'package:amazon_clone/features/home/home_repo/home_repo.dart';
import 'package:amazon_clone/features/product_details/cubit/add_to_cart_cubit.dart';
import 'package:amazon_clone/features/product_details/cubit/product_detail_cubit.dart';
import 'package:amazon_clone/features/product_details/cubit/remove_from_cart_cubit.dart';
import 'package:amazon_clone/features/product_details/repo/product_detail_repo.dart';
import 'package:amazon_clone/features/search/cubit/search_cubit.dart';
import 'package:amazon_clone/features/search/repo/search_repo.dart';
import 'package:amazon_clone/features/splash/ui/splash_page.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => SignupRepository(),
        ),
        RepositoryProvider(
          create: (context) => AdminRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => HomeRepo(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => SearchRepo(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ProductDetailRepo(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              signupRepository: context.read<SignupRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FetchProductCubit(
                adminRepository: context.read<AdminRepository>())
              ..fetchAllProduct(),
          ),
          BlocProvider(
            create: (context) =>
                AdminCubit(adminRepository: context.read<AdminRepository>()),
          ),
          BlocProvider(
            create: (context) => DeleteCubit(
              adminRepository: context.read<AdminRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                FetchProductCategoryCubit(homeRepo: context.read<HomeRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                SearchCubit(searchRepo: context.read<SearchRepo>()),
          ),
          BlocProvider(
            create: (context) => ProductDetailCubit(
                productDetailRepo: context.read<ProductDetailRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                DealOfDayCubit(homeRepo: context.read<HomeRepo>()),
          ),
          BlocProvider(
            create: (context) => AddToCartCubit(
                productDetailRepo: context.read<ProductDetailRepo>()),
          ),
          BlocProvider(
            create: (context) => RemoveFromCartCubit(
                productDetailRepo: context.read<ProductDetailRepo>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Amazon clone',
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          onGenerateRoute: (settings) => generateRoute(settings),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
