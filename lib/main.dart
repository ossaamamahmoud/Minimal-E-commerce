import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/core/networking/api_constants.dart';
import 'package:payment/features/home/presentation/ui/home_screen.dart';

import 'app_observer.dart';
import 'core/di/dependency_injection.dart';
import 'features/home/presentation/cubits/products_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  Stripe.publishableKey = ApiConstants.stripePublishableKey;

  Stripe.merchantIdentifier = 'Osama Test Merchant';
  await Stripe.instance.applySettings();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductsCubit>(
            create: (context) {
              return getIt<ProductsCubit>();
            },
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
