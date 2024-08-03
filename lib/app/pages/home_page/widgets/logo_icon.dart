import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../config/constantes.dart';

class LogoIcon extends StatelessWidget {
  const LogoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      base64Decode(Constantes().empresa!.logo!),
    );
  }
}
