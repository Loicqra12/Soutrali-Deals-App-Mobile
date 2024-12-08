import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_text_field.dart';
import '../../domain/models/user_type.dart';

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
  bool _isLoading = false;

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
      setState(() => _isLoading = true);

      try {
        // TODO: Implement registration logic
        await Future.delayed(const Duration(seconds: 2)); // Simulate API call
        
        if (mounted) {
          // Show verification dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text('Vérification requise'),
              content: const Text(
                'Un code de vérification a été envoyé à votre adresse email/numéro de téléphone.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.go('/verify-email');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
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
      body: SafeArea(
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF27AE60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
