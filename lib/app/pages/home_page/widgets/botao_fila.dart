import 'package:atendimento/app/models/fila_atendimento_model.dart';
import 'package:atendimento/app/pages/senha_page/senha_page.dart';
import 'package:flutter/material.dart';

class BotaoFila extends StatelessWidget {
  final dynamic item;
  const BotaoFila({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    var fila = item as FilaAtendimentoModel;
    return Container(
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
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SenhaPage(
              fila: fila,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff363636),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffA7A6A6),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    fila.id.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Text(
                fila.nome!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
