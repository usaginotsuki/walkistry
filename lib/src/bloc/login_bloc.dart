import 'package:walkistry_flutter/src/bloc/validator_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validator {
  LoginBloc();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passwordChecker = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get passwordCheckerStream =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get comparePassword =>
      Rx.sequenceEqual(passwordStream, passwordCheckerStream);

  Stream<bool> get formLoginStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  Stream<bool> get formLoginValidStream => Rx.sequenceEqual(
        formLoginStream,
        comparePassword,
        errorEquals: (e1, e2) => e1.error.toString() == e2.error.toString(),
      );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePasswordChecker => _passwordChecker.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String? get passwordChecker =>
      _passwordChecker.hasValue ? _passwordChecker.value : "";
}
