abstract class SenhaFilaState {
  final int senha;

  SenhaFilaState({required this.senha});
}

class Loading extends SenhaFilaState {
  Loading() : super(senha: 0);
}

class Loaded extends SenhaFilaState {
  Loaded({required super.senha});
}

class Error extends SenhaFilaState {
  final String exception;
  Error({required this.exception}) : super(senha: 0);
}
