import 'package:cloud_firestore/cloud_firestore.dart';

class TareaParams {

  String titulo;
  String descripcion;
  FieldValue fecha = FieldValue.serverTimestamp();
  bool completado = false;

  TareaParams({
    required this.titulo,
    required this.descripcion
  });

  Map<String, dynamic> toFirestore() {
    return {
      "titulo": titulo,
      "descripcion": descripcion,
      "fecha": fecha,
      "completado": completado
    };
  }

}