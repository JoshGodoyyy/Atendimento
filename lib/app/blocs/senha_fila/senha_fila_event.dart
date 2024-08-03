abstract class SenhaFilaEvent {}

class Get extends SenhaFilaEvent {
  final int idFila;

  Get({
    required this.idFila,
  });
}

class Insert extends SenhaFilaEvent {
  final int idFila;
  final int senha;

  Insert({
    required this.idFila,
    required this.senha,
  });
}
