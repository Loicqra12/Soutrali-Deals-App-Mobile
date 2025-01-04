class JobCategory {
  final String id;
  final String name;
  final List<SubCategory> subCategories;

  JobCategory({
    required this.id,
    required this.name,
    required this.subCategories,
  });
}

class SubCategory {
  final String id;
  final String name;
  final List<Service> services;

  SubCategory({
    required this.id,
    required this.name,
    required this.services,
  });
}

class Service {
  final String id;
  final String name;
  final String? description;

  Service({
    required this.id,
    required this.name,
    this.description,
  });
}
