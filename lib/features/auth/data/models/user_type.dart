enum UserType {
  particular('Particulier'),
  provider('Prestataire'),
  company('Entreprise'),
  seller('Vendeur');

  final String label;
  const UserType(this.label);
}

class UserTypeHelper {
  static String getIcon(UserType type) {
    switch (type) {
      case UserType.particular:
        return 'assets/icons/user.svg';
      case UserType.provider:
        return 'assets/icons/provider.svg';
      case UserType.company:
        return 'assets/icons/company.svg';
      case UserType.seller:
        return 'assets/icons/seller.svg';
    }
  }
}
