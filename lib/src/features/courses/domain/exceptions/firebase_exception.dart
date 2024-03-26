class CustomFirebaseException implements Exception {
  final String message;

  CustomFirebaseException({required this.message});
  @override
  String toString() => message;
}
