import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Liste des FAQ
  final List<Map<String, dynamic>> _faqs = [
    {
      'category': 'Commandes',
      'icon': Icons.shopping_bag,
      'questions': [
        {
          'question': 'Comment suivre ma commande ?',
          'answer': 'Vous pouvez suivre votre commande dans la section "Mes commandes" de votre profil. Vous recevrez également des notifications sur l\'état de votre livraison.',
        },
        {
          'question': 'Comment annuler une commande ?',
          'answer': 'Pour annuler une commande, rendez-vous dans "Mes commandes", sélectionnez la commande concernée et cliquez sur "Annuler". Notez que l\'annulation n\'est possible que dans les 24h suivant la commande.',
        },
      ],
    },
    {
      'category': 'Compte',
      'icon': Icons.person,
      'questions': [
        {
          'question': 'Comment modifier mes informations personnelles ?',
          'answer': 'Accédez à votre profil, cliquez sur le bouton "Modifier" en haut à droite, puis mettez à jour vos informations selon vos besoins.',
        },
        {
          'question': 'Comment changer mon mot de passe ?',
          'answer': 'Dans les paramètres de votre compte, sélectionnez "Sécurité", puis "Modifier le mot de passe". Suivez ensuite les instructions à l\'écran.',
        },
      ],
    },
    {
      'category': 'Paiement',
      'icon': Icons.payment,
      'questions': [
        {
          'question': 'Quels modes de paiement acceptez-vous ?',
          'answer': 'Nous acceptons les cartes de crédit (Visa, Mastercard), PayPal, et les virements bancaires.',
        },
        {
          'question': 'Comment obtenir un remboursement ?',
          'answer': 'Pour demander un remboursement, contactez notre service client avec votre numéro de commande. Le traitement prend généralement 5-7 jours ouvrés.',
        },
      ],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Centre d\'aide',
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
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher une question...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF27AE60)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    // TODO: Implement search functionality
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Comment pouvons-nous vous aider ?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ..._faqs.map((category) => _buildCategorySection(category)),
                const SizedBox(height: 16),
                _buildContactSupport(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(Map<String, dynamic> category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(category['icon'] as IconData, color: const Color(0xFF27AE60)),
            const SizedBox(width: 8),
            Text(
              category['category'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(
          (category['questions'] as List).length,
          (index) => _buildFAQItem(category['questions'][index]),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFAQItem(Map<String, String> faq) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(
          faq['question']!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              faq['answer']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSupport() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vous n\'avez pas trouvé ce que vous cherchez ?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildContactOption(
                    icon: Icons.chat,
                    title: 'Chat en direct',
                    onTap: () {
                      // TODO: Implement live chat
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Démarrage du chat...'),
                          backgroundColor: Color(0xFF27AE60),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildContactOption(
                    icon: Icons.email,
                    title: 'Envoyer un email',
                    onTap: () {
                      // TODO: Implement email support
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ouverture de l\'email...'),
                          backgroundColor: Color(0xFF27AE60),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF27AE60).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF27AE60)),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
