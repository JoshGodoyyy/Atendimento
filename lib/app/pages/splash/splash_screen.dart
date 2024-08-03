import 'package:atendimento/app/config/api_config.dart';
import 'package:atendimento/app/pages/api_config_page/api_config_page.dart';
import 'package:atendimento/app/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/api_url_manager.dart';
import '../../config/constantes.dart';
import '../../repositories/empresa.dart';
import '../../repositories/fila_atendimento.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _fetchApiURL();
  }

  _fetchApiURL() async {
    String url = await ApiUrlManager.get();

    if (url == '' && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ApiConfigPage(),
        ),
      );

      return;
    }

    ApiConfig.url = url;
    _fetchData();
  }

  Future<void> _fetchData() async {
    var navigator = Navigator.of(context);

    Constantes().empresa = await Empresa().fetchData();
    Constantes().filas = await FilaAtendimento().fetchTiposAtendimento();

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (builder) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff12111F),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/logo_light.png',
                width: 180,
              ),
            ),
            const SizedBox(height: 16),
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            const Text(
              'Carregando dados...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
