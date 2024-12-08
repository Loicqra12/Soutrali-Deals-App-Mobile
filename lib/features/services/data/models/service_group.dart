import 'package:flutter/material.dart';

class ServiceGroup {
  final String id;
  final String name;
  final IconData icon;
  final List<ServiceCategory> categories;

  const ServiceGroup({
    required this.id,
    required this.name,
    required this.icon,
    required this.categories,
  });
}

class ServiceCategory {
  final String id;
  final String name;
  final IconData icon;
  final List<ServiceSubCategory> subCategories;

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.subCategories,
  });
}

class ServiceSubCategory {
  final String id;
  final String name;
  final String description;

  const ServiceSubCategory({
    required this.id,
    required this.name,
    required this.description,
  });
}
