enum UserType {
  particular,
  provider,
  seller,
  business;

  String get label {
    switch (this) {
      case UserType.particular:
        return 'Particulier';
      case UserType.provider:
        return 'Prestataire';
      case UserType.seller:
        return 'Vendeur';
      case UserType.business:
        return 'Entreprise';
    }
  }

  List<String> get requiredFields {
    switch (this) {
      case UserType.particular:
        return [
          'Nom complet',
          'Adresse e-mail ou numéro de téléphone',
          'Mot de passe',
        ];
      case UserType.provider:
        return [
          'Nom complet',
          'Spécialité ou domaine',
          'Expérience professionnelle',
          'Adresse e-mail',
          'Numéro de téléphone',
          'Pièce d\'identité',
        ];
      case UserType.business:
        return [
          'Nom de l\'entreprise',
          'Numéro RCCM',
          'Justificatif',
          'Adresse e-mail professionnelle',
          'Logo de l\'entreprise',
        ];
      case UserType.seller:
        return [
          'Nom ou pseudonyme',
          'Adresse de livraison principale',
          'Catégories d\'articles',
          'Photo d\'identité',
        ];
    }
  }
}
