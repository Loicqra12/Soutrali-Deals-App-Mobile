import 'package:flutter/material.dart';
import '../widgets/business_stats_card.dart';
import '../widgets/employee_list_item.dart';
import '../widgets/activity_list_item.dart';

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({super.key});

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Entreprise'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implémenter les notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Paramètres de l'entreprise
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF27AE60),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.business,
                      size: 30,
                      color: Color(0xFF27AE60),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nom de l\'entreprise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Employés'),
              onTap: () {
                // TODO: Navigation vers la liste des employés
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Rapports'),
              onTap: () {
                // TODO: Navigation vers les rapports
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Planning'),
              onTap: () {
                // TODO: Navigation vers le planning
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                // TODO: Navigation vers les paramètres
              },
            ),
          ],
        ),
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
                  child: BusinessStatsCard(
                    title: 'Employés',
                    value: '24',
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BusinessStatsCard(
                    title: 'Projets Actifs',
                    value: '8',
                    icon: Icons.work,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: BusinessStatsCard(
                    title: 'Tâches en cours',
                    value: '15',
                    icon: Icons.assignment,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BusinessStatsCard(
                    title: 'Performance',
                    value: '92%',
                    icon: Icons.trending_up,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Section Employés
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Employés',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Voir tous les employés
                  },
                  child: const Text('Voir tout'),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const EmployeeListItem(
                  name: 'John Doe',
                  position: 'Développeur',
                  department: 'IT',
                  imageUrl: 'https://example.com/image.jpg',
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Section Activités Récentes
            const Text(
              'Activités Récentes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ActivityListItem(
                  title: 'Nouveau projet créé',
                  description: 'Le projet "App Mobile" a été créé',
                  time: 'Il y a 2 heures',
                  icon: Icons.add_circle,
                  color: Colors.green,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Ajouter un nouvel employé ou projet
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
