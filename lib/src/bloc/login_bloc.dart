import 'package:walkistry_flutter/src/bloc/validator_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validator {
  LoginBloc();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get formLoginStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
}
