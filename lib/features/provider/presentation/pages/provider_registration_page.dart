import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animations/animations.dart';
import '../../data/models/job_category.dart';
import '../../data/models/job_data.dart';
import '../../data/services/provider_service.dart';

class ProviderRegistrationPage extends StatefulWidget {
  const ProviderRegistrationPage({super.key});

  @override
  State<ProviderRegistrationPage> createState() => _ProviderRegistrationPageState();
}

class _ProviderRegistrationPageState extends State<ProviderRegistrationPage> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final _providerService = ProviderService();
  
  // Informations personnelles
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  // Sélection métier
  JobCategory? _selectedCategory;
  SubCategory? _selectedSubCategory;
  Service? _selectedService;
  
  // Localisation
  final _addressController = TextEditingController();
  final _latitudeController = TextEditingController(text: '5.3484');
  final _longitudeController = TextEditingController(text: '-4.0305');
  double _serviceRadius = 5.0;
  
  // Documents
  File? _selfieImage;
  File? _cniRecto;
  File? _cniVerso;
  
  // Prix et disponibilité
  final _priceController = TextEditingController();
  List<bool> _availableDays = List.generate(7, (index) => true);

  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devenir Prestataire'),
        backgroundColor: const Color(0xFF27AE60),
      ),
      body: Form(
        key: _formKey,
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF27AE60),
              secondary: Colors.green[200]!,
            ),
          ),
          child: Stack(
            children: [
              Stepper(
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepTapped: (step) => setState(() => _currentStep = step),
                onStepContinue: () {
                  if (_currentStep < 4) {
                    setState(() => _currentStep++);
                  } else {
                    _submitForm();
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  }
                },
                steps: [
                  Step(
                    title: const Text('Profil'),
                    content: PageTransitionSwitcher(
                      transitionBuilder: (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                      child: _buildPersonalInfoStep(),
                    ),
                    isActive: _currentStep >= 0,
                  ),
                  Step(
                    title: const Text('Métier'),
                    content: PageTransitionSwitcher(
                      transitionBuilder: (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                      child: _buildJobSelectionStep(),
                    ),
                    isActive: _currentStep >= 1,
                  ),
                  Step(
                    title: const Text('Localisation'),
                    content: PageTransitionSwitcher(
                      transitionBuilder: (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                      child: _buildLocationStep(),
                    ),
                    isActive: _currentStep >= 2,
                  ),
                  Step(
                    title: const Text('Documents'),
                    content: PageTransitionSwitcher(
                      transitionBuilder: (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                      child: _buildDocumentsStep(),
                    ),
                    isActive: _currentStep >= 3,
                  ),
                  Step(
                    title: const Text('Tarifs'),
                    content: PageTransitionSwitcher(
                      transitionBuilder: (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                      child: _buildPricingStep(),
                    ),
                    isActive: _currentStep >= 4,
                  ),
                ],
              ),
              if (_isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Nom complet',
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Veuillez entrer votre nom';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Veuillez entrer votre email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Téléphone',
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Veuillez entrer votre numéro de téléphone';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildJobSelectionStep() {
    return Column(
      children: [
        DropdownButtonFormField<JobCategory>(
          value: _selectedCategory,
          decoration: const InputDecoration(
            labelText: 'Métier',
            prefixIcon: Icon(Icons.work),
          ),
          items: jobCategories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.name),
            );
          }).toList(),
          onChanged: (category) {
            setState(() {
              _selectedCategory = category;
              _selectedSubCategory = null;
              _selectedService = null;
            });
          },
        ),
        if (_selectedCategory != null) ...[
          const SizedBox(height: 16),
          DropdownButtonFormField<SubCategory>(
            value: _selectedSubCategory,
            decoration: const InputDecoration(
              labelText: 'Catégorie',
              prefixIcon: Icon(Icons.category),
            ),
            items: _selectedCategory!.subCategories.map((subCategory) {
              return DropdownMenuItem(
                value: subCategory,
                child: Text(subCategory.name),
              );
            }).toList(),
            onChanged: (subCategory) {
              setState(() {
                _selectedSubCategory = subCategory;
                _selectedService = null;
              });
            },
          ),
        ],
        if (_selectedSubCategory != null) ...[
          const SizedBox(height: 16),
          DropdownButtonFormField<Service>(
            value: _selectedService,
            decoration: const InputDecoration(
              labelText: 'Service',
              prefixIcon: Icon(Icons.miscellaneous_services),
            ),
            items: _selectedSubCategory!.services.map((service) {
              return DropdownMenuItem(
                value: service,
                child: Text(service.name),
              );
            }).toList(),
            onChanged: (service) {
              setState(() {
                _selectedService = service;
              });
            },
          ),
        ],
      ],
    );
  }

  Widget _buildLocationStep() {
    return Column(
      children: [
        TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
            labelText: 'Adresse complète',
            prefixIcon: Icon(Icons.location_on),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _latitudeController,
                decoration: const InputDecoration(
                  labelText: 'Latitude',
                  prefixIcon: Icon(Icons.north),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _longitudeController,
                decoration: const InputDecoration(
                  labelText: 'Longitude',
                  prefixIcon: Icon(Icons.east),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Rayon de service: '),
            Expanded(
              child: Slider(
                value: _serviceRadius,
                min: 1,
                max: 50,
                divisions: 49,
                label: '${_serviceRadius.round()} km',
                onChanged: (value) {
                  setState(() {
                    _serviceRadius = value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocumentsStep() {
    return Column(
      children: [
        _buildPhotoUploadCard(
          'Photo de profil',
          'Prenez un selfie professionnel',
          Icons.face,
          _selfieImage,
          (File? image) {
            setState(() => _selfieImage = image);
          },
        ),
        const SizedBox(height: 16),
        _buildPhotoUploadCard(
          'CNI Recto',
          'Téléchargez une photo claire de votre CNI (recto)',
          Icons.credit_card,
          _cniRecto,
          (File? image) {
            setState(() => _cniRecto = image);
          },
        ),
        const SizedBox(height: 16),
        _buildPhotoUploadCard(
          'CNI Verso',
          'Téléchargez une photo claire de votre CNI (verso)',
          Icons.credit_card,
          _cniVerso,
          (File? image) {
            setState(() => _cniVerso = image);
          },
        ),
      ],
    );
  }

  Widget _buildPhotoUploadCard(
    String title,
    String subtitle,
    IconData icon,
    File? image,
    Function(File?) onImageSelected,
  ) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, size: 48, color: const Color(0xFF27AE60)),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(subtitle),
          ),
          if (image != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(
                    image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => onImageSelected(null),
                  ),
                ],
              ),
            ),
          ButtonBar(
            children: [
              TextButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Appareil photo'),
                onPressed: () async {
                  final image = await _providerService.pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    onImageSelected(image);
                  }
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text('Galerie'),
                onPressed: () async {
                  final image = await _providerService.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    onImageSelected(image);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingStep() {
    return Column(
      children: [
        TextFormField(
          controller: _priceController,
          decoration: const InputDecoration(
            labelText: 'Prix moyen (FCFA)',
            prefixIcon: Icon(Icons.attach_money),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 24),
        const Text(
          'Jours de disponibilité',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            'Lun',
            'Mar',
            'Mer',
            'Jeu',
            'Ven',
            'Sam',
            'Dim',
          ].asMap().entries.map((entry) {
            return FilterChip(
              label: Text(entry.value),
              selected: _availableDays[entry.key],
              onSelected: (selected) {
                setState(() {
                  _availableDays[entry.key] = selected;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      try {
        final providerData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'category': _selectedCategory?.id,
          'subCategory': _selectedSubCategory?.id,
          'service': _selectedService?.id,
          'address': _addressController.text,
          'latitude': double.parse(_latitudeController.text),
          'longitude': double.parse(_longitudeController.text),
          'serviceRadius': _serviceRadius,
          'price': double.parse(_priceController.text),
          'availableDays': _availableDays,
        };

        final success = await _providerService.uploadProviderData(
          providerData: providerData,
          selfieImage: _selfieImage,
          cniRecto: _cniRecto,
          cniVerso: _cniVerso,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Inscription réussie ! Nous examinerons votre dossier.'),
              backgroundColor: Colors.green,
            ),
          );
          // Rediriger vers la page d'accueil
          if (mounted) {
            Navigator.of(context).pop();
          }
        } else {
          throw Exception('Échec de l\'inscription');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
}
