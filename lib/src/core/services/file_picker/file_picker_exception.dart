class FilePickerException implements Exception {
  final String message;

  FilePickerException({required this.message});
  @override
  String toString() => 'FilePickerException';
}
