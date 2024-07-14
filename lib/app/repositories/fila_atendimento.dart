import 'dart:convert';

import '../config/api_config.dart';
import '../models/fila_atendimento_model.dart';
import 'package:http/http.dart' as http;

class FilaAtendimento {
  final String _url = '${ApiConfig.url}/ServiceQueue';

  Future<List<FilaAtendimentoModel>> fetchTiposAtendimento() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
    );

    try {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => FilaAtendimentoModel.fromJson(json)).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
