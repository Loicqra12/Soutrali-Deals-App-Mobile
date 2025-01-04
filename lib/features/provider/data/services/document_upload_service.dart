import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DocumentUploadService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 70, // Compression pour optimiser la taille
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

  Future<bool> uploadDocument(File file, String documentType) async {
    try {
      // TODO: Implémenter l'upload vers le backend
      // Exemple:
      // final formData = FormData.fromMap({
      //   'file': await MultipartFile.fromFile(file.path),
      //   'type': documentType,
      // });
      // final response = await dio.post('/upload', data: formData);
      // return response.statusCode == 200;
      
      return true; // Pour le moment, on simule un succès
    } catch (e) {
      print('Erreur lors de l\'upload: $e');
      return false;
    }
  }
}
