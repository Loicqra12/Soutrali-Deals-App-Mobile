import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/models/freelancer.dart';
import '../../domain/models/category.dart';
import '../../data/categories_data.dart';

class FreelanceRegistrationPage extends StatefulWidget {
  const FreelanceRegistrationPage({super.key});

  @override
  State<FreelanceRegistrationPage> createState() => _FreelanceRegistrationPageState();
}

class _FreelanceRegistrationPageState extends State<FreelanceRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  
  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _addressController = TextEditingController();
  final _rateController = TextEditingController();
  
  String? _selectedCategory;
  String? _selectedJob;
  List<String> _selectedSkills = [];
  File? _profilePhoto;
  File? _portfolioFile;
  bool _isRemoteWork = false;
  List<bool> _availability = List.generate(7, (index) => true);
  
  final _imagePicker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _addressController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePhoto = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickPortfolio() async {
    // TODO: Implement file picking for portfolio
  }

  List<String> _getJobsForCategory(String category) {
    return freelanceCategories
        .firstWhere(
          (cat) => cat.name == category,
          orElse: () => FreelanceCategory(
            id: '',
            name: '',
            icon: '',
            subcategories: [],
          ),
        )
        .subcategories
        .map((sub) => sub.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devenir Freelance'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 4) {
              setState(() {
                _currentStep += 1;
              });
            } else {
              // Submit form
              if (_formKey.currentState?.validate() ?? false) {
                // TODO: Handle form submission
              }
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          steps: [
            Step(
              title: const Text('Profil'),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nom complet'),
                    validator: (value) => value?.isEmpty ?? true ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value?.isEmpty ?? true ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Téléphone'),
                    validator: (value) => value?.isEmpty ?? true ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(labelText: 'Bio'),
                    maxLines: 3,
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Métier'),
              content: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'Catégorie'),
                    items: freelanceCategories.map((category) {
                      return DropdownMenuItem(
                        value: category.name,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                        _selectedJob = null;
                      });
                    },
                    validator: (value) => value == null ? 'Champ requis' : null,
                  ),
                  if (_selectedCategory != null)
                    DropdownButtonFormField<String>(
                      value: _selectedJob,
                      decoration: const InputDecoration(labelText: 'Métier'),
                      items: _getJobsForCategory(_selectedCategory!).map((job) {
                        return DropdownMenuItem(
                          value: job,
                          child: Text(job),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedJob = value;
                        });
                      },
                      validator: (value) => value == null ? 'Champ requis' : null,
                    ),
                ],
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text('Localisation'),
              content: Column(
                children: [
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Adresse'),
                    validator: (value) => value?.isEmpty ?? true ? 'Champ requis' : null,
                  ),
                  SwitchListTile(
                    title: const Text('Travail à distance'),
                    value: _isRemoteWork,
                    onChanged: (value) {
                      setState(() {
                        _isRemoteWork = value;
                      });
                    },
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
            ),
            Step(
              title: const Text('Documents'),
              content: Column(
                children: [
                  ListTile(
                    leading: _profilePhoto != null
                        ? Image.file(_profilePhoto!, width: 50, height: 50)
                        : const Icon(Icons.person),
                    title: const Text('Photo de profil'),
                    trailing: TextButton(
                      onPressed: _pickImage,
                      child: const Text('Choisir'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.file_present),
                    title: const Text('Portfolio'),
                    trailing: TextButton(
                      onPressed: _pickPortfolio,
                      child: const Text('Choisir'),
                    ),
                  ),
                ],
              ),
              isActive: _currentStep >= 3,
            ),
            Step(
              title: const Text('Tarifs'),
              content: Column(
                children: [
                  TextFormField(
                    controller: _rateController,
                    decoration: const InputDecoration(
                      labelText: 'Taux horaire (FCFA)',
                      suffixText: 'FCFA/h',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ requis' : null,
                  ),
                  const SizedBox(height: 16),
                  const Text('Disponibilités'),
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
                        selected: _availability[entry.key],
                        onSelected: (bool selected) {
                          setState(() {
                            _availability[entry.key] = selected;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              isActive: _currentStep >= 4,
            ),
          ],
        ),
      ),
    );
  }
}
