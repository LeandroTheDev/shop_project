class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'Email já está cadastrado',
    'OPERATION_NOT_ALLOWED': 'Operação não está permitida',
    'EMAIL_NOT_FOUND': 'Email não encontrado',
    'INVALID_PASSWORD': 'Senha invalida',
    'USER_DISABLED': 'Usuario desativado',
  };
  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro';
  }
}