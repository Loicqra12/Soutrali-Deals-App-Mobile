import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterTypeScreen extends StatefulWidget {
  const RegisterTypeScreen({super.key});

  @override
  State<RegisterTypeScreen> createState() => _RegisterTypeScreenState();
}

class _RegisterTypeScreenState extends State<RegisterTypeScreen> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Créez un compte',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pour bénéficier d\'une expérience personnalisée sur notre service, il est important de fournir des informations sur votre activité et vos centres d\'intérêts.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Sélectionnez :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildTypeOption('Particulier'),
              _buildTypeOption('Prestataire'),
              _buildTypeOption('Vendeur'),
              _buildTypeOption('Entreprise'),
              const Spacer(),
              ElevatedButton(
                onPressed: selectedType != null
                    ? () => context.go('/register/${selectedType?.toLowerCase()}')
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27AE60),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Je crée un compte !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Voulez vous créez plutôt un compte professionnel ? ',
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement professional account creation
                    },
                    child: const Text(
                      'Clique ici !',
                      style: TextStyle(
                        color: Color(0xFF27AE60),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeOption(String type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () => setState(() => selectedType = type),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedType == type
                  ? const Color(0xFF27AE60)
                  : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedType == type
                        ? const Color(0xFF27AE60)
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: selectedType == type
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          size: 16,
                          color: Color(0xFF27AE60),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 15),
              Text(
                type,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
