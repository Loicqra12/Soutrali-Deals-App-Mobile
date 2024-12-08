import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceCategoryPage extends StatelessWidget {
  final String categoryId;

  const ServiceCategoryPage({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catégorie de services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implémenter le filtre
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Exemple avec 10 services
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.handyman,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              title: Text('Service ${index + 1}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Prestataire: John Doe'),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber[700]),
                      const Text(' 4.5 (120 avis)'),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(index + 1) * 1000} FCFA',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF27AE60),
                    ),
                  ),
                  const Text(
                    'par heure',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              onTap: () {
                context.push('/service/$index');
              },
            ),
          );
        },
      ),
    );
  }
}
