// ignore_for_file: avoid_print

import 'package:consentimientos_varios/api.dart';
import 'package:consentimientos_varios/configuracion.dart';
import 'package:consentimientos_varios/data_consentimiento_model.dart';
import 'package:consentimientos_varios/datos_paciente.dart';
import 'package:consentimientos_varios/form_controller.dart';
import 'package:consentimientos_varios/signature.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConsentimientoInformado extends StatefulWidget {
  const ConsentimientoInformado({super.key});

  @override
  State<ConsentimientoInformado> createState() =>
      _ConsentimientoInformadoState();
}

class _ConsentimientoInformadoState extends State<ConsentimientoInformado> {
  bool generando = false;
  final formController = Get.put(FormController());
  late String nombre;
  late String identificacion;
  late String ciudad;
  late String representado;
  late String descripcion;
  String firma = "";

  @override
  void initState() {
    super.initState();
    nombre = formController.nameController.text;
    identificacion = formController.idController.text;
    ciudad = formController.ciudadController.text;
    representado = formController.representadoController.text;
    firma = "";
    descripcion = formController.descripcionController.text;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDay = DateFormat('d').format(now); // Día del mes
    String formattedMonth =
        DateFormat('MMMM', 'es').format(now); // Mes en español
    String formattedYear = DateFormat('y').format(now); // Año
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Consentimiento Informado',
          style: TextStyle(color: Colors.yellowAccent, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                Get.to(
                  () => const Configuracion(),
                );
              },
              icon: const Icon(Icons.settings, color: Colors.yellowAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                firma = await Get.to(() => const Signature());
                print(firma);
              },
              icon: const Icon(
                Icons.document_scanner_sharp,
                color: Colors.yellowAccent,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await Get.to(() => const DatosPaciente());
              setState(() {
                nombre = formController.nameController.text;
                identificacion = formController.idController.text;
                ciudad = formController.ciudadController.text;
                representado = formController.representadoController.text;
                descripcion = formController.descripcionController.text;
              });
            },
            icon: const Icon(Icons.add, color: Colors.yellow),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () async {
                if (firma.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Firma requerida',
                      ),
                    ),
                  );
                } else {
                  ConsentimientoModel consentimiento = ConsentimientoModel(
                    identificacion: identificacion,
                    nombre: nombre,
                    ciudad: ciudad,
                    representado: representado,
                    firma: firma,
                    dia: formattedDay,
                    mes: formattedMonth,
                    anio: formattedYear,
                  );
                  setState(() {
                    generando = true;
                  });
                  final result = await generarConsentimiento(consentimiento);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                    ),
                  );
                  setState(() {
                    generando = false;
                  });
                  launchInBrowser(identificacion);
                }
              },
              icon: const Icon(
                Icons.save,
                color: Colors.yellow,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CONSENTIMIENTO INFORMADO',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Yo $nombre Mayor de Edad Identificado con número de documento: $identificacion actuando en nombre propio o como representante legal de $representado DECLARO QUE:',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              _buildBulletPoint(
                  'He comprendido las explicaciones que se me han facilitado en un lenguaje claro y sencillo, y el facultativo que me ha atendido me ha permitido realizar todas las observaciones y me ha aclarado todas las dudas que le he planteado.'),
              _buildBulletPoint(
                  'También comprendo que, en cualquier momento y sin necesidad de dar ninguna explicación, puedo revocar el consentimiento que ahora presto.'),
              _buildBulletPoint(
                  'Por ello, manifiesto que estoy satisfecho con la información recibida y que comprendo el alcance y los riesgos del tratamiento, y en tales condiciones'),
              const SizedBox(height: 10),
              Text(
                'Descripción detallada de procedimiento a realizar: $descripcion',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Autorizo:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              _buildSectionTitle('ANESTESIA LOCAL'),
              _buildParagraph(
                  'La anestesia local se utiliza con la finalidad de efectuar el tratamiento odontológico sin dolor. La anestesia local se aplica mediante una inyección que bloquea de manera reversible los impulsos nerviosos de modo tal que se interrumpe transitoriamente la sensibilidad.'),
              _buildParagraph(
                  'El efecto de la anestesia local me producirá una sensación extraña en la región anestesiada, que normalmente desaparecerá espontáneamente en dos o tres horas. La administración de la anestesia local puede provocar en algunos casos: heridas en la mucosa, dolor, hematoma y, en algunas ocasiones limitaciones para abrir la boca, que pueden requerir tratamiento ulterior. Del mismo modo, puede ocasionar una baja de presión y sensación de mareo.'),
              _buildParagraph(
                  'Entiendo que algunos pacientes pueden presentar algún tipo de reacción alérgica a la anestesia local, que se manifiesta como urticaria, dermatitis de contacto, asma y edema angioneurótico, que en casos extremos pueden requerir tratamiento de emergencia. Sin embargo, según se me ha explicado, con base en mis antecedentes personales no es de esperar para mi caso este tipo de reacciones desfavorables.'),
              _buildParagraph(
                  'Todo acto quirúrgico puede ocasionar potencialmente distintas complicaciones comunes y potencialmente serias que podrían requerir tratamientos complementarios tanto médicos como quirúrgicos, sobre todo en personas con alguna condición o enfermedad sistémica como las siguientes: diabetes, cardiopatía, hipertensión, anemia, edad avanzada, obesidad.'),
              const SizedBox(height: 10),
              _buildSectionTitle('HIGIENE ORAL'),
              _buildParagraph(
                  'Comprendo que durante la revisión odontológica, el odontólogo ha visto la necesidad de una limpieza dental debido al estado de mis encías y/o depósitos en mis dientes. Durante la cita de higiene oral, se realizarán fases de educación en salud oral, se me indicará la técnica correcta de cepillado y uso de seda dental que debo usar, se hará remoción de placa y cálculo dental.'),
              _buildParagraph(
                  'En caso de traer menores a consulta de higiene oral, se realizará fase de adaptación, educación, sellantes y limpieza dental según lo requieran.'),
              _buildParagraph(
                  'Entiendo que el éxito de cualquier tratamiento depende, en parte, de mi esfuerzo por cepillar los dientes y limpiarlos con hilo dental diariamente, por recibir limpiezas regulares según se indique, por seguir una dieta saludable. Existe la posibilidad de laceraciones en la encía, alergia a materiales, sensibilidad a cambios térmicos y movilidad dental.'),
              const SizedBox(height: 10),
              _buildSectionTitle('OPERATORIA DENTAL'),
              _buildParagraph(
                  'La obturación de la(s) pieza(s) dental(es) indicada (s) consiste en la eliminación del tejido dental afectado por la caries sustituyéndolo por un material odontológico que selle herméticamente la cavidad resultante. De esta manera se podrán conservar la(s) pieza(s) dental(es) y devolver la función y en cierta medida la estética.'),
              _buildParagraph(
                  'Con cierta frecuencia la(s) pieza(s) tratada(s) queda(n) más sensibles durante poco tiempo o puede necesitar alguna visita para ajustar la(s) obturación(es). Aún con obturaciones perfectamente realizadas, no se pueden evitar alteraciones de la pulpa dental. El proceso carioso puede haber alterado irreversiblemente el nervio de la pieza dental, y hacer necesaria una endodoncia. En casos de caries extensas o profundas, al quedar menos tejido dental sano, puede ser necesaria la colocación de una funda o corona protésica parcial o completa para disminuir el riesgo de fractura.'),
              const SizedBox(height: 10),
              _buildSectionTitle('REHABILITACIÓN'),
              _buildParagraph(
                  'Se realiza con el fin de restaurar piezas dentales con pérdida de tejido coronal o con alteraciones en su forma y tamaño, o para reemplazar dientes perdidos o por agenesia. Con el fin de devolver la funcionalidad, la oclusión correcta y la estética oral.'),
              _buildParagraph(
                  'Los riesgos de estos procedimientos son alteraciones en la pulpa dental, laceraciones en la mucosa, alteraciones periodontales del diente tratado o de dientes adyacentes. Los riesgos posteriores al tratamiento pueden ser caries en dientes pilares por mala higiene e ingesta de carbohidratos, fractura o cementación de las coronas o prótesis fijas por masticación de objetos o alimentos duros, pegajosos o por traumas, fracturas de prótesis removibles por caídas, golpes o manipulación de sus elementos por alguien diferente al profesional tratante.'),
              const SizedBox(height: 10),
              _buildSectionTitle('BLANQUEAMIENTO'),
              _buildParagraph(
                  'Es un procedimiento por medio del cual se aclara la estructura del esmalte dental por medio de la inducción de una sustancia química (gel peróxido de hidrógeno), y que de forma opcional puede usarse una luz que actúa como activador y/o potencializador del efecto deseado.'),
              _buildBulletPoint(
                  'Sensibilidad durante los primeros 3 días de aplicado el blanqueamiento con haz de luz y la primera semana para el blanqueamiento casero.'),
              _buildBulletPoint('Inflamación temporal de la encía.'),
              _buildBulletPoint(
                  'Oscurecimiento de los dientes con el lapso del tiempo.'),
              const SizedBox(height: 10),
              _buildSectionTitle('CIRUGÍA ORAL'),
              _buildParagraph(
                  'La cirugía oral se realiza para resolver determinados problemas de la cavidad oral, tales como: extracción de piezas dentarias o restos incluidos de raíces, apertura mucosa o tracción de dientes retenidos, frenillos labiales, extirpación de quistes maxilares y de pequeños tumores de estos o del resto de la cavidad oral.'),
              _buildParagraph(
                  'Todos estos procedimientos suponen un indudable beneficio, sin embargo, no están exentos de complicaciones, algunas de ellas inevitables, siendo las estadísticamente más frecuentes: Alergia al anestésico u otro medicamento utilizado, antes, durante o después de la cirugía. Hematoma e hinchazón de la región. Hemorragia postoperatoria.'),
              const SizedBox(height: 16),
              _buildParagraph(
                  'Por ello, manifiesto que estoy satisfecho con la información recibida y que comprendo el alcance y los riesgos del tratamiento, y en tales condiciones se suscribe este consentimiento en Cartago a los $formattedDay días de $formattedMonth de $formattedYear. ')
            ],
          ),
        ),
      ),
    );
  }

  // Widget para párrafos de texto
  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Widget para títulos de secciones
  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget para puntos en listas
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

class ConsentimeintoModel {}
