import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const primaryColor = Colors.green;
  static const secondaryColor = Colors.greenAccent;
  static const backgroundColor = Colors.white;
  static const errorColor = Colors.red;

  // Text Styles
  static const TextStyle headlineStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  // Input Decoration
  static InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
    );
  }

  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // Validation Messages
  static const String requiredField = 'Ce champ est obligatoire';
  static const String invalidEmail = 'Veuillez entrer un email valide';
  static const String passwordTooShort = 'Le mot de passe doit contenir au moins 6 caractères';
  static const String invalidPhone = 'Veuillez entrer un numéro de téléphone valide';

  // Screen Titles
  static const String signupTitle = 'Inscription';
  static const String accountTypeTitle = 'Choisir un type de compte';

  // Button Labels
  static const String signupButtonLabel = 'S\'inscrire';
  static const String nextButtonLabel = 'Suivant';
  static const String backButtonLabel = 'Retour';

  // Form Labels
  static const String nameLabel = 'Nom complet';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Mot de passe';
  static const String phoneLabel = 'Numéro de téléphone';

  // Account Types
  static const String particularLabel = 'Particulier';
  static const String providerLabel = 'Fournisseur';
  static const String sellerLabel = 'Vendeur';
  
  // Account Type Descriptions
  static const String particularDesc = 'Pour les utilisateurs qui souhaitent acheter des produits';
  static const String providerDesc = 'Pour les entreprises qui vendent des produits';
  static const String sellerDesc = 'Pour les revendeurs individuels';
}
