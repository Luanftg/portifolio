class Validators {
  static String? isEmpty(String? value) {
    if (value == null) return 'O valor não pode ser nulo!';
    if (value.isEmpty) return 'O valor não pode ser vazio!';
    return null;
  }
}
