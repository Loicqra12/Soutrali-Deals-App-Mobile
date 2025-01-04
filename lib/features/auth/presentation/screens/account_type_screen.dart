import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/signup_bloc.dart';
import '../../domain/models/user_type.dart';
import 'registration_screen.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir un type de compte'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Quel type de compte souhaitez-vous créer ?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildAccountTypeCard(
                context,
                UserType.particular,
                'Particulier',
                Icons.person,
                'Achetez des produits et services',
              ),
              const SizedBox(height: 16),
              _buildAccountTypeCard(
                context,
                UserType.provider,
                'Prestataire',
                Icons.work,
                'Offrez vos services',
              ),
              const SizedBox(height: 16),
              _buildAccountTypeCard(
                context,
                UserType.seller,
                'Vendeur',
                Icons.store,
                'Vendez vos produits',
              ),
              const SizedBox(height: 16),
              _buildAccountTypeCard(
                context,
                UserType.business,
                'Entreprise',
                Icons.business,
                'Gérez votre entreprise',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTypeCard(
    BuildContext context,
    UserType type,
    String title,
    IconData icon,
    String description,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          String route = '/register/';
          switch (type) {
            case UserType.particular:
              route += 'particulier';
              break;
            case UserType.provider:
              route += 'prestataire';
              break;
            case UserType.seller:
              route += 'vendeur';
              break;
            case UserType.business:
              route += 'entreprise';
              break;
          }
          context.push(route);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 32, color: Colors.green),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
