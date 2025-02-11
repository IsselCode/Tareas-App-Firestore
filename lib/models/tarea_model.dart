import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tareas_app/entities/tarea_entity.dart';

const String TAREAS = "tareas";


class TareaModel {

  FirebaseFirestore firestore;

  TareaModel({
    required this.firestore
  });

  Future<TareaEntity> crearTarea(String titulo, String descripcion, DateTime fecha, bool completado) async {

    Map<String, dynamic> data = {
      "titulo": titulo,
      "descripcion": descripcion,
      "fecha": fecha,
      "completado": completado
    };

    CollectionReference colRef = firestore.collection(TAREAS);

    DocumentReference docRef = await colRef.add(data);

    String id = docRef.id;

    TareaEntity tareaEntity = TareaEntity(
      id: id,
      titulo: titulo,
      descripcion: descripcion,
      fecha: fecha,
      completado: completado
    );

    return tareaEntity;
  }

}