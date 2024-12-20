import 'package:flutter/material.dart';

class AddressManagementScreen extends StatefulWidget {
  const AddressManagementScreen({Key? key}) : super(key: key);

  @override
  State<AddressManagementScreen> createState() => _AddressManagementScreenState();
}

class _AddressManagementScreenState extends State<AddressManagementScreen> {
  final List<Map<String, dynamic>> _addresses = [
    {
      'id': '1',
      'type': 'Domicile',
      'name': 'John Doe',
      'address': '123 Rue Principale',
      'city': 'Paris',
      'postalCode': '75001',
      'phone': '+33 1 23 45 67 89',
      'isDefault': true,
    },
    {
      'id': '2',
      'type': 'Bureau',
      'name': 'John Doe',
      'address': '456 Avenue du Travail',
      'city': 'Paris',
      'postalCode': '75008',
      'phone': '+33 9 87 65 43 21',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27AE60),
        title: const Text(
          'Mes adresses',
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
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFF27AE60),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Gérez vos adresses de livraison',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          address['type'] == 'Domicile'
                              ? Icons.home
                              : Icons.business,
                          color: const Color(0xFF27AE60),
                        ),
                        title: Row(
                          children: [
                            Text(
                              address['type'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (address['isDefault']) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF27AE60).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Par défaut',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF27AE60),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(address['name']),
                            Text(address['address']),
                            Text('${address['postalCode']} ${address['city']}'),
                            Text(address['phone']),
                          ],
                        ),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            switch (value) {
                              case 'edit':
                                _showAddEditAddressDialog(context, address);
                                break;
                              case 'delete':
                                _showDeleteConfirmation(context, index);
                                break;
                              case 'default':
                                _setAsDefault(index);
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('Modifier'),
                                ],
                              ),
                            ),
                            if (!address['isDefault'])
                              const PopupMenuItem(
                                value: 'default',
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle),
                                    SizedBox(width: 8),
                                    Text('Définir par défaut'),
                                  ],
                                ),
                              ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Supprimer', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF27AE60),
        onPressed: () => _showAddEditAddressDialog(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddEditAddressDialog(BuildContext context, Map<String, dynamic>? address) {
    // TODO: Implement add/edit address dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(address == null ? 'Ajouter une adresse' : 'Modifier l\'adresse'),
        content: const Text('Fonctionnalité à venir'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'adresse'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cette adresse ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _addresses.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Adresse supprimée'),
                  backgroundColor: Color(0xFF27AE60),
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

  void _setAsDefault(int index) {
    setState(() {
      for (var address in _addresses) {
        address['isDefault'] = false;
      }
      _addresses[index]['isDefault'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Adresse définie par défaut'),
        backgroundColor: Color(0xFF27AE60),
      ),
    );
  }
}
