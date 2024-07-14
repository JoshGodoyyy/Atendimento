import 'package:elgin/elgin.dart';
import 'package:flutter/material.dart';

import '../../blocs/senha_fila/senha_fila_bloc.dart';
import '../../blocs/senha_fila/senha_fila_event.dart';
import '../../blocs/senha_fila/senha_fila_state.dart';
import '../../models/fila_atendimento_model.dart';
import '../../ui/widgets/custom_shape.dart';
import '../home_page/widgets/logo_icon.dart';

class SenhaPage extends StatefulWidget {
  final FilaAtendimentoModel fila;
  const SenhaPage({
    super.key,
    required this.fila,
  });

  @override
  State<SenhaPage> createState() => _SenhaPageState();
}

class _SenhaPageState extends State<SenhaPage> {
  late SenhaFilaBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SenhaFilaBloc();
    _fetchSenha();
  }

  _fetchSenha() {
    _bloc.input.add(
      Get(
        idFila: int.parse(
          widget.fila.id.toString(),
        ),
      ),
    );
  }

  imprimir(int senha) async {
    final driver = ElginPrinter(
      type: ElginPrinterType.MINIPDV,
    );

    try {
      final int? result = await Elgin.printer.connect(driver: driver);
      if (result == null) return;
      if (result == 0) {
        await Elgin.printer.printString(widget.fila.nome!,
            align: ElginAlign.CENTER, fontSize: ElginSize.MD);
        await Elgin.printer.feed(4);
        await Elgin.printer.printString(senha.toString(),
            align: ElginAlign.CENTER, fontSize: ElginSize.XL);
        await Elgin.printer.feed(4);
        await Elgin.printer.printString(hoje(),
            align: ElginAlign.CENTER, fontSize: ElginSize.MD);
        await Elgin.printer.feed(4);
        await Elgin.printer.cut(lines: 2);
        await Elgin.printer.disconnect();
      }
    } on ElginException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.error.message),
          ),
        );
      }
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  String hoje() {
    var date = DateTime.now();
    String hora =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
    String dataFormatada =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return '$hora - $dataFormatada';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7A6A6),
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
          Center(
              child: StreamBuilder<SenhaFilaState>(
            stream: _bloc.output,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data is Loading) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Conectando ao servidor...',
                        style: TextStyle(fontSize: 24),
                      ),
                      LinearProgressIndicator(),
                    ],
                  ),
                );
              } else if (snapshot.data is Loaded) {
                imprimir(snapshot.data!.senha);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      margin: const EdgeInsets.all(16),
                      child: const LogoIcon(),
                    ),
                    const Text(
                      'Você será chamado pela senha:',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffA7A6A6),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(-4, -4),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.fila.nome!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            snapshot.data!.senha.toString(),
                            style: const TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            hoje(),
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Sastec Informática',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                );
              } else {
                return Text(
                  snapshot.error.toString(),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
