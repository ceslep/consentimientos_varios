import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack/snack.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({super.key});

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  String url = '';
  final TextEditingController urlController =
      TextEditingController(text: 'http://192.168.0.250/');
  final TextEditingController profesionalController =
      TextEditingController(text: '');
  final TextEditingController direccionController =
      TextEditingController(text: '');
  final TextEditingController telefonoController =
      TextEditingController(text: '');
  final TextEditingController firmaController = TextEditingController(text: '');
  final bar = const SnackBar(
    content: Text(
      'Configuración guardada!',
      style: TextStyle(color: Colors.lime),
    ),
  );
  @override
  void initState() {
    super.initState();
    loadData('url', urlController);
    loadData('profesional', profesionalController);
    loadData('direccion', direccionController);
    loadData('telefono', telefonoController);
    loadData('firma', firmaController);
  }

  Future<void> loadData(String key, TextEditingController controller) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String data = prefs.getString(key) ?? '';
      controller.text = data;
    });
  }

  Future<void> saveData(String key, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 202, 253),
        title: const Text('Configuración'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                guardarTodo(context);
              },
              icon: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: urlController,
                onChanged: (value) => saveData('url', value),
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Dirección IP del servidor',
                  hintText: 'Ingrese Url',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: profesionalController,
                onChanged: (value) => saveData('profesional', value),
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Profesional Tratante',
                  hintText: 'Ingrese profesional tratante',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: direccionController,
                onChanged: (value) => saveData('direccion', value),
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Direccion Profesional',
                  hintText: 'Ingrese dirección profesional',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: telefonoController,
                onChanged: (value) => saveData('telefono', value),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Teléfono Profesional',
                  hintText: 'Ingrese teléfono profesional',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: firmaController,
                onChanged: (value) => saveData('firma', value),
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Firma Profesional(Base64)',
                  hintText: 'Ingrese firma profesional en codigo base 64',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                guardarTodo(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void guardarTodo(BuildContext context) {
    saveData('url', urlController.text);
    saveData('profesional', profesionalController.text);
    saveData('direccion', direccionController.text);
    saveData('telefono', telefonoController.text);
    saveData('firma', firmaController.text);
    bar.show(context);
  }
}
