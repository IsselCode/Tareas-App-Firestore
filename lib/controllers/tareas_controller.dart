import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tareas_app/entities/tarea_entity.dart';
import 'package:tareas_app/errors/failures.dart';
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
  TareaEntity? tareaBuscada;

  Future<void> obtenerTareaPorId(String id) async {

    Either<TareasFailure, TareaEntity> response = await tareaModel.obtenerTareaPorId(id);

    response.fold(
      (l) {
        print(l);
      },
      (r) {
        tareaBuscada = r;
        notifyListeners();
      },
    );

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

    Either<TareasFailure, TareaEntity> response = await tareaModel.crearTarea(params);

    response.fold(
      (TareasFailure failure) {
        print(failure.message);
      },
      (TareaEntity nuevaTarea) {
        tareas.add(nuevaTarea);
        notifyListeners();
      },
    );

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

  Future<void> eliminarDocumentoPorId(String id) async {

    await tareaModel.eliminarDocumentoPorId(id);

  }

}