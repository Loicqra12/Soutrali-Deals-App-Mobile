import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/domain/repositories/i_auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/services/data/repositories/service_repository.dart';
import '../../features/services/domain/repositories/i_service_repository.dart';
import '../../features/services/presentation/bloc/service_bloc.dart';

import '../../features/booking/data/repositories/booking_repository.dart';
import '../../features/booking/domain/repositories/i_booking_repository.dart';
import '../../features/booking/presentation/bloc/booking_bloc.dart';

import '../../features/payment/data/repositories/payment_repository.dart';
import '../../features/payment/domain/repositories/i_payment_repository.dart';
import '../../features/payment/presentation/bloc/payment_bloc.dart';

import '../../features/users/data/repositories/user_repository.dart';
import '../../features/users/domain/repositories/i_user_repository.dart';
import '../../features/users/presentation/bloc/user_bloc.dart';

import '../../features/marketplace/data/repositories/marketplace_repository.dart';
import '../../features/marketplace/domain/repositories/i_marketplace_repository.dart';
import '../../features/marketplace/presentation/bloc/marketplace_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());

  // Repositories
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(getIt<SharedPreferences>()),
  );
  
  getIt.registerLazySingleton<IServiceRepository>(
    () => ServiceRepository(getIt<http.Client>()),
  );
  
  getIt.registerLazySingleton<IBookingRepository>(
    () => BookingRepository(getIt<http.Client>()),
  );
  
  getIt.registerLazySingleton<IPaymentRepository>(
    () => PaymentRepository(getIt<http.Client>()),
  );
  
  getIt.registerLazySingleton<IUserRepository>(
    () => UserRepository(getIt<http.Client>()),
  );

  getIt.registerLazySingleton<IMarketplaceRepository>(
    () => MarketplaceRepository(getIt<http.Client>()),
  );

  // BLoCs
  getIt.registerFactory(
    () => AuthBloc(authRepository: getIt<IAuthRepository>()),
  );
  
  getIt.registerFactory(
    () => ServiceBloc(serviceRepository: getIt<IServiceRepository>()),
  );
  
  getIt.registerFactory(
    () => BookingBloc(bookingRepository: getIt<IBookingRepository>()),
  );
  
  getIt.registerFactory(
    () => PaymentBloc(paymentRepository: getIt<IPaymentRepository>()),
  );
  
  getIt.registerFactory(
    () => UserBloc(userRepository: getIt<IUserRepository>()),
  );

  getIt.registerFactory(
    () => MarketplaceBloc(marketplaceRepository: getIt<IMarketplaceRepository>()),
  );
}
