import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/service_locator.dart';
import 'config/routes.dart';
import 'core/theme/app_theme.dart';

import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/domain/repositories/i_auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

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
  // Assure que les liaisons Flutter sont initialisées
  WidgetsFlutterBinding.ensureInitialized();

  // Configure l'observateur de bloc pour le débogage
  Bloc.observer = SimpleBlocObserver();

  // Initialise le service locator
  await setupServiceLocator();
  
  // Initialise SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  // Lance l'application avec gestion des erreurs
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({
    super.key,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    // Initialisation des dépendances
    final authRepository = AuthRepository(prefs);
    final authBloc = AuthBloc(authRepository: authRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(
          value: authBloc,
        ),
      ],
      child: MaterialApp.router(
        title: 'Soutrali Deals',
        theme: AppTheme.lightTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          // Gestion globale des erreurs UI
          ErrorWidget.builder = (FlutterErrorDetails details) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Une erreur est survenue',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (details.exception.toString().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            details.exception.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          };
          
          return child ?? const SizedBox.shrink();
        },
      ),
    );
  }
}
