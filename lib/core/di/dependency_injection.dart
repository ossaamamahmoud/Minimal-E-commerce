import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:payment/core/networking/api_service.dart';
import 'package:payment/core/networking/dio_factory.dart';
import 'package:payment/features/home/data/repos/home_repo_impl.dart';
import 'package:payment/features/payment/data/repos/stripe_repo/stripe_repo_impl.dart';
import 'package:payment/features/payment/presentation/cubits/payments_cubit/payment_cubit.dart';

import '../../features/home/presentation/cubits/products_cubit.dart';
import '../../features/payment/data/repos/paymob_repo/paymob_repo_impl.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => DioFactory().createDio());

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio: getIt<Dio>()));

  getIt.registerLazySingleton<HomeRepoImpl>(
      () => HomeRepoImpl(apiService: getIt<ApiService>()));

  getIt.registerLazySingleton<ProductsCubit>(
      () => ProductsCubit(homeRepo: getIt<HomeRepoImpl>()));

  getIt.registerLazySingleton<PaymobRepoImpl>(
    () => PaymobRepoImpl(
      apiService: getIt<ApiService>(),
    ),
  );
  getIt.registerLazySingleton<StripeRepoImpl>(
    () => StripeRepoImpl(
      apiService: getIt<ApiService>(),
    ),
  );

  getIt.registerLazySingleton<PaymentsCubit>(() => PaymentsCubit(
      paymobRepo: getIt<PaymobRepoImpl>(),
      stripeRepo: getIt<StripeRepoImpl>()));
}
