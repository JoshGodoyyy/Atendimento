import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../config/filas_atendimento.dart';

class LogoIcon extends StatelessWidget {
  const LogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      base64Decode(FilasAtendimento().empresa!.logo!),
    );
  }
}
