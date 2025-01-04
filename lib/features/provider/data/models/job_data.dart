import 'job_category.dart';

final List<JobCategory> jobCategories = [
  JobCategory(
    id: '1',
    name: 'Services à Domicile',
    subCategories: [
      SubCategory(
        id: '1_1',
        name: 'Soins et Beauté',
        services: [
          Service(id: '1_1_1', name: 'Coiffeur à domicile'),
          Service(id: '1_1_2', name: 'Esthéticien(ne) à domicile'),
        ],
      ),
      SubCategory(
        id: '1_2',
        name: 'Garde et Soins',
        services: [
          Service(id: '1_2_1', name: 'Garde d\'enfants'),
          Service(id: '1_2_2', name: 'Baby-sitter'),
          Service(id: '1_2_3', name: 'Nounou'),
        ],
      ),
      SubCategory(
        id: '1_3',
        name: 'Cuisine et Alimentation',
        services: [
          Service(id: '1_3_1', name: 'Cuisinier à domicile'),
        ],
      ),
      SubCategory(
        id: '1_4',
        name: 'Entretien',
        services: [
          Service(id: '1_4_1', name: 'Nettoyage domestique'),
          Service(id: '1_4_2', name: 'Jardinier à domicile'),
          Service(id: '1_4_3', name: 'Aide-ménagère'),
          Service(id: '1_4_4', name: 'Gestionnaire de déchets domestiques'),
        ],
      ),
      SubCategory(
        id: '1_5',
        name: 'Sécurité',
        services: [
          Service(id: '1_5_1', name: 'Gardien de maison'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '2',
    name: 'Réparations et Maintenance',
    subCategories: [
      SubCategory(
        id: '2_1',
        name: 'Électronique',
        services: [
          Service(id: '2_1_1', name: 'Réparateur de téléphones'),
          Service(id: '2_1_2', name: 'Réparateur d\'appareils électroniques'),
          Service(id: '2_1_3', name: 'Réparateur de réfrigérateurs'),
          Service(id: '2_1_4', name: 'Réparateur de machines à laver'),
          Service(id: '2_1_5', name: 'Réparateur de climatiseurs'),
        ],
      ),
      SubCategory(
        id: '2_2',
        name: 'Installation',
        services: [
          Service(id: '2_2_1', name: 'Plombier'),
          Service(id: '2_2_2', name: 'Électricien'),
          Service(id: '2_2_3', name: 'Technicien en systèmes de sécurité'),
        ],
      ),
      SubCategory(
        id: '2_3',
        name: 'Réparation Mécanique',
        services: [
          Service(id: '2_3_1', name: 'Réparateur de pneus'),
          Service(id: '2_3_2', name: 'Réparateur de machines agricoles'),
          Service(id: '2_3_3', name: 'Réparateur de matériel de jardinage'),
          Service(id: '2_3_4', name: 'Réparateur de générateurs'),
        ],
      ),
      SubCategory(
        id: '2_4',
        name: 'Artisanat',
        services: [
          Service(id: '2_4_1', name: 'Réparateur de chaussures'),
          Service(id: '2_4_2', name: 'Réparateur de meubles'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '3',
    name: 'Transport et Livraison',
    subCategories: [
      SubCategory(
        id: '3_1',
        name: 'Transport de Personnes',
        services: [
          Service(id: '3_1_1', name: 'Taxi/Moto-taxi'),
          Service(id: '3_1_2', name: 'Chauffeur de VTC'),
          Service(id: '3_1_3', name: 'Chauffeur de bus local'),
          Service(id: '3_1_4', name: 'Service de transport pour personnes âgées'),
        ],
      ),
      SubCategory(
        id: '3_2',
        name: 'Transport de Marchandises',
        services: [
          Service(id: '3_2_1', name: 'Livreur de colis'),
          Service(id: '3_2_2', name: 'Transporteur de marchandises'),
          Service(id: '3_2_3', name: 'Services de déménagement local'),
          Service(id: '3_2_4', name: 'Conducteur de charrette'),
          Service(id: '3_2_5', name: 'Conducteur de pousse-pousse'),
        ],
      ),
      SubCategory(
        id: '3_3',
        name: 'Livraison Alimentaire',
        services: [
          Service(id: '3_3_1', name: 'Livreur de repas à domicile'),
          Service(id: '3_3_2', name: 'Livreur de produits frais'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '4',
    name: 'Artisanat et Création',
    subCategories: [
      SubCategory(
        id: '4_1',
        name: 'Textile et Cuir',
        services: [
          Service(id: '4_1_1', name: 'Tailleur/Couturier'),
          Service(id: '4_1_2', name: 'Cordonnier'),
          Service(id: '4_1_3', name: 'Artisan textile'),
          Service(id: '4_1_4', name: 'Artisan de cuir'),
        ],
      ),
      SubCategory(
        id: '4_2',
        name: 'Travail du Bois',
        services: [
          Service(id: '4_2_1', name: 'Menuisier'),
          Service(id: '4_2_2', name: 'Charpentier'),
          Service(id: '4_2_3', name: 'Créateur de mobilier en bois'),
          Service(id: '4_2_4', name: 'Artisan de sculptures en bois'),
        ],
      ),
      SubCategory(
        id: '4_3',
        name: 'Artisanat Décoratif',
        services: [
          Service(id: '4_3_1', name: 'Artisan potier'),
          Service(id: '4_3_2', name: 'Créateur de bijoux artisanaux'),
          Service(id: '4_3_3', name: 'Artisan de décoration intérieure'),
          Service(id: '4_3_4', name: 'Peintre muraliste'),
          Service(id: '4_3_5', name: 'Fabricant de produits en raphia'),
        ],
      ),
      SubCategory(
        id: '4_4',
        name: 'Métallurgie',
        services: [
          Service(id: '4_4_1', name: 'Forgeron'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '5',
    name: 'Services Professionnels',
    subCategories: [
      SubCategory(
        id: '5_1',
        name: 'Sécurité',
        services: [
          Service(id: '5_1_1', name: 'Agent de sécurité privée'),
          Service(id: '5_1_2', name: 'Agent de sécurité événementiel'),
        ],
      ),
      SubCategory(
        id: '5_2',
        name: 'Conseil et Formation',
        services: [
          Service(id: '5_2_1', name: 'Consultant en marketing local'),
          Service(id: '5_2_2', name: 'Consultant en gestion financière'),
          Service(id: '5_2_3', name: 'Consultant en ressources humaines'),
          Service(id: '5_2_4', name: 'Formateur en informatique'),
          Service(id: '5_2_5', name: 'Tuteur académique'),
          Service(id: '5_2_6', name: 'Formateur en développement personnel'),
        ],
      ),
      SubCategory(
        id: '5_3',
        name: 'Bien-être et Santé',
        services: [
          Service(id: '5_3_1', name: 'Coach de fitness personnel'),
          Service(id: '5_3_2', name: 'Instructeur de yoga'),
          Service(id: '5_3_3', name: 'Conseiller en nutrition'),
        ],
      ),
      SubCategory(
        id: '5_4',
        name: 'Services Linguistiques',
        services: [
          Service(id: '5_4_1', name: 'Traducteur indépendant'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '6',
    name: 'Arts et Divertissement',
    subCategories: [
      SubCategory(
        id: '6_1',
        name: 'Arts Visuels',
        services: [
          Service(id: '6_1_1', name: 'Artiste peintre'),
          Service(id: '6_1_2', name: 'Sculpteur'),
          Service(id: '6_1_3', name: 'Illustrateur'),
          Service(id: '6_1_4', name: 'Photographe freelance'),
        ],
      ),
      SubCategory(
        id: '6_2',
        name: 'Arts du Spectacle',
        services: [
          Service(id: '6_2_1', name: 'Acteur/Comédien'),
          Service(id: '6_2_2', name: 'Danseur'),
          Service(id: '6_2_3', name: 'Musicien'),
          Service(id: '6_2_4', name: 'Chorégraphe'),
        ],
      ),
      SubCategory(
        id: '6_3',
        name: 'Production',
        services: [
          Service(id: '6_3_1', name: 'Producteur de musique indépendant'),
          Service(id: '6_3_2', name: 'Créateur de contenu numérique'),
          Service(id: '6_3_3', name: 'Organisateur d\'événements locaux'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '7',
    name: 'Agriculture et Environnement',
    subCategories: [
      SubCategory(
        id: '7_1',
        name: 'Agriculture Urbaine',
        services: [
          Service(id: '7_1_1', name: 'Agriculteur urbain'),
          Service(id: '7_1_2', name: 'Agriculteur bio'),
          Service(id: '7_1_3', name: 'Jardinier paysagiste'),
        ],
      ),
      SubCategory(
        id: '7_2',
        name: 'Élevage',
        services: [
          Service(id: '7_2_1', name: 'Éleveur de volailles'),
          Service(id: '7_2_2', name: 'Producteur de miel'),
          Service(id: '7_2_3', name: 'Éleveur d\'animaux de compagnie'),
        ],
      ),
      SubCategory(
        id: '7_3',
        name: 'Gestion Environnementale',
        services: [
          Service(id: '7_3_1', name: 'Gestionnaire de la collecte des déchets'),
          Service(id: '7_3_2', name: 'Spécialiste en énergie solaire'),
          Service(id: '7_3_3', name: 'Gestionnaire de compostage'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '8',
    name: 'Services Alimentaires',
    subCategories: [
      SubCategory(
        id: '8_1',
        name: 'Restauration Mobile',
        services: [
          Service(id: '8_1_1', name: 'Vendeur ambulant de snacks'),
          Service(id: '8_1_2', name: 'Vendeur de rue de produits alimentaires'),
        ],
      ),
      SubCategory(
        id: '8_2',
        name: 'Production Alimentaire',
        services: [
          Service(id: '8_2_1', name: 'Traiteur'),
          Service(id: '8_2_2', name: 'Fabricant de pâtisseries artisanales'),
          Service(id: '8_2_3', name: 'Vendeur de boissons artisanales'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '9',
    name: 'Commerce de Détail',
    subCategories: [
      SubCategory(
        id: '9_1',
        name: 'Produits Artisanaux',
        services: [
          Service(id: '9_1_1', name: 'Vendeur de produits artisanaux'),
          Service(id: '9_1_2', name: 'Revendeur de bijoux faits main'),
        ],
      ),
      SubCategory(
        id: '9_2',
        name: 'Produits Bio et Naturels',
        services: [
          Service(id: '9_2_1', name: 'Distributeur de produits bio'),
          Service(id: '9_2_2', name: 'Distributeur de produits de beauté naturels'),
          Service(id: '9_2_3', name: 'Distributeur de produits de nettoyage écologiques'),
        ],
      ),
      SubCategory(
        id: '9_3',
        name: 'Vente d\'Occasion',
        services: [
          Service(id: '9_3_1', name: 'Revendeur de vêtements d\'occasion'),
          Service(id: '9_3_2', name: 'Vendeur de meubles d\'occasion'),
        ],
      ),
    ],
  ),
  JobCategory(
    id: '10',
    name: 'Services Professionnels Avancés',
    subCategories: [
      SubCategory(
        id: '10_1',
        name: 'Conseil Spécialisé',
        services: [
          Service(id: '10_1_1', name: 'Consultant en éco-tourisme'),
          Service(id: '10_1_2', name: 'Conseiller en gestion de l\'énergie'),
          Service(id: '10_1_3', name: 'Spécialiste en sécurité alimentaire'),
        ],
      ),
      SubCategory(
        id: '10_2',
        name: 'Services Techniques',
        services: [
          Service(id: '10_2_1', name: 'Spécialiste en réparation de motos'),
          Service(id: '10_2_2', name: 'Gestionnaire de location de matériel'),
        ],
      ),
    ],
  ),
];
