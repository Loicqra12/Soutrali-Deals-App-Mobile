enum SellerCategory {
  clothing('Vêtements'),
  electronics('Électronique'),
  furniture('Mobilier'),
  food('Alimentation'),
  beauty('Beauté'),
  sports('Sport'),
  toys('Jouets'),
  books('Livres'),
  automotive('Automobile'),
  other('Autre');

  final String label;
  const SellerCategory(this.label);
}
