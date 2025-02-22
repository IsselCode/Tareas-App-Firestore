import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tareas_app/controllers/tareas_controller.dart';
import 'package:tareas_app/dialogs/dialogo_actualizar_tarea.dart';
import 'package:tareas_app/dialogs/dialogo_crear_tarea.dart';
import 'package:tareas_app/dialogs/dialogo_eliminar_tarea.dart';
import 'package:tareas_app/entities/tarea_entity.dart';
import 'package:tareas_app/responses/dialogo_actualizar_tarea_response.dart';
import 'package:tareas_app/responses/dialogo_crear_tarea_response.dart';
import 'package:tareas_app/views/info_tarea_view.dart';

enum EstadoDeTareas {
  todas,
  completadas,
  noCompletadas
}

class TareasView extends StatefulWidget {
  TareasView({super.key});

  @override
  State<TareasView> createState() => _TareasViewState();
}

class _TareasViewState extends State<TareasView> {
  EstadoDeTareas opcionSeleccionada = EstadoDeTareas.todas;

  @override
  Widget build(BuildContext context) {

    TareasController tareasController = context.watch();

    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      floatingActionButton: FloatingActionButton(
        onPressed: () => crearTarea(context),
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Color(0xff0F52FF),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [

                /// Texto TAREAS
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Text(
                      "Tareas",
                      style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600),
                    )
                  ),
                ),

                const SizedBox(height: 20,),

                SegmentedButton(
                  segments: [
                    ButtonSegment(
                      value: EstadoDeTareas.todas,
                      label: Text("Todas")
                    ),
                    ButtonSegment(
                      value: EstadoDeTareas.completadas,
                      label: Text("Completadas")
                    ),
                    ButtonSegment(
                      value: EstadoDeTareas.noCompletadas,
                      label: Text("No Completadas")
                    )
                  ],
                  style: SegmentedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide.none,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    selectedBackgroundColor: Color(0xff0F52FF),
                    selectedForegroundColor: Colors.white,
                  ),
                  showSelectedIcon: false,
                  onSelectionChanged: (Set p0) async {

                    opcionSeleccionada = p0.first;

                    await tareasController.obtenerTareas(p0.first);

                    setState(() {});

                  },
                  selected: {opcionSeleccionada}
                ),

                const SizedBox(height: 20,),

                Expanded(
                  child: ListView.separated(
                    itemCount: tareasController.tareas.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10,);
                    },
                    itemBuilder: (context, index) {

                      TareaEntity tarea = tareasController.tareas[index];

                      return _TareaTile(
                        titulo: tarea.titulo,
                        ver: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoTareaView(
                                titulo: tarea.titulo,
                                descripcion: tarea.descripcion,
                                fechaCreacion: tarea.fecha,
                                completado: tarea.completado
                              )
                            )
                          );
                        },
                        actualizar: () => actualizarTarea(context, tarea),
                        eliminar: () => eliminarTarea(context, tarea.id),
                      );
                    },
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  crearTarea(BuildContext context) async {

    TareasController tareasController = context.read();

    DialogoCrearTareaResponse? valores = await showDialog(
      context: context,
      builder: (context) => dialogoCrearTarea(context),
    );


    if (valores != null){

      await tareasController.crearTarea(valores.titulo, valores.descripcion);

    }

  }

  actualizarTarea(BuildContext context, TareaEntity tarea) async {

    DialogoActualizarTareaResponse? valores = await showDialog(
      context: context,
      builder: (context) => DialogoActualizarTarea(titulo: tarea.titulo, descripcion: tarea.descripcion),
    );

    if (valores != null){

      TareasController tareasController = context.read();

      await tareasController.actualizarTareaPorId(
        tarea,
        valores.titulo,
        valores.descripcion
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("La tarea ${valores.tituloAnterior} fue actualizada a ${valores.titulo}"))
      );

    }

  }

  eliminarTarea(BuildContext context, String id) async {

    bool? resultado = await showDialog(
      context: context,
      builder: (context) => dialogoEliminarTarea(context),
    );

    if (resultado != null){

      if (resultado) {

        TareasController tareasController = context.read();

        await tareasController.eliminarDocumentoPorId(id);

      }

    }

  }
}


class _TareaTile extends StatelessWidget {

  String titulo;
  VoidCallback actualizar;
  VoidCallback eliminar;
  VoidCallback ver;

  _TareaTile({
    super.key,
    required this.titulo,
    required this.ver,
    required this.actualizar,
    required this.eliminar
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ver,
      title: Text(
        titulo,
        style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w700
        ),
      ),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: actualizar,
              icon: Icon(Icons.edit_outlined, color: Color(0xff0F52FF),)
          ),
          IconButton(
              onPressed: eliminar,
              icon: Icon(Icons.delete_outline, color: Colors.red,)
          )
        ],
      ),
    );
  }
}
