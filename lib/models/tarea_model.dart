import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tareas_app/entities/tarea_entity.dart';
import 'package:tareas_app/params/actualizar_tarea_params.dart';
import 'package:tareas_app/params/tarea_params.dart';
import 'package:tareas_app/views/tareas_view.dart';

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

  Future<List<TareaEntity>> obtenerTareas(EstadoDeTareas estado) async {

    List<TareaEntity> tareasTemporales = <TareaEntity>[];

    late Query<TareaEntity> query;

    if (estado == EstadoDeTareas.todas){
      query = obtenerTareasColRef;
    } else {
      query = obtenerTareasColRef.where(
        "completado",
        isEqualTo: estado == EstadoDeTareas.completadas ? true : false
      );
    }

    QuerySnapshot<TareaEntity> querySnap = await query.get();

    for (DocumentSnapshot<TareaEntity> snap in querySnap.docs) {
      tareasTemporales.add(snap.data()!);
    }

    return tareasTemporales;

  }

  Future<TareaEntity> actualizarTareaPorId(ActualizarTareaParams params) async {

    DocumentReference<TareaParams> docRef = crearTareaColRef.doc(params.id);

    await docRef.update(params.toFirestore());

    TareaEntity nuevaTarea = params.newEntity();

    return nuevaTarea;

  }

  Future<void> eliminarDocumentoPorId(String id) async {

    await crearTareaColRef.doc(id).delete();

  }

}