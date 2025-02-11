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

class TareasView extends StatelessWidget {
  const TareasView({super.key});

  @override
  Widget build(BuildContext context) {

    TareasController tareasController = context.read();

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
                        actualizar: () => actualizarTarea(context, tarea.titulo, tarea.descripcion),
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

  actualizarTarea(BuildContext context, String titulo, String descripcion) async {

    DialogoActualizarTareaResponse? valores = await showDialog(
      context: context,
      builder: (context) => DialogoActualizarTarea(titulo: titulo, descripcion: descripcion),
    );

    if (valores != null){
      print(valores.descripcion);
      print(valores.titulo);
      print(valores.tituloAnterior);
      print(valores.descripcionAnterior);

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
      print(resultado);
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
