class ConsentimientoModel {
  String identificacion;
  String nombre;
  String ciudad;
  String representado;
  String? descripcion;
  String? firma;
  String? dia;
  String? mes;
  String? anio;

  ConsentimientoModel(
      {required this.identificacion,
      required this.nombre,
      required this.ciudad,
      required this.representado,
      this.descripcion,
      this.firma,
      this.dia,
      this.mes,
      this.anio});

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'identificacion': identificacion,
      'nombre': nombre,
      'ciudad': ciudad,
      'representado': representado,
      'descripcion': descripcion,
      'firma': firma,
      'dia': dia,
      'mes': mes,
      'anio': anio
    };
  }

  // Método para crear una instancia desde JSON
  factory ConsentimientoModel.fromJson(Map<String, dynamic> json) {
    return ConsentimientoModel(
      identificacion: json['identificacion'],
      nombre: json['nombres'],
      ciudad: json['ciudad'],
      representado: json['apoderado'],
      firma: json['firma'],
      descripcion: json['descripcion'],
      dia: json['dia'],
      mes: json['mes'],
      anio: json['anio'],
    );
  }
}
