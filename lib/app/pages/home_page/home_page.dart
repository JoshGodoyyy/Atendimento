import 'package:flutter/material.dart';

import '../../config/constantes.dart';
import '../../ui/widgets/custom_shape.dart';
import 'widgets/botao_fila.dart';
import 'widgets/horario.dart';
import 'widgets/logo_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              color: const Color(0xff272964),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 140,
                margin: const EdgeInsets.all(16),
                child: const LogoIcon(),
              ),
              const Text(
                'Escolha uma opção',
                style: TextStyle(fontSize: 24),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 1,
                color: Colors.black,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: Constantes().filas!.length,
                    itemBuilder: (context, index) {
                      return BotaoFila(
                        item: Constantes().filas![index],
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 1,
                color: Colors.black,
              ),
              const Horario(),
              const SizedBox(height: 16),
              const Text(
                'Sastec Informática',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
