import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/di/service_locator.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/services/presentation/bloc/service_bloc.dart';
import 'features/booking/presentation/bloc/booking_bloc.dart';
import 'features/payment/presentation/bloc/payment_bloc.dart';
import 'features/users/presentation/bloc/user_bloc.dart';
import 'features/marketplace/presentation/bloc/marketplace_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider<ServiceBloc>(
          create: (_) => getIt<ServiceBloc>(),
        ),
        BlocProvider<BookingBloc>(
          create: (_) => getIt<BookingBloc>(),
        ),
        BlocProvider<PaymentBloc>(
          create: (_) => getIt<PaymentBloc>(),
        ),
        BlocProvider<UserBloc>(
          create: (_) => getIt<UserBloc>(),
        ),
        BlocProvider<MarketplaceBloc>(
          create: (_) => getIt<MarketplaceBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Soutrali Deals',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light, // Forcer le mode clair
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
