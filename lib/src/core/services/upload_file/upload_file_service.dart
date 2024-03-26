import 'dart:typed_data';

abstract class UploadFileService {
  Future<void> call({
    required String fileName,
    required Uint8List fileBytes,
    String bucketName = '',
  });
}
