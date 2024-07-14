import 'package:atendimento/app/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';

import '../../config/filas_atendimento.dart';
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

    fetchData();
  }

  Future<void> fetchData() async {
    var navigator = Navigator.of(context);

    FilasAtendimento().empresa = await Empresa().fetchData();
    FilasAtendimento().filas = await FilaAtendimento().fetchTiposAtendimento();

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (builder) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xff12111F),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_light.png',
              width: 180,
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
