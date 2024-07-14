import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Horario extends StatefulWidget {
  const Horario({super.key});

  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  String _horaAtual = '';

  void _atualizarHorario() {
    final String horaFormatada = DateFormat('dd/MM/yyyy - HH:mm:ss').format(
      DateTime.now(),
    );

    setState(() {
      _horaAtual = horaFormatada;
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _atualizarHorario();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _horaAtual,
      style: const TextStyle(fontSize: 20),
    );
  }
}
