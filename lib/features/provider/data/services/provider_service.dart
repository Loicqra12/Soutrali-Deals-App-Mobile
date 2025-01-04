import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ProviderService {
  final Dio _dio = Dio();
  final ImagePicker _picker = ImagePicker();
  
  // URL de base de l'API
  final String baseUrl = 'http://localhost:3000/api'; // À remplacer par votre URL

  Future<File?> pickImage({
    required ImageSource source,
    int imageQuality = 70,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: imageQuality,
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Erreur lors de la sélection de l\'image: $e');
      return null;
    }
  }

  Future<bool> uploadProviderData({
    required Map<String, dynamic> providerData,
    required File? selfieImage,
    required File? cniRecto,
    required File? cniVerso,
  }) async {
    try {
      // Créer un FormData pour l'upload multipart
      final formData = FormData.fromMap(providerData);

      // Ajouter les images si elles existent
      if (selfieImage != null) {
        formData.files.add(
          MapEntry(
            'selfie',
            await MultipartFile.fromFile(
              selfieImage.path,
              filename: 'selfie.jpg',
            ),
          ),
        );
      }

      if (cniRecto != null) {
        formData.files.add(
          MapEntry(
            'cniRecto',
            await MultipartFile.fromFile(
              cniRecto.path,
              filename: 'cni_recto.jpg',
            ),
          ),
        );
      }

      if (cniVerso != null) {
        formData.files.add(
          MapEntry(
            'cniVerso',
            await MultipartFile.fromFile(
              cniVerso.path,
              filename: 'cni_verso.jpg',
            ),
          ),
        );
      }

      // Envoyer les données au backend
      final response = await _dio.post(
        '$baseUrl/providers/register',
        data: formData,
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Erreur lors de l\'upload: $e');
      return false;
    }
  }
}
