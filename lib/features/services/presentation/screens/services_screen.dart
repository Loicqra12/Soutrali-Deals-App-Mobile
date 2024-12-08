import 'package:flutter/material.dart';
import '../../data/models/service_group.dart';
import 'service_category_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<ServiceGroup> _groups = [
    ServiceGroup(
      id: '1',
      name: 'Artisanat',
      icon: Icons.build,
      categories: [
        ServiceCategory(
          id: '1',
          name: 'Menuiserie',
          icon: Icons.carpenter,
          subCategories: [
            ServiceSubCategory(
              id: '1',
              name: 'Meubles sur mesure',
              description: 'Création de meubles personnalisés selon vos besoins',
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Soutrali Deals',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          final group = _groups[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  group.icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text(
                group.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
