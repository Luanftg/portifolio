import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:portifolio/src/core/services/file_picker/file_picker_exception.dart';
import 'package:portifolio/src/core/services/file_picker_service.dart';

class FilePickerServiceImp implements FilePickerService {
  @override
  Future<(String, Uint8List)?> call() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      if (fileBytes == null) {
        throw FilePickerException(
            message: 'Não foi possível obter [Uint8List]');
      }
      String fileName = result.files.first.name;
      return (fileName, fileBytes);
    }
    return null;
  }
}
