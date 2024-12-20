import 'package:flutter/material.dart';

class EmployeeListItem extends StatelessWidget {
  final String name;
  final String position;
  final String department;
  final String imageUrl;

  const EmployeeListItem({
    super.key,
    required this.name,
    required this.position,
    required this.department,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          onBackgroundImageError: (exception, stackTrace) {},
          child: const Icon(Icons.person),
        ),
        title: Text(name),
        subtitle: Text('$position - $department'),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'profile',
              child: Text('Voir le profil'),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Text('Modifier'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Supprimer'),
            ),
          ],
          onSelected: (value) {
            // TODO: Implémenter les actions
          },
        ),
        onTap: () {
          // TODO: Naviguer vers le profil de l'employé
        },
      ),
    );
  }
}
