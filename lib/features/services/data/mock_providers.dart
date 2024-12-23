import 'models/provider_model.dart';

final List<ServiceProvider> mockProviders = [
  ServiceProvider(
    id: '1',
    name: 'Atelier Koffi',
    description: 'Menuiserie artisanale de qualité',
    latitude: 5.3364,
    longitude: -4.0267,
    address: 'Cocody, Abidjan',
    phoneNumber: '+225 0708090910',
    email: 'atelier.koffi@email.com',
    rating: 4.8,
    reviewCount: 124,
    services: [
      'Meubles sur mesure',
      'Réparation de meubles',
      'Restauration',
    ],
    images: [
      'assets/images/menuiserie1.jpg',
      'assets/images/menuiserie2.jpg',
    ],
    category: 'Menuiserie',
    group: 'Artisanat',
  ),
  ServiceProvider(
    id: '2',
    name: 'Plomberie Express',
    description: 'Service de plomberie professionnel 24/7',
    latitude: 5.3410,
    longitude: -4.0170,
    address: 'Plateau, Abidjan',
    phoneNumber: '+225 0102030405',
    email: 'plomberie.express@email.com',
    rating: 4.6,
    reviewCount: 89,
    services: [
      'Installation plomberie',
      'Dépannage urgent',
      'Maintenance',
    ],
    images: [
      'assets/images/plomberie1.jpg',
      'assets/images/plomberie2.jpg',
    ],
    category: 'Plomberie',
    group: 'Artisanat',
  ),
  ServiceProvider(
    id: '3',
    name: 'DesignLab CI',
    description: 'Studio de design créatif',
    latitude: 5.3290,
    longitude: -4.0170,
    address: 'Marcory, Abidjan',
    phoneNumber: '+225 0506070809',
    email: 'designlab.ci@email.com',
    rating: 4.9,
    reviewCount: 156,
    services: [
      'Design graphique',
      'UI/UX Design',
      'Identité visuelle',
    ],
    images: [
      'assets/images/design1.jpg',
      'assets/images/design2.jpg',
    ],
    category: 'Design',
    group: 'Freelance',
  ),
  ServiceProvider(
    id: '4',
    name: 'ContentPro',
    description: 'Agence de rédaction et traduction',
    latitude: 5.3320,
    longitude: -4.0220,
    address: 'Treichville, Abidjan',
    phoneNumber: '+225 0708091011',
    email: 'contentpro@email.com',
    rating: 4.7,
    reviewCount: 92,
    services: [
      'Copywriting',
      'Traduction',
      'Rédaction web',
    ],
    images: [
      'assets/images/redaction1.jpg',
      'assets/images/redaction2.jpg',
    ],
    category: 'Rédaction',
    group: 'Freelance',
  ),
  ServiceProvider(
    id: '5',
    name: 'TechSolutions',
    description: 'Solutions informatiques complètes',
    latitude: 5.3380,
    longitude: -4.0190,
    address: 'Deux Plateaux, Abidjan',
    phoneNumber: '+225 0102030406',
    email: 'techsolutions@email.com',
    rating: 4.8,
    reviewCount: 178,
    services: [
      'Développement web',
      'Applications mobiles',
      'Installation réseau',
    ],
    images: [
      'assets/images/tech1.jpg',
      'assets/images/tech2.jpg',
    ],
    category: 'Développement',
    group: 'IT',
  ),
];
