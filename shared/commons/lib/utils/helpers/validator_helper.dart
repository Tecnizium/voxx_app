bool emailValidator(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
  );
  return emailRegex.hasMatch(email);
}

bool passwordValidator(String password) {
  final RegExp passwordRegex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
  );
  return passwordRegex.hasMatch(password);
}

bool nameValidator(String name) {
  final RegExp nameRegex = RegExp(
    r'^[A-Za-z]+$',
  );
  return nameRegex.hasMatch(name);
}

bool cpfValidator(String cpf) {
  final RegExp cpfRegex = RegExp(
    r'^[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}$',
  );
  return cpfRegex.hasMatch(cpf);
}