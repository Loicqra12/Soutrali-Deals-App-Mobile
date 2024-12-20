# Soutrali Deals - Application Mobile de Marketplace

## Description
Soutrali Deals est une application mobile de marketplace complète qui permet aux utilisateurs d'acheter, vendre et échanger des produits et services. L'application est développée avec Flutter et suit une architecture propre pour une maintenance et une évolution faciles.

## Configuration requise
- Flutter SDK: 3.16.0 ou supérieur
- Dart SDK: 3.2.0 ou supérieur
- Android Studio / VS Code avec les extensions Flutter et Dart
- Android SDK version 21 minimum (Android 5.0)
- iOS 11.0 ou supérieur pour iOS

## Installation et Configuration

### 1. Prérequis
Assurez-vous d'avoir installé :
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) ou [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/downloads)

### 2. Cloner le projet
```bash
git clone https://github.com/Loicqra12/Soutrali-Deals-App-Mobile.git
cd Soutrali-Deals-App-Mobile
```

### 3. Installation des dépendances
```bash
# Nettoyer le projet
flutter clean

# Mettre à jour les dépendances
flutter pub get
```

### 4. Configuration de l'environnement
- Créez un fichier `.env` à la racine du projet (si nécessaire)
- Configurez vos variables d'environnement

### 5. Lancer l'application
```bash
# Vérifier que tout est correctement configuré
flutter doctor

# Lancer l'application en mode debug
flutter run
```

## Structure du projet
```
lib/
├── config/              # Configuration de l'application
├── core/               # Fonctionnalités de base et utilitaires
│   ├── routes/        # Configuration des routes
│   ├── theme/         # Thème de l'application
│   └── widgets/       # Widgets réutilisables
├── features/          # Modules principaux
│   ├── auth/         # Authentification
│   ├── home/         # Page d'accueil
│   ├── marketplace/  # Place de marché
│   ├── services/     # Services
│   ├── freelances/   # Freelances
│   └── profile/      # Profil utilisateur
├── shared/           # Ressources partagées
└── main.dart         # Point d'entrée de l'application
```

## Résolution des problèmes courants

### Erreurs après le clonage
Si vous rencontrez des erreurs après avoir cloné le projet :
1. Vérifiez votre version de Flutter :
   ```bash
   flutter --version
   ```
2. Nettoyez le projet :
   ```bash
   flutter clean
   rm -rf .dart_tool
   flutter pub get
   ```
3. Invalidez les caches :
   ```bash
   flutter pub cache repair
   ```

### Erreurs de compilation
- Assurez-vous que toutes les dépendances sont correctement installées
- Vérifiez que vous utilisez la bonne version de Flutter
- Redémarrez votre IDE
- Supprimez le dossier build et recompilez :
  ```bash
  rm -rf build/
  flutter build apk
  ```

## Fonctionnalités principales

### Authentification
- Inscription avec différents types de comptes :
  - Particulier
  - Prestataire de services
  - Vendeur
  - Entreprise
- Vérification par email/SMS
- Connexion sécurisée

### Marketplace
- Navigation par catégories
- Recherche avancée
- Filtres personnalisés
- Gestion du panier
- Système de favoris
- Processus de paiement

### Profil et Gestion
- Profil utilisateur personnalisé
- Gestion des commandes
- Historique des transactions
- Paramètres de notification

## Conventions de code
- Utilisez l'architecture Feature-first
- Suivez les principes de Clean Architecture
- Utilisez le style de code Dart standard
- Commentez le code complexe
- Créez des tests unitaires pour les nouvelles fonctionnalités

## Contribution
1. Fork le projet
2. Créez votre branche (`git checkout -b feature/nouvelle-fonctionnalite`)
3. Committez vos changements (`git commit -m 'Ajout d'une nouvelle fonctionnalité'`)
4. Push vers la branche (`git push origin feature/nouvelle-fonctionnalite`)
5. Ouvrez une Pull Request

## Support
Pour toute question ou problème :
- Ouvrez une issue sur GitHub
- Contactez l'équipe de développement

## License
[À définir]

## Équipe
- [Liste des contributeurs]

## Contact
[Informations de contact]
