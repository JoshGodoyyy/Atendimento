import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/empresa_model.dart';

class Empresa {
  final String _url = '${ApiConfig.url}/Company';

  Future<EmpresaModel> fetchData() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
    );

    try {
      Map<String, dynamic> data = jsonDecode(response.body);
      return EmpresaModel.fromJson(data);
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
