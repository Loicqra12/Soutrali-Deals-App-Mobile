import 'package:flutter/material.dart';
import '../../data/models/user_type.dart';
import '../widgets/registration_step_indicator.dart';
import '../widgets/user_type_specific_fields.dart';
import '../widgets/document_upload.dart';
import '../screens/verification_screen.dart';
import '../../../../core/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentStep = 0;
  UserType? _selectedUserType;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _profileImagePath;
  String? _documentPath;
  bool _obscurePassword = true;
  bool _isEmailVerified = false;
  bool _isPhoneVerified = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  void _nextStep() {
    if (_currentStep == 0 && _selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner un type de compte')),
      );
      return;
    }

    if (_currentStep == 1 && !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      if (_currentStep < 3) {
        _currentStep++;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousStep,
              )
            : null,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          RegistrationStepIndicator(
            currentStep: _currentStep,
            totalSteps: 4,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildStepContent(),
          ),
          if (_currentStep < 3)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: Text(
                  _currentStep == 2 ? 'Terminer' : 'Suivant',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildUserTypeSelection();
      case 1:
        return _buildBasicInfo();
      case 2:
        if (_selectedUserType == null) {
          return const Center(
            child: Text('Veuillez sélectionner un type de compte'),
          );
        }
        return Column(
          children: [
            UserTypeSpecificFields(
              userType: _selectedUserType!,
              formKey: _formKey,
            ),
            const SizedBox(height: 24),
            DocumentUpload(
              userType: _selectedUserType!,
              onDocumentPicked: (path) {
                setState(() {
                  _documentPath = path;
                });
              },
            ),
          ],
        );
      case 3:
        return _buildVerificationStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildUserTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        // Logo
        SvgPicture.asset(
          'assets/images/logo.svg',
          height: 120,
        ),
        const SizedBox(height: 32),
        Text(
          'Choisissez votre type de compte',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            _buildUserTypeCard(
              UserType.particular,
              'Particulier',
              Icons.person_outline,
              'Pour les utilisateurs individuels',
            ),
            _buildUserTypeCard(
              UserType.provider,
              'Prestataire',
              Icons.handyman_outlined,
              'Pour les professionnels de service',
            ),
            _buildUserTypeCard(
              UserType.company,
              'Entreprise',
              Icons.business_outlined,
              'Pour les sociétés',
            ),
            _buildUserTypeCard(
              UserType.seller,
              'Vendeur',
              Icons.store_outlined,
              'Pour les commerçants',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserTypeCard(
    UserType type,
    String title,
    IconData icon,
    String description,
  ) {
    final isSelected = _selectedUserType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedUserType = type;
        });
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: isSelected ? AppTheme.primaryColor : Colors.grey.shade600,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppTheme.primaryColor : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildProfileImagePicker(),
          const SizedBox(height: 24),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nom complet',
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre nom';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              if (!value.contains('@')) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Mot de passe',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              if (value.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Numéro de téléphone',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre numéro de téléphone';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: _profileImagePath != null
                ? AssetImage(_profileImagePath!)
                : null,
            child: _profileImagePath == null
                ? const Icon(Icons.person, size: 50, color: Colors.grey)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              radius: 18,
              child: IconButton(
                icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                onPressed: () => _showImageSourceDialog(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showImageSourceDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir une source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Appareil photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galerie'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vérification',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Pour finaliser votre inscription, nous devons vérifier votre identité.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 32),
        ListTile(
          leading: const Icon(Icons.email_outlined),
          title: const Text('Vérification par email'),
          subtitle: Text(_emailController.text),
          trailing: TextButton(
            onPressed: () => _startVerification(true),
            child: const Text('Vérifier'),
          ),
        ),
        if (_phoneController.text.isNotEmpty) ...[
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text('Vérification par SMS'),
            subtitle: Text(_phoneController.text),
            trailing: TextButton(
              onPressed: () => _startVerification(false),
              child: const Text('Vérifier'),
            ),
          ),
        ],
        const SizedBox(height: 24),
        if (_selectedUserType != UserType.particular) ...[
          const Divider(),
          const SizedBox(height: 16),
          Text(
            _selectedUserType == UserType.provider
                ? 'Votre pièce d\'identité sera vérifiée par notre équipe'
                : 'Vos documents seront vérifiés par notre équipe',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cette étape peut prendre 24 à 48 heures',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _startVerification(bool isEmail) async {
    final contact = isEmail ? _emailController.text : _phoneController.text;
    final verified = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          contactInfo: contact,
          isEmail: isEmail,
        ),
      ),
    );

    if (verified == true) {
      setState(() {
        if (isEmail) {
          _isEmailVerified = true;
        } else {
          _isPhoneVerified = true;
        }
      });

      if (_isEmailVerified || _isPhoneVerified) {
        _completeRegistration();
      }
    }
  }

  void _completeRegistration() {
    // TODO: Implémenter l'envoi des données au backend
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Inscription réussie !'),
        content: Text(
          _selectedUserType != UserType.particular
              ? 'Votre compte a été créé. Nos équipes vérifieront vos documents dans les plus brefs délais.'
              : 'Votre compte a été créé avec succès.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Naviguer vers l'écran principal
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
