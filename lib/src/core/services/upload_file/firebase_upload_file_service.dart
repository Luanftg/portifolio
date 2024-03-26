import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:portifolio/src/core/services/upload_file/upload_file_exception.dart';
import 'package:portifolio/src/core/services/upload_file/upload_file_service.dart';

class FirebaseUploadFileService implements UploadFileService {
  @override
  Future<void> call(
      {required String fileName,
      required Uint8List fileBytes,
      String bucketName = ''}) async {
    try {
      await FirebaseStorage.instance.ref('cursos/$fileName').putData(fileBytes);
    } catch (e) {
      throw UploadFileException(message: e.toString());
    }
  }
}
