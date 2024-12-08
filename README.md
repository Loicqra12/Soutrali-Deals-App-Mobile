# Soutrali Deals - Application Mobile de Marketplace

## Description
Soutrali Deals est une application mobile de marketplace complète qui permet aux utilisateurs d'acheter, vendre et échanger des produits et services. L'application est développée avec Flutter et suit une architecture propre pour une maintenance et une évolution faciles.

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

## Technologies utilisées
- Flutter
- Dart
- go_router pour la navigation
- Architecture Clean (Domain-Driven Design)

## Pour commencer

### Prérequis
- Flutter (dernière version stable)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clonez le repository
```bash
git clone https://github.com/Loicqra12/Soutrali-Deals-App-Mobile.git
```

2. Accédez au répertoire du projet
```bash
cd Soutrali-Deals-App-Mobile
```

3. Installez les dépendances
```bash
flutter pub get
```

4. Lancez l'application
```bash
flutter run
```

## Structure du projet
```
lib/
├── core/
│   ├── routes/
│   │   └── app_router.dart
│   └── theme/
├── features/
│   ├── auth/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── data/
│   ├── marketplace/
│   ├── orders/
│   └── services/
└── main.dart
```

## Design System
- Couleur principale : Vert (#27AE60)
- Police : [À définir]
- Design System Material 3

## Contribution
1. Fork le projet
2. Créez votre branche de fonctionnalité (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## License
[À définir]

## Équipe
- [Liste des contributeurs]

## Contact
[Informations de contact]
