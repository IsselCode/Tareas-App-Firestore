import 'package:flutter/material.dart';
import 'package:tareas_app/entities/tarea_entity.dart';
import 'package:tareas_app/models/tarea_model.dart';

class TareasController extends ChangeNotifier {

  TareaModel tareaModel;

  TareasController({
    required this.tareaModel,
  });

  List<TareaEntity> tareas = <TareaEntity>[];

  Future<void> crearTarea(String titulo, String descripcion) async {

    TareaEntity tareaEntity = await tareaModel.crearTarea(
      titulo,
      descripcion,
      DateTime.now(),
      false
    );

    print(tareaEntity);

  }

}