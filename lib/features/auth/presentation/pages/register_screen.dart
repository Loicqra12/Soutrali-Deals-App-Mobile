import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_text_field.dart';
import '../../domain/models/user_type.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  final UserType userType;

  const RegisterScreen({
    super.key,
    required this.userType,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each required field
    for (var field in widget.userType.requiredFields) {
      _controllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _controllers['Adresse e-mail']?.text ?? 
                   _controllers['Adresse e-mail ou numéro de téléphone']?.text ??
                   _controllers['Adresse e-mail professionnelle']?.text;
      
      final password = _controllers['Mot de passe']?.text ?? '';
      final fullName = _controllers['Nom complet']?.text ?? 
                      _controllers['Nom ou pseudonyme']?.text ??
                      _controllers['Nom de l\'entreprise']?.text;
      final phoneNumber = _controllers['Numéro de téléphone']?.text;

      // Vérifier si les champs requis sont présents
      if (email == null || email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('L\'adresse e-mail est requise'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (fullName == null || fullName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Le nom est requis'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Créer un Map pour les informations additionnelles spécifiques au type d'utilisateur
      final additionalInfo = <String, dynamic>{};
      for (var field in widget.userType.requiredFields) {
        if (!['Adresse e-mail', 'Mot de passe', 'Nom complet', 'Numéro de téléphone']
            .contains(field)) {
          final value = _controllers[field]?.text;
          if (value != null && value.isNotEmpty) {
            additionalInfo[field] = value;
          }
        }
      }

      context.read<AuthBloc>().add(
            RegisterSubmitted(
              email: email,
              password: password,
              fullName: fullName,
              userType: widget.userType,
              phoneNumber: phoneNumber,
              additionalInfo: additionalInfo,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Inscription ${widget.userType.label}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthAuthenticated) {
            // Rediriger vers la page appropriée
            switch (widget.userType) {
              case UserType.particular:
                context.go('/customer/home');
                break;
              case UserType.provider:
                context.go('/provider/dashboard');
                break;
              case UserType.seller:
                context.go('/seller/dashboard');
                break;
              case UserType.business:
                context.go('/business/dashboard');
                break;
            }
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Remplissez les informations suivantes :',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...widget.userType.requiredFields.map((field) {
                    bool isPassword = field.toLowerCase().contains('mot de passe');
                    bool isEmail = field.toLowerCase().contains('email');
                    bool isPhone = field.toLowerCase().contains('téléphone');
                    bool isOptional = field.toLowerCase().contains('optionnel');

                    return CustomTextField(
                      label: field,
                      controller: _controllers[field]!,
                      isPassword: isPassword,
                      isOptional: isOptional,
                      keyboardType: isEmail
                          ? TextInputType.emailAddress
                          : isPhone
                              ? TextInputType.phone
                              : TextInputType.text,
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: state is AuthLoading
                              ? null
                              : _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF27AE60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: state is AuthLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Créer mon compte',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
