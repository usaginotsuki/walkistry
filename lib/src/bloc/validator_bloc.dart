import 'dart:async';

class Validator {
  final emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError("El correo ingresado no es valido");
    }
  });
  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError("La contraseña debe tener al menos 6 caracteres");
    }
  });

  final usernameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 4) {
      sink.add(password);
    } else {
      sink.addError("El nombre de usuario debe tener al menos 4 caracteres");
    }
  });
}
