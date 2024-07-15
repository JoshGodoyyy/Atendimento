import 'package:atendimento/app/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../config/api_url_manager.dart';

class ApiConfigPage extends StatefulWidget {
  const ApiConfigPage({super.key});

  @override
  State<ApiConfigPage> createState() => _ApiConfigPageState();
}

class _ApiConfigPageState extends State<ApiConfigPage> {
  final urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff12111F),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Hero(
            tag: 'logo',
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 4,
              child: Image.asset(
                'assets/images/logo_light.png',
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'URL:',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextField(
            controller: urlController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              filled: true,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (urlController.text == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Preencha o campo URL'),
                  ),
                );
                return;
              }

              await ApiUrlManager.insert(urlController.text);

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 48,
              ),
            ),
            child: const Text(
              'Salvar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
