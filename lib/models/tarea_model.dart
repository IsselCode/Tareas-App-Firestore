import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tareas_app/entities/tarea_entity.dart';
import 'package:tareas_app/params/tarea_params.dart';

const String TAREAS = "tareas";


class TareaModel {

  FirebaseFirestore firestore;
  late CollectionReference<TareaParams> crearTareaColRef;
  late CollectionReference<TareaEntity> obtenerTareasColRef;

  TareaModel({
    required this.firestore
  }) {
    crearTareaColRef = firestore.collection(TAREAS).withConverter(
      fromFirestore: (snapshot, options) => throw UnimplementedError(),
      toFirestore: (TareaParams params, _) => params.toFirestore(),
    );

    obtenerTareasColRef = firestore.collection(TAREAS).withConverter(
      fromFirestore: TareaEntity.fromFirestore,
      toFirestore: (value, options) => throw UnimplementedError(),
    );
  }

  Future<TareaEntity> crearTarea(TareaParams params) async {

    DocumentReference docRef = await crearTareaColRef.add(params);

    String id = docRef.id;

    TareaEntity tareaEntityObtenida = TareaEntity(
      id: id,
      titulo: params.titulo,
      descripcion: params.descripcion,
      fecha: DateTime.now(),
      completado: params.completado
    );

    return tareaEntityObtenida;
  }

  Future<TareaEntity> obtenerTareaPorId(String id) async {

    DocumentReference<TareaEntity> docRef = obtenerTareasColRef.doc(id);

    DocumentSnapshot<TareaEntity> snap = await docRef.get();

    TareaEntity tarea = snap.data()!;

    return tarea;

  }

}