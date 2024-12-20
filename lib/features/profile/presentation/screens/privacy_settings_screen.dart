import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({Key? key}) : super(key: key);

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // État des paramètres de confidentialité
  bool _profileVisible = true;
  bool _locationSharing = false;
  bool _activityVisible = true;
  bool _dataCollection = true;
  bool _personalisedAds = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Confidentialité',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSectionTitle('Visibilité du profil'),
            _buildPrivacyOption(
              title: 'Profil public',
              subtitle: 'Autoriser les autres utilisateurs à voir votre profil',
              value: _profileVisible,
              onChanged: (value) {
                setState(() {
                  _profileVisible = value;
                });
              },
            ),
            _buildPrivacyOption(
              title: 'Partage de localisation',
              subtitle: 'Autoriser l\'application à accéder à votre position',
              value: _locationSharing,
              onChanged: (value) {
                setState(() {
                  _locationSharing = value;
                });
              },
            ),
            _buildPrivacyOption(
              title: 'Activités visibles',
              subtitle: 'Afficher vos activités récentes aux autres utilisateurs',
              value: _activityVisible,
              onChanged: (value) {
                setState(() {
                  _activityVisible = value;
                });
              },
            ),
            const Divider(height: 32),
            _buildSectionTitle('Données et personnalisation'),
            _buildPrivacyOption(
              title: 'Collecte de données',
              subtitle: 'Autoriser la collecte de données pour améliorer votre expérience',
              value: _dataCollection,
              onChanged: (value) {
                setState(() {
                  _dataCollection = value;
                });
              },
            ),
            _buildPrivacyOption(
              title: 'Publicités personnalisées',
              subtitle: 'Recevoir des publicités basées sur vos centres d\'intérêt',
              value: _personalisedAds,
              onChanged: (value) {
                setState(() {
                  _personalisedAds = value;
                });
              },
            ),
            const Divider(height: 32),
            _buildSectionTitle('Actions de confidentialité'),
            _buildActionButton(
              title: 'Télécharger mes données',
              subtitle: 'Obtenir une copie de vos données personnelles',
              icon: Icons.download,
              onTap: () {
                // TODO: Implement data download
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Téléchargement des données initié'),
                    backgroundColor: Color(0xFF27AE60),
                  ),
                );
              },
            ),
            _buildActionButton(
              title: 'Supprimer mon compte',
              subtitle: 'Supprimer définitivement votre compte et vos données',
              icon: Icons.delete_forever,
              isDestructive: true,
              onTap: () {
                _showDeleteAccountDialog();
              },
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Pour plus d\'informations, consultez notre politique de confidentialité.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF27AE60),
        ),
      ),
    );
  }

  Widget _buildPrivacyOption({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
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
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF27AE60),
    );
  }

  Widget _buildActionButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : const Color(0xFF27AE60),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      onTap: onTap,
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le compte'),
        content: const Text(
          'Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible et toutes vos données seront définitivement supprimées.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement account deletion
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Compte supprimé avec succès'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
