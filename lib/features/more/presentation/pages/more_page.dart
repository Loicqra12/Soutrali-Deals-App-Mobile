import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plus'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildUserHeader(),
          const SizedBox(height: 24),
          _buildSection(
            'Mes activités',
            [
              _buildMenuItem(
                icon: Icons.shopping_bag,
                title: 'Mes commandes',
                onTap: () => context.push('/orders'),
              ),
              _buildMenuItem(
                icon: Icons.favorite,
                title: 'Favoris',
                onTap: () => context.push('/favorites'),
              ),
              _buildMenuItem(
                icon: Icons.star,
                title: 'Avis',
                onTap: () => context.push('/reviews'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Paramètres',
            [
              _buildMenuItem(
                icon: Icons.person,
                title: 'Mon profil',
                onTap: () => context.push('/profile'),
              ),
              _buildMenuItem(
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () => context.push('/notification-settings'),
              ),
              _buildMenuItem(
                icon: Icons.language,
                title: 'Langue',
                onTap: () => context.push('/language'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Support',
            [
              _buildMenuItem(
                icon: Icons.help,
                title: 'Aide',
                onTap: () => context.push('/help'),
              ),
              _buildMenuItem(
                icon: Icons.info,
                title: 'À propos',
                onTap: () => context.push('/about'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildLogoutButton(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildUserHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[200],
          child: const Icon(
            Icons.person,
            size: 40,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'john.doe@example.com',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF27AE60)),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Implémenter la déconnexion
        },
        icon: const Icon(Icons.logout),
        label: const Text('Déconnexion'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
