import 'package:flutter/material.dart';

class AppointmentListItem extends StatelessWidget {
  final String clientName;
  final String date;
  final String time;
  final String service;

  const AppointmentListItem({
    super.key,
    required this.clientName,
    required this.date,
    required this.time,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(clientName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service: $service'),
            Text('$date à $time'),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'confirm',
              child: Text('Confirmer'),
            ),
            const PopupMenuItem(
              value: 'reschedule',
              child: Text('Reprogrammer'),
            ),
            const PopupMenuItem(
              value: 'cancel',
              child: Text('Annuler'),
            ),
          ],
          onSelected: (value) {
            // TODO: Implémenter les actions
          },
        ),
      ),
    );
  }
}
