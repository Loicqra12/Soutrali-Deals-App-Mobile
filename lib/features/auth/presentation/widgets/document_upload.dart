import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/user_type.dart';
import '../../../../core/theme.dart';

class DocumentUpload extends StatefulWidget {
  final UserType userType;
  final Function(String) onDocumentPicked;

  const DocumentUpload({
    super.key,
    required this.userType,
    required this.onDocumentPicked,
  });

  @override
  State<DocumentUpload> createState() => _DocumentUploadState();
}

class _DocumentUploadState extends State<DocumentUpload> {
  String? _documentPath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickDocument() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _documentPath = image.path;
        });
        widget.onDocumentPicked(image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la sélection du document'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getDocumentTitle() {
    switch (widget.userType) {
      case UserType.provider:
        return 'Pièce d\'identité';
      case UserType.company:
        return 'Documents de l\'entreprise';
      case UserType.seller:
        return 'Photo d\'identité (optionnel)';
      default:
        return 'Document';
    }
  }

  String _getDocumentDescription() {
    switch (widget.userType) {
      case UserType.provider:
        return 'CNI, passeport ou permis de conduire';
      case UserType.company:
        return 'RCCM, attestation ou autre document officiel';
      case UserType.seller:
        return 'Une photo d\'identité pour la vérification';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userType == UserType.particular) {
      return const SizedBox();
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getDocumentTitle(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getDocumentDescription(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickDocument,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _documentPath != null 
                        ? AppTheme.primaryColor 
                        : Colors.grey[300]!,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _documentPath != null 
                          ? Icons.check_circle 
                          : Icons.upload_file,
                      size: 40,
                      color: _documentPath != null 
                          ? AppTheme.primaryColor 
                          : Colors.grey[600],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _documentPath != null 
                          ? 'Document sélectionné' 
                          : 'Cliquez pour sélectionner',
                      style: TextStyle(
                        color: _documentPath != null 
                            ? AppTheme.primaryColor 
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ces données seront sécurisées et utilisées uniquement à des fins de vérification',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
