import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/models/user.dart';
import '../widgets/provider_stats_card.dart';
import '../widgets/service_list_item.dart';
import '../widgets/appointment_list_item.dart';

class ProviderDashboard extends StatefulWidget {
  const ProviderDashboard({super.key});

  @override
  State<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Prestataire'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implémenter les notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Statistiques
            Row(
              children: [
                Expanded(
                  child: ProviderStatsCard(
                    title: 'Services Actifs',
                    value: '12',
                    icon: Icons.work,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ProviderStatsCard(
                    title: 'Rendez-vous',
                    value: '5',
                    icon: Icons.calendar_today,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Section Services
            const Text(
              'Mes Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // TODO: Remplacer par la vraie liste
              itemBuilder: (context, index) {
                return const ServiceListItem(
                  title: 'Service Example',
                  price: '100€',
                  status: 'Actif',
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Section Rendez-vous
            const Text(
              'Prochains Rendez-vous',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // TODO: Remplacer par la vraie liste
              itemBuilder: (context, index) {
                return const AppointmentListItem(
                  clientName: 'Client Example',
                  date: '12 Dec 2024',
                  time: '14:00',
                  service: 'Service Example',
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Ajouter un nouveau service
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
