import 'package:cloud_firestore/cloud_firestore.dart';

class TareaEntity {

  String id;
  String titulo;
  String descripcion;
  DateTime fecha;
  bool completado;

  TareaEntity({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.completado
  });

  factory TareaEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final String snapId = snapshot.id;
    final data = snapshot.data();
    return TareaEntity(
      id: snapId,
      titulo: data?["titulo"],
      descripcion: data?["descripcion"],
      fecha: data?["fecha"].toDate(),
      completado: data?["completado"]
    );
  }

}