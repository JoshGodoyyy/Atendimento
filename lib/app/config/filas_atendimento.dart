import '../models/empresa_model.dart';
import '../models/fila_atendimento_model.dart';

class FilasAtendimento {
  static final FilasAtendimento _instance = FilasAtendimento._();

  EmpresaModel? empresa;
  List<FilaAtendimentoModel>? filas;

  factory FilasAtendimento() {
    return _instance;
  }

  FilasAtendimento._();
}
