import 'package:flutter/material.dart';

class ActivityListItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  const ActivityListItem({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          // TODO: Afficher plus de détails sur l'activité
        },
      ),
    );
  }
}
