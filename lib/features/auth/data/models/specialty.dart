enum Specialty {
  plumber('Plombier'),
  electrician('Électricien'),
  carpenter('Menuisier'),
  painter('Peintre'),
  mason('Maçon'),
  mechanic('Mécanicien'),
  hairdresser('Coiffeur'),
  tailor('Couturier'),
  gardener('Jardinier'),
  cleaner('Agent d\'entretien'),
  other('Autre');

  final String label;
  const Specialty(this.label);
}
