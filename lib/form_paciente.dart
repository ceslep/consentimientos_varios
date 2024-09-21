import 'package:consentimientos_varios/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formController = Get.put(FormController()); // Inyectamos el controlador

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: formController.idController,
              decoration: const InputDecoration(labelText: 'Identificación'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la identificación';
                }
                return null;
              },
            ),
            TextFormField(
              controller: formController.nameController,
              decoration: const InputDecoration(labelText: 'Nombres'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa los nombres';
                }
                return null;
              },
            ),
            TextFormField(
              controller: formController.ciudadController,
              decoration: const InputDecoration(labelText: 'Ciudad'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la ciudad';
                }
                return null;
              },
            ),
            TextFormField(
              controller: formController.representadoController,
              decoration: const InputDecoration(labelText: 'Apoderado'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el apoderado';
                }
                return null;
              },
            ),
            TextFormField(
              controller: formController.descripcionController,
              decoration: const InputDecoration(
                  labelText: 'Descripción detallada del tratamiento'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el tratamiento';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: formController.submitForm,
              child: const Text('Asignar'),
            ),
          ],
        ),
      ),
    );
  }
}
