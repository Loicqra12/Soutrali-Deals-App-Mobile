import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/domain/models/user_type.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Mon Profil',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/profile/edit-profile');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // En-tête du profil
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF27AE60).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Particulier',
                      style: TextStyle(
                        color: Color(0xFF27AE60),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Mes informations
            _buildSection(
              title: 'Mes informations',
              children: [
                _buildInfoTile(
                  icon: Icons.email,
                  title: 'Email',
                  subtitle: 'john.doe@example.com',
                ),
                _buildInfoTile(
                  icon: Icons.phone,
                  title: 'Téléphone',
                  subtitle: '+1 234 567 890',
                ),
                _buildInfoTile(
                  icon: Icons.location_on,
                  title: 'Adresse',
                  subtitle: '123 Rue Example, Ville',
                ),
                _buildInfoTile(
                  icon: Icons.calendar_today,
                  title: 'Membre depuis',
                  subtitle: 'Janvier 2024',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Mes activités
            _buildSection(
              title: 'Mes activités',
              children: [
                _buildActionTile(
                  icon: Icons.shopping_bag,
                  title: 'Mes commandes',
                  onTap: () {
                    // TODO: Navigate to orders
                  },
                ),
                _buildActionTile(
                  icon: Icons.favorite,
                  title: 'Mes favoris',
                  onTap: () {
                    context.push('/profile/favorites');
                  },
                ),
                _buildActionTile(
                  icon: Icons.history,
                  title: 'Historique',
                  onTap: () {
                    context.push('/profile/history');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Paramètres
            _buildSection(
              title: 'Paramètres',
              children: [
                _buildActionTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {
                    context.push('/profile/notifications');
                  },
                ),
                _buildActionTile(
                  icon: Icons.lock,
                  title: 'Confidentialité',
                  onTap: () {
                    context.push('/profile/privacy');
                  },
                ),
                _buildActionTile(
                  icon: Icons.language,
                  title: 'Langue',
                  onTap: () {
                    context.push('/profile/language');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Support
            _buildSection(
              title: 'Support',
              children: [
                _buildActionTile(
                  icon: Icons.help,
                  title: 'Centre d\'aide',
                  onTap: () {
                    context.push('/help');
                  },
                ),
                _buildActionTile(
                  icon: Icons.message,
                  title: 'Contactez-nous',
                  onTap: () {
                    context.push('/profile/contact');
                  },
                ),
                _buildActionTile(
                  icon: Icons.logout,
                  title: 'Déconnexion',
                  onTap: () {
                    // TODO: Implement logout
                  },
                  textColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF27AE60)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? const Color(0xFF27AE60)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
