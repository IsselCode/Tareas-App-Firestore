import 'package:flutter/material.dart';
import 'package:tareas_app/entities/tarea_entity.dart';
import 'package:tareas_app/models/tarea_model.dart';
import 'package:tareas_app/params/tarea_params.dart';

class TareasController extends ChangeNotifier {

  TareaModel tareaModel;

  TareasController({
    required this.tareaModel,
  });

  List<TareaEntity> tareas = <TareaEntity>[];

  Future<void> crearTarea(String titulo, String descripcion) async {

    TareaParams params = TareaParams(
      titulo: titulo,
      descripcion: descripcion,
    );

    TareaEntity tareaEntity = await tareaModel.crearTarea(params);

    print(tareaEntity);

  }

}