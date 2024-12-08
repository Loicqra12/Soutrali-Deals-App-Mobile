import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late SharedPreferences _prefs;
  bool _bookingNotifications = true;
  bool _paymentNotifications = true;
  bool _messageNotifications = true;
  bool _promotionNotifications = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookingNotifications = _prefs.getBool('notification_booking') ?? true;
      _paymentNotifications = _prefs.getBool('notification_payment') ?? true;
      _messageNotifications = _prefs.getBool('notification_message') ?? true;
      _promotionNotifications = _prefs.getBool('notification_promotion') ?? true;
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres des notifications'),
      ),
      body: ListView(
        children: [
          _buildSection(
            'Notifications de réservation',
            'Recevez des notifications pour vos réservations',
            _bookingNotifications,
            (value) {
              setState(() {
                _bookingNotifications = value;
                _savePreference('notification_booking', value);
              });
            },
          ),
          _buildSection(
            'Notifications de paiement',
            'Recevez des notifications pour vos paiements',
            _paymentNotifications,
            (value) {
              setState(() {
                _paymentNotifications = value;
                _savePreference('notification_payment', value);
              });
            },
          ),
          _buildSection(
            'Notifications de messages',
            'Recevez des notifications pour vos messages',
            _messageNotifications,
            (value) {
              setState(() {
                _messageNotifications = value;
                _savePreference('notification_message', value);
              });
            },
          ),
          _buildSection(
            'Notifications de promotions',
            'Recevez des notifications pour les promotions',
            _promotionNotifications,
            (value) {
              setState(() {
                _promotionNotifications = value;
                _savePreference('notification_promotion', value);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF27AE60),
      ),
    );
  }
}
