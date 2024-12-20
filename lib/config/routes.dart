import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/domain/models/user_type.dart';
import '../features/auth/presentation/pages/splash_screen.dart';
import '../features/auth/presentation/pages/welcome_screen.dart';
import '../features/auth/presentation/pages/register_screen.dart';
import '../features/auth/presentation/pages/register_type_screen.dart';
import '../features/auth/presentation/pages/forgot_password_screen.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/marketplace/presentation/pages/marketplace_page.dart';
import '../features/marketplace/presentation/pages/product_details_page.dart';
import '../features/marketplace/presentation/pages/cart_page.dart';
import '../features/marketplace/presentation/pages/checkout_page.dart';
import '../features/marketplace/presentation/pages/favorites_page.dart';
import '../features/marketplace/presentation/pages/filter_page.dart';
import '../features/orders/presentation/pages/order_details_page.dart';
import '../features/orders/presentation/pages/orders_page.dart';
import '../features/search/presentation/pages/search_page.dart';
import '../features/services/presentation/pages/service_details_page.dart';
import '../features/services/presentation/pages/services_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/presentation/screens/notifications_settings_screen.dart';
import '../features/profile/presentation/screens/privacy_settings_screen.dart';
import '../features/profile/presentation/screens/transaction_history_screen.dart';
import '../features/profile/presentation/screens/help_center_screen.dart';
import '../features/profile/presentation/screens/language_settings_screen.dart';
import '../features/profile/presentation/screens/favorites_screen.dart';
import '../features/profile/presentation/screens/contact_screen.dart';
import '../features/profile/presentation/screens/address_management_screen.dart';
import '../features/freelances/presentation/pages/freelances_page.dart';
import '../features/freelances/presentation/pages/freelancer_details_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
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
      path: '/register/:type',
      builder: (context, state) {
        final typeParam = state.pathParameters['type'];
        UserType? userType;
        
        switch (typeParam) {
          case 'particulier':
            userType = UserType.particular;
            break;
          case 'prestataire':
            userType = UserType.provider;
            break;
          case 'vendeur':
            userType = UserType.seller;
            break;
          case 'entreprise':
            userType = UserType.business;
            break;
          default:
            throw Exception('Type d\'utilisateur non valide : $typeParam');
        }
        
        return RegisterScreen(userType: userType);
      },
    ),
    GoRoute(
      path: '/customer/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/provider/home',
      builder: (context, state) => const ServicesPage(),
    ),
    GoRoute(
      path: '/seller/home',
      builder: (context, state) => const MarketplacePage(),
    ),
    GoRoute(
      path: '/company/home',
      builder: (context, state) => const HomePage(),
    ),
    // Routes pour le marketplace
    GoRoute(
      path: '/marketplace',
      builder: (context, state) => const MarketplacePage(),
    ),
    GoRoute(
      path: '/marketplace/product/:id',
      builder: (context, state) => ProductDetailsPage(
        productId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/marketplace/cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/marketplace/checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
    GoRoute(
      path: '/marketplace/favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
    GoRoute(
      path: '/marketplace/filter',
      builder: (context, state) => const FilterPage(),
    ),
    // Routes pour les services
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
    // Routes pour les commandes
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
    // Route de recherche
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/profile/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/profile/notifications',
      builder: (context, state) => const NotificationsSettingsScreen(),
    ),
    GoRoute(
      path: '/profile/privacy',
      builder: (context, state) => const PrivacySettingsScreen(),
    ),
    GoRoute(
      path: '/profile/history',
      builder: (context, state) => const TransactionHistoryScreen(),
    ),
    GoRoute(
      path: '/profile/language',
      builder: (context, state) => const LanguageSettingsScreen(),
    ),
    GoRoute(
      path: '/profile/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/profile/contact',
      builder: (context, state) => const ContactScreen(),
    ),
    GoRoute(
      path: '/profile/addresses',
      builder: (context, state) => const AddressManagementScreen(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpCenterScreen(),
    ),
    GoRoute(
      path: '/freelances',
      builder: (context, state) => const FreelancesPage(),
    ),
    GoRoute(
      path: '/freelancer/:id',
      builder: (context, state) => FreelancerDetailsPage(
        freelancerId: state.pathParameters['id']!,
      ),
    ),
  ],
);
