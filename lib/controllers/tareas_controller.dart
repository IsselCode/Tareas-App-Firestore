import 'package:flutter/material.dart';
import 'package:tareas_app/entities/tarea_entity.dart';
import 'package:tareas_app/models/tarea_model.dart';
import 'package:tareas_app/params/actualizar_tarea_params.dart';
import 'package:tareas_app/params/tarea_params.dart';
import 'package:tareas_app/views/tareas_view.dart';

class TareasController extends ChangeNotifier {

  TareaModel tareaModel;

  TareasController({
    required this.tareaModel,
  });

  List<TareaEntity> tareas = <TareaEntity>[];

  Future<void> obtenerTareaPorId(String id) async {

    TareaEntity tarea = await tareaModel.obtenerTareaPorId(id);

    tareas.add(tarea);

    notifyListeners();

  }

  Future<void> obtenerTareas(EstadoDeTareas estado) async {

    tareas = await tareaModel.obtenerTareas(estado);

    notifyListeners();

  }

  Future<void> crearTarea(String titulo, String descripcion) async {

    TareaParams params = TareaParams(
      titulo: titulo,
      descripcion: descripcion,
    );

    TareaEntity tareaEntity = await tareaModel.crearTarea(params);

    print(tareaEntity);

  }

  Future<void> actualizarTareaPorId(TareaEntity tareaAnterior, String nuevoTitulo, String nuevaDescripcion) async {

    ActualizarTareaParams params = ActualizarTareaParams(
      id: tareaAnterior.id,
      titulo: nuevoTitulo,
      descripcion: nuevaDescripcion,
      fechaAnterior: tareaAnterior.fecha,
      completadoAnterior: tareaAnterior.completado
    );

    TareaEntity tarea = await tareaModel.actualizarTareaPorId(params);

    int index = tareas.indexWhere((element) => element.id == tarea.id,);

    tareas[index] = tarea;

    notifyListeners();
  }

}