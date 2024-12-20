import 'package:flutter/material.dart';

class ServiceListItem extends StatelessWidget {
  final String title;
  final String price;
  final String status;

  const ServiceListItem({
    super.key,
    required this.title,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text('Prix: $price'),
        trailing: Chip(
          label: Text(
            status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: status == 'Actif' ? Colors.green : Colors.grey,
        ),
        onTap: () {
          // TODO: Naviguer vers les détails du service
        },
      ),
    );
  }
}
