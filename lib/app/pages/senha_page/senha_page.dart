import 'package:atendimento/app/pages/home_page/home_page.dart';
import 'package:atendimento/app/ui/widgets/custom_dialog.dart';
import 'package:elgin/elgin.dart';
import 'package:flutter/material.dart';

import '../../blocs/senha_fila/senha_fila_bloc.dart';
import '../../blocs/senha_fila/senha_fila_event.dart';
import '../../blocs/senha_fila/senha_fila_state.dart';
import '../../enums/etipo_erro.dart';
import '../../models/fila_atendimento_model.dart';
import '../../repositories/senha_fila.dart';
import '../../utils/ferramentas.dart';
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
  late bool _impressoraConectada;

  @override
  void initState() {
    super.initState();
    _bloc = SenhaFilaBloc();
    _fetchSenha();
    _connect();
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

  _connect() async {
    int? resultado;

    try {
      resultado = await Ferramentas.conectarImpressora();
    } catch (ex) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ex.toString()),
          ),
        );
      });
    }

    if (resultado == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao tentar se conectar a impressora'),
          ),
        );
      });
      _impressoraConectada = false;
    }

    _impressoraConectada = true;
  }

  imprimir(String prefixo, int senha) async {
    try {
      Ferramentas.imprimir(
        widget.fila.nome!,
        prefixo,
        senha,
      );
    } on ElginException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.error.message),
          ),
        );
      });
      return;
    } catch (ex) {
      if (ex is TypeError) {
        return;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(ex.toString()),
            ),
          );
        });

        return;
      }
    }
  }

  _salvarSenha(int senha) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    await SenhaFila().insert(
      int.parse(
        widget.fila.id.toString(),
      ),
      senha,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pop(context);
    });
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
                  if (!_impressoraConectada) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (timeStamp) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              title: 'Ops, ocorreu um erro',
                              content:
                                  'Não foi possível se conectar à impressora',
                              action: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              ),
                              tipoErro: ETipoErro.impressora,
                            );
                          },
                        );
                      },
                    );
                  }

                  imprimir(
                    snapshot.data!.modelo!.prefixo.toString(),
                    int.parse(
                      snapshot.data!.modelo!.senha.toString(),
                    ),
                  );

                  _salvarSenha(
                    int.parse(
                      snapshot.data!.modelo!.senha.toString(),
                    ),
                  );

                  String prefixo = snapshot.data!.modelo!.prefixo.toString();
                  String senha =
                      snapshot.data!.modelo!.senha.toString().padLeft(4, '0');
                  String resultado = '$prefixo$senha';

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
                              resultado,
                              style: const TextStyle(
                                fontSize: 90,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              Ferramentas.hoje(),
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
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            title: 'Ops, ocorreu um erro',
                            content: snapshot.error.toString(),
                            action: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            ),
                            tipoErro: ETipoErro.servidor,
                          );
                        },
                      );
                    },
                  );
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
