import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tareas_app/entities/tarea_entity.dart';

class ActualizarTareaParams {

  String id;
  String titulo;
  String descripcion;
  DateTime fechaAnterior;
  bool completadoAnterior;

  ActualizarTareaParams({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaAnterior,
    required this.completadoAnterior
  });

  Map<String, dynamic> toFirestore() {
    return {
      "titulo": titulo,
      "descripcion": descripcion,
    };
  }

  TareaEntity newEntity() => TareaEntity(
    id: id,
    titulo: titulo,
    descripcion: descripcion,
    fecha: fechaAnterior,
    completado: completadoAnterior
  );

}