import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class SenhaFila {
  final String _url = '${ApiConfig.url}/PasswordQueue';

  Future<int> fetchSenha(int idFila) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(idFila),
    );

    try {
      num data = jsonDecode(response.body);
      return int.parse(data.toString());
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
