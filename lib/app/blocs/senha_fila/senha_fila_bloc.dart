import 'dart:async';

import '../../repositories/senha_fila.dart';
import 'senha_fila_event.dart';
import 'senha_fila_state.dart';

class SenhaFilaBloc {
  final _repository = SenhaFila();

  final StreamController<SenhaFilaEvent> _input =
      StreamController<SenhaFilaEvent>();
  final StreamController<SenhaFilaState> _output =
      StreamController<SenhaFilaState>();

  Sink<SenhaFilaEvent> get input => _input.sink;
  Stream<SenhaFilaState> get output => _output.stream;

  SenhaFilaBloc() {
    _input.stream.listen(_mapEventToState);
  }

  void _mapEventToState(SenhaFilaEvent event) async {
    int senha;

    _output.add(
      Loading(),
    );

    try {
      if (event is Get) {
        senha = await _repository.fetchSenha(event.idFila);
        _output.add(
          Loaded(
            senha: senha,
          ),
        );
      }
    } catch (ex) {
      _output.add(
        Error(
          exception: ex.toString(),
        ),
      );
    }
  }
}
