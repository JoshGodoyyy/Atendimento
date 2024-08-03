import 'dart:convert';
import 'package:atendimento/app/models/senha_fila_model.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class SenhaFila {
  final String _url = '${ApiConfig.url}/PasswordQueue';

  Future<dynamic> fetchSenha(int idFila) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(idFila),
    );

    try {
      var data = jsonDecode(response.body);
      return SenhaFilaModel.fromJson(data);
    } catch (ex) {
      if (response.body.startsWith('System.Exception')) {
        throw Exception(response.body);
      } else {
        throw Exception(ex);
      }
    }
  }

  Future<void> insert(int idFila, int senha) async {
    await http.post(
      Uri.parse('$_url/Insert'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'password': senha,
          'idQueue': idFila,
        },
      ),
    );
  }
}
