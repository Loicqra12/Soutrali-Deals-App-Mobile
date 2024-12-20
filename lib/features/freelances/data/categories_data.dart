import '../domain/models/category.dart';

final List<FreelanceCategory> freelanceCategories = [
  FreelanceCategory(
    id: '1',
    name: 'Développement Web',
    icon: '💻',
    subcategories: [
      FreelanceSubcategory(id: '1_1', name: 'Frontend'),
      FreelanceSubcategory(id: '1_2', name: 'Backend'),
      FreelanceSubcategory(id: '1_3', name: 'Full Stack'),
      FreelanceSubcategory(id: '1_4', name: 'WordPress'),
    ],
  ),
  FreelanceCategory(
    id: '2',
    name: 'Design',
    icon: '🎨',
    subcategories: [
      FreelanceSubcategory(id: '2_1', name: 'UI/UX Design'),
      FreelanceSubcategory(id: '2_2', name: 'Graphic Design'),
      FreelanceSubcategory(id: '2_3', name: 'Logo Design'),
      FreelanceSubcategory(id: '2_4', name: 'Illustration'),
    ],
  ),
  FreelanceCategory(
    id: '3',
    name: 'Marketing Digital',
    icon: '📱',
    subcategories: [
      FreelanceSubcategory(id: '3_1', name: 'Social Media'),
      FreelanceSubcategory(id: '3_2', name: 'SEO'),
      FreelanceSubcategory(id: '3_3', name: 'Content Marketing'),
      FreelanceSubcategory(id: '3_4', name: 'Email Marketing'),
    ],
  ),
  FreelanceCategory(
    id: '4',
    name: 'Rédaction',
    icon: '✍️',
    subcategories: [
      FreelanceSubcategory(id: '4_1', name: 'Copywriting'),
      FreelanceSubcategory(id: '4_2', name: 'Articles'),
      FreelanceSubcategory(id: '4_3', name: 'Traduction'),
      FreelanceSubcategory(id: '4_4', name: 'Relecture'),
    ],
  ),
  FreelanceCategory(
    id: '5',
    name: 'Photo & Vidéo',
    icon: '📸',
    subcategories: [
      FreelanceSubcategory(id: '5_1', name: 'Photographie'),
      FreelanceSubcategory(id: '5_2', name: 'Montage Vidéo'),
      FreelanceSubcategory(id: '5_3', name: 'Animation'),
      FreelanceSubcategory(id: '5_4', name: 'Motion Design'),
    ],
  ),
];
