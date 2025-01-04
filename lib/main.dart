import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/service_locator.dart';
import 'config/routes.dart';
import 'core/theme/app_theme.dart';

import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/domain/repositories/i_auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/reviews/presentation/providers/review_service_provider.dart';
import 'features/payments/presentation/providers/payment_service_provider.dart';
import 'features/notifications/presentation/providers/notification_service_provider.dart';

// Observateur personnalisé pour le débogage des blocs
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('${bloc.runtimeType} $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Désactiver les logs en mode web pour réduire le bruit
  if (kIsWeb) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  // Initialiser les dépendances
  await setupServiceLocator();
  
  // Initialiser SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  Bloc.observer = SimpleBlocObserver();

  final reviewServiceProvider = await ReviewServiceProvider.create(
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(prefs),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );

  final paymentServiceProvider = await PaymentServiceProvider.create(
    child: reviewServiceProvider,
  );

  final notificationServiceProvider = await NotificationServiceProvider.create(
    child: paymentServiceProvider,
  );

  runApp(notificationServiceProvider);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Soutrali Deals',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
      builder: (context, child) {
        // Désactiver le feedback de la souris en mode web
        if (kIsWeb) {
          return MouseRegion(
            cursor: SystemMouseCursors.basic,
            child: child ?? const SizedBox.shrink(),
          );
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
