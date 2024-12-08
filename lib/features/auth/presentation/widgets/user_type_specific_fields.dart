import 'package:flutter/material.dart';
import '../../data/models/user_type.dart';
import '../../data/models/specialty.dart';
import '../../data/models/seller_category.dart';

class UserTypeSpecificFields extends StatelessWidget {
  final UserType userType;
  final GlobalKey<FormState> formKey;

  const UserTypeSpecificFields({
    super.key,
    required this.userType,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    switch (userType) {
      case UserType.particular:
        return _buildParticularFields();
      case UserType.provider:
        return _buildProviderFields();
      case UserType.company:
        return _buildCompanyFields();
      case UserType.seller:
        return _buildSellerFields();
      default:
        return const SizedBox();
    }
  }

  Widget _buildParticularFields() {
    return Column(
      children: [
        const Text(
          'Informations personnelles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Adresse',
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre adresse';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildProviderFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations professionnelles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<Specialty>(
          decoration: const InputDecoration(
            labelText: 'Spécialité',
            prefixIcon: Icon(Icons.work_outline),
          ),
          items: Specialty.values.map((specialty) {
            return DropdownMenuItem(
              value: specialty,
              child: Text(specialty.label),
            );
          }).toList(),
          onChanged: (value) {},
          validator: (value) {
            if (value == null) {
              return 'Veuillez sélectionner votre spécialité';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Expérience professionnelle (années)',
            prefixIcon: Icon(Icons.timeline),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        const Text(
          'Note : Une pièce d\'identité sera requise pour la vérification.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations de l\'entreprise',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nom de l\'entreprise',
            prefixIcon: Icon(Icons.business),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer le nom de l\'entreprise';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Numéro RCCM',
            prefixIcon: Icon(Icons.numbers),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer le numéro RCCM';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email professionnel',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer l\'email professionnel';
            }
            if (!value.contains('@')) {
              return 'Veuillez entrer un email valide';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Note : Les documents de l\'entreprise seront requis pour la vérification.',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSellerFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations du vendeur',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Nom/Pseudonyme du vendeur',
            prefixIcon: Icon(Icons.store),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre nom de vendeur';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Adresse de livraison principale',
            prefixIcon: Icon(Icons.local_shipping),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer l\'adresse de livraison';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<SellerCategory>(
          decoration: const InputDecoration(
            labelText: 'Catégorie principale',
            prefixIcon: Icon(Icons.category),
          ),
          items: SellerCategory.values.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.label),
            );
          }).toList(),
          onChanged: (value) {},
          validator: (value) {
            if (value == null) {
              return 'Veuillez sélectionner une catégorie';
            }
            return null;
          },
        ),
      ],
    );
  }
}
