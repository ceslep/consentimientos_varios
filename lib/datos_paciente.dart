import 'package:consentimientos_varios/form_paciente.dart';
import 'package:flutter/material.dart';

class DatosPaciente extends StatelessWidget {
  const DatosPaciente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 221, 117),
        title: const Text('Datos Paciente'),
      ),
      body: const FormScreen(),
    );
  }
}
