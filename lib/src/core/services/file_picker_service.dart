import 'dart:typed_data';

abstract class FilePickerService {
  Future<(String fileName, Uint8List fileData)?> call();
}
