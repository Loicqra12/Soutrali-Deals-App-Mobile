import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/models/user_type.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/auth/presentation/pages/welcome_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/auth/presentation/pages/register_type_screen.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/marketplace/presentation/pages/marketplace_page.dart';
import '../../features/marketplace/presentation/pages/product_details_page.dart';
import '../../features/marketplace/presentation/pages/cart_page.dart';
import '../../features/marketplace/presentation/pages/checkout_page.dart';
import '../../features/marketplace/presentation/pages/favorites_page.dart';
import '../../features/marketplace/presentation/pages/filter_page.dart';
import '../../features/orders/presentation/pages/order_details_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/services/presentation/pages/service_details_page.dart';
import '../../features/services/presentation/pages/services_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Routes d'authentification
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterTypeScreen(),
      ),
      GoRoute(
        path: '/register/particulier',
        builder: (context, state) => const RegisterScreen(
          userType: UserType.particular,
        ),
      ),
      GoRoute(
        path: '/register/prestataire',
        builder: (context, state) => const RegisterScreen(
          userType: UserType.provider,
        ),
      ),
      GoRoute(
        path: '/register/vendeur',
        builder: (context, state) => const RegisterScreen(
          userType: UserType.seller,
        ),
      ),
      GoRoute(
        path: '/register/entreprise',
        builder: (context, state) => const RegisterScreen(
          userType: UserType.business,
        ),
      ),

      // Routes principales
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),

      // Routes des services
      GoRoute(
        path: '/services',
        builder: (context, state) => const ServicesPage(),
      ),
      GoRoute(
        path: '/services/:id',
        builder: (context, state) => ServiceDetailsPage(
          serviceId: state.pathParameters['id']!,
        ),
      ),

      // Routes des commandes
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersPage(),
      ),
      GoRoute(
        path: '/orders/:id',
        builder: (context, state) => OrderDetailsPage(
          orderId: state.pathParameters['id']!,
        ),
      ),

      // Routes du marketplace
      GoRoute(
        path: '/marketplace',
        builder: (context, state) => const MarketplacePage(),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductDetailsPage(
          productId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesPage(),
      ),
      GoRoute(
        path: '/filters',
        builder: (context, state) => const FilterPage(),
      ),
    ],
  );
}
