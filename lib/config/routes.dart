import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/reviews/presentation/providers/review_service_provider.dart';
import '../features/payments/presentation/providers/payment_service_provider.dart';
import '../features/auth/domain/models/user_type.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/registration_screen.dart';
import '../features/auth/presentation/screens/account_type_screen.dart';
import '../features/auth/presentation/screens/verification_screen.dart';
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
import '../features/services/presentation/pages/services_page.dart';
import '../features/services/presentation/pages/service_category_page.dart';
import '../features/services/data/models/service_group.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
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
import '../features/freelances/presentation/pages/freelance_registration_page.dart';
import '../features/chat/presentation/pages/chat_page.dart';
import '../features/payments/presentation/pages/payment_page.dart';
import '../features/reviews/presentation/pages/review_page.dart';
import '../features/freelances/domain/models/freelancer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/reviews/data/review_service.dart';
import '../features/notifications/presentation/providers/notification_service_provider.dart';
import '../features/notifications/presentation/pages/notifications_page.dart';
import '../features/payments/presentation/pages/payment_details_page.dart';
import '../features/provider/presentation/pages/provider_registration_page.dart';
import '../features/marketplace/presentation/pages/seller_registration_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const AccountTypeScreen(),
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
        
        return RegistrationScreen(userType: userType);
      },
    ),
    GoRoute(
      path: '/verification',
      builder: (context, state) => VerificationScreen(
        contactInfo: state.extra != null 
            ? (state.extra as Map<String, dynamic>)['contactInfo'] as String 
            : '',
        isEmail: state.extra != null 
            ? (state.extra as Map<String, dynamic>)['isEmail'] as bool 
            : true,
      ),
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
      path: '/marketplace/seller/register',
      builder: (context, state) => const SellerRegistrationPage(),
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
      builder: (context, state) => ServiceCategoryPage(
        categoryId: state.pathParameters['id']!,
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
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
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
    // Routes pour les freelances
    GoRoute(
      path: '/freelances',
      name: 'freelances',
      builder: (context, state) => const FreelancesPage(),
    ),
    GoRoute(
      path: '/freelancer/:id',
      builder: (context, state) => FreelancerDetailsPage(
        freelancerId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/freelance/registration',
      name: 'freelance_registration',
      builder: (context, state) => const FreelanceRegistrationPage(),
    ),
    GoRoute(
      path: '/chat/:freelancerId',
      builder: (context, state) {
        final freelancerId = state.pathParameters['freelancerId']!;
        return ChatPage(providerId: freelancerId);
      },
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return PaymentPage(
          freelancer: args['freelancer'] as Freelancer,
          amount: args['amount'] as double,
          description: args['description'] as String,
          clientId: args['clientId'] as String,
          paymentService: PaymentServiceProvider.of(context),
        );
      },
    ),
    GoRoute(
      path: '/review',
      builder: (context, state) {
        final freelancerId = state.extra as String;
        return ReviewPage(
          freelancerId: freelancerId,
          currentUserId: 'client_id', // TODO: Get from auth service
          reviewService: ReviewServiceProvider.of(context),
        );
      },
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) {
        return NotificationsPage(
          notificationService: NotificationServiceProvider.of(context),
        );
      },
    ),
    GoRoute(
      path: '/payment-details',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return PaymentDetailsPage(
          payment: args['payment'],
        );
      },
    ),
    GoRoute(
      path: '/provider-registration',
      name: 'provider_registration',
      builder: (context, state) => const ProviderRegistrationPage(),
    ),
  ],
);
