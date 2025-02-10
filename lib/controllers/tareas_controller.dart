import 'package:flutter/material.dart';
import 'package:tareas_app/entities/tarea_entity.dart';
import 'package:tareas_app/models/tarea_model.dart';

class TareasController extends ChangeNotifier {

  TareaModel tareaModel;

  TareasController({
    required this.tareaModel,
  });

  List<TareaEntity> tareas = <TareaEntity>[];

}