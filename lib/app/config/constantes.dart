import '../models/empresa_model.dart';
import '../models/fila_atendimento_model.dart';

class Constantes {
  static final Constantes _instance = Constantes._();

  EmpresaModel? empresa;
  List<FilaAtendimentoModel>? filas;

  factory Constantes() {
    return _instance;
  }

  Constantes._();
}
