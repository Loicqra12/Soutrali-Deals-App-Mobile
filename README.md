# Soutrali Deals

Application mobile de marketplace développée avec Flutter.

## Configuration requise

- Flutter SDK (dernière version stable)
- Dart SDK (dernière version stable)
- Android Studio ou VS Code
- Git

## Installation

1. Clonez le dépôt :
```bash
git clone [URL_DU_REPO]
cd soutrali_deals
```

2. Installez les dépendances :
```bash
flutter pub get
```

## Structure du projet

Le projet suit une architecture Clean Architecture avec la structure suivante :

```
lib/
├── core/                 # Composants partagés et utilitaires
├── features/            # Fonctionnalités de l'application
│   ├── auth/           # Authentification
│   ├── home/           # Page d'accueil
│   ├── marketplace/    # Module marketplace
│   └── profile/        # Profil utilisateur
└── main.dart           # Point d'entrée de l'application
```

## Dépendances principales

Les principales dépendances utilisées dans le projet sont :

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5                  # Gestion d'état et navigation
  http: ^0.13.5                # Requêtes HTTP
  shared_preferences: ^2.0.15   # Stockage local
  cached_network_image: ^3.2.3  # Mise en cache des images
  image_picker: ^0.8.6         # Sélection d'images
```

## Configuration de l'API

L'application communique avec une API Express.js/MongoDB. Les endpoints principaux sont :

- `/api/articles` - Liste des articles
- `/api/categorie` - Liste des catégories
- `/api/article/{id}` - Détails d'un article
- `/api/articles?categorie={id}` - Articles par catégorie

## Fonctionnalités principales

1. **Marketplace**
   - Affichage des articles par catégorie
   - Recherche d'articles
   - Filtrage par catégorie
   - Détails des articles

2. **Authentification**
   - Connexion/Inscription
   - Gestion du profil

## Guide de développement

1. **Convention de nommage**
   - Utilisez le snake_case pour les noms de fichiers
   - Utilisez le camelCase pour les variables et fonctions
   - Utilisez le PascalCase pour les classes

2. **Gestion d'état**
   - Utilisez GetX pour la gestion d'état
   - Créez un contrôleur par feature
   - Utilisez les bindings pour l'injection de dépendances

3. **Modèles**
   - Tous les modèles doivent avoir les méthodes `fromJson` et `toJson`
   - Utilisez des classes immutables avec `final` pour les propriétés

4. **Services**
   - Créez une interface pour chaque service
   - Implémentez la gestion des erreurs
   - Utilisez le pattern Repository

## Tests

Pour exécuter les tests :
```bash
flutter test
```

## Déploiement

1. **Android**
```bash
flutter build apk --release
```

2. **iOS**
```bash
flutter build ios --release
```

## Contribution

1. Créez une nouvelle branche pour chaque feature
2. Suivez les conventions de commit de Git
3. Faites une pull request avec une description détaillée

## Dernières modifications

- Correction du bug de parsing JSON pour le champ `groupe` dans `MarketCategory`
- Amélioration de la gestion des erreurs dans les services
- Mise à jour de l'interface utilisateur du marketplace

## Support

Pour toute question ou problème :
1. Consultez la documentation
2. Ouvrez une issue sur GitHub
3. Contactez l'équipe de développement

## License

[Type de licence]
