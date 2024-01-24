class AppException implements Exception {
  String code;
  String? message = 'Unknown';

  AppException({required this.code, required this.message});
}
