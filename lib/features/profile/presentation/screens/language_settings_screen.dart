import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'fr';

  final List<Map<String, String>> _languages = [
    {
      'code': 'fr',
      'name': 'Français',
      'flag': '🇫🇷',
    },
    {
      'code': 'en',
      'name': 'English',
      'flag': '🇬🇧',
    },
    {
      'code': 'es',
      'name': 'Español',
      'flag': '🇪🇸',
    },
    {
      'code': 'de',
      'name': 'Deutsch',
      'flag': '🇩🇪',
    },
    {
      'code': 'it',
      'name': 'Italiano',
      'flag': '🇮🇹',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Langue',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF27AE60).withOpacity(0.1),
            child: const Text(
              'Sélectionnez votre langue préférée',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final language = _languages[index];
                return RadioListTile(
                  title: Row(
                    children: [
                      Text(
                        language['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        language['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  value: language['code']!,
                  groupValue: _selectedLanguage,
                  activeColor: const Color(0xFF27AE60),
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value.toString();
                    });
                    // TODO: Implement language change
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Langue changée en ${language['name']}'),
                        backgroundColor: const Color(0xFF27AE60),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'L\'application redémarrera pour appliquer les changements',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
