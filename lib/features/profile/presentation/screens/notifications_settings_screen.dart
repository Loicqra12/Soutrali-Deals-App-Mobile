import 'package:flutter/material.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  // État des notifications
  bool _pushEnabled = true;
  bool _emailEnabled = true;
  bool _smsEnabled = false;

  // Notifications spécifiques
  bool _newDealsNotif = true;
  bool _orderStatusNotif = true;
  bool _promotionalNotif = false;
  bool _newsletterNotif = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Notifications',
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
            _buildSectionTitle('Canaux de notification'),
            _buildNotificationChannel(
              title: 'Notifications push',
              subtitle: 'Recevoir des notifications sur votre appareil',
              value: _pushEnabled,
              onChanged: (value) {
                setState(() {
                  _pushEnabled = value;
                });
              },
            ),
            _buildNotificationChannel(
              title: 'Email',
              subtitle: 'Recevoir des notifications par email',
              value: _emailEnabled,
              onChanged: (value) {
                setState(() {
                  _emailEnabled = value;
                });
              },
            ),
            _buildNotificationChannel(
              title: 'SMS',
              subtitle: 'Recevoir des notifications par SMS',
              value: _smsEnabled,
              onChanged: (value) {
                setState(() {
                  _smsEnabled = value;
                });
              },
            ),
            const Divider(),
            _buildSectionTitle('Types de notifications'),
            _buildNotificationType(
              title: 'Nouvelles offres',
              subtitle: 'Soyez informé des nouvelles offres disponibles',
              value: _newDealsNotif,
              onChanged: (value) {
                setState(() {
                  _newDealsNotif = value;
                });
              },
            ),
            _buildNotificationType(
              title: 'Statut des commandes',
              subtitle: 'Suivez l\'état de vos commandes en temps réel',
              value: _orderStatusNotif,
              onChanged: (value) {
                setState(() {
                  _orderStatusNotif = value;
                });
              },
            ),
            _buildNotificationType(
              title: 'Promotions',
              subtitle: 'Recevez des offres promotionnelles exclusives',
              value: _promotionalNotif,
              onChanged: (value) {
                setState(() {
                  _promotionalNotif = value;
                });
              },
            ),
            _buildNotificationType(
              title: 'Newsletter',
              subtitle: 'Restez informé des dernières actualités',
              value: _newsletterNotif,
              onChanged: (value) {
                setState(() {
                  _newsletterNotif = value;
                });
              },
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Note: Vous pouvez modifier ces paramètres à tout moment.',
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

  Widget _buildNotificationChannel({
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

  Widget _buildNotificationType({
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
}
