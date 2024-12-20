/// Définition des chemins de routes pour l'application
class RoutePaths {
  // Routes communes
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String freelances = '/freelances';

  // Routes Particulier
  static class CustomerRoutes {
    static const String home = '/customer/home';
    static const String services = '/customer/services';
    static const String marketplace = '/customer/marketplace';
    static const String orders = '/customer/orders';
    static const String bookings = '/customer/bookings';
    static const String favorites = '/customer/favorites';
  }

  // Routes Prestataire
  static class ProviderRoutes {
    static const String dashboard = '/provider/dashboard';
    static const String services = '/provider/services';
    static const String appointments = '/provider/appointments';
    static const String availability = '/provider/availability';
    static const String products = '/provider/products';
    static const String analytics = '/provider/analytics';
  }

  // Routes Vendeur
  static class SellerRoutes {
    static const String dashboard = '/seller/dashboard';
    static const String products = '/seller/products';
    static const String inventory = '/seller/inventory';
    static const String orders = '/seller/orders';
    static const String store = '/seller/store';
    static const String analytics = '/seller/analytics';
  }

  // Routes Entreprise
  static class BusinessRoutes {
    static const String dashboard = '/business/dashboard';
    static const String team = '/business/team';
    static const String locations = '/business/locations';
    static const String services = '/business/services';
    static const String products = '/business/products';
    static const String analytics = '/business/analytics';
  }

  // Routes Admin
  static class AdminRoutes {
    static const String dashboard = '/admin/dashboard';
    static const String users = '/admin/users';
    static const String moderation = '/admin/moderation';
    static const String reports = '/admin/reports';
    static const String settings = '/admin/settings';
    static const String support = '/admin/support';
  }
}
