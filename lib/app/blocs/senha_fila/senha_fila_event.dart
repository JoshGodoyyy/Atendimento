abstract class SenhaFilaEvent {}

class Get extends SenhaFilaEvent {
  final int idFila;

  Get({required this.idFila});
}
