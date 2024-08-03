import '../../models/senha_fila_model.dart';

abstract class SenhaFilaState {
  final SenhaFilaModel? modelo;

  SenhaFilaState({required this.modelo});
}

class Loading extends SenhaFilaState {
  Loading() : super(modelo: null);
}

class Loaded extends SenhaFilaState {
  Loaded({required super.modelo});
}

class Error extends SenhaFilaState {
  final String exception;
  Error({required this.exception}) : super(modelo: null);
}
