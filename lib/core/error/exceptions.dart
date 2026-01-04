class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() =>
      'ServerException(message: $message, statusCode: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  String toString() => 'CacheException(message: $message)';
}

class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException({required this.message, this.code});

  @override
  String toString() => 'AuthException(message: $message, code: $code)';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() =>
      'ValidationException(message: $message, fieldErrors: $fieldErrors)';
}

class PermissionException implements Exception {
  final String message;

  const PermissionException({this.message = 'Permission denied'});

  @override
  String toString() => 'PermissionException(message: $message)';
}

class CameraException implements Exception {
  final String message;

  const CameraException({required this.message});

  @override
  String toString() => 'CameraException(message: $message)';
}

class StorageException implements Exception {
  final String message;

  const StorageException({required this.message});

  @override
  String toString() => 'StorageException(message: $message)';
}
