import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/signup_bloc.dart';

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
                'Particulier',
                'Pour les utilisateurs qui souhaitent acheter des produits',
                Icons.person,
                AccountType.particular,
              ),
              const SizedBox(height: 16),
              _buildAccountTypeCard(
                context,
                'Fournisseur',
                'Pour les entreprises qui vendent des produits',
                Icons.business,
                AccountType.provider,
              ),
              const SizedBox(height: 16),
              _buildAccountTypeCard(
                context,
                'Vendeur',
                'Pour les revendeurs individuels',
                Icons.store,
                AccountType.seller,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTypeCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    AccountType type,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          context.read<SignupBloc>().add(AccountTypeSelected(type));
          // Navigate to next screen
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.green),
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
                      style: TextStyle(
                        color: Colors.grey[600],
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
