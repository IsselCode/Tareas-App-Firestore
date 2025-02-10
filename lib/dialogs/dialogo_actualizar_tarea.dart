import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tareas_app/responses/dialogo_actualizar_tarea_response.dart';
import 'package:tareas_app/responses/dialogo_crear_tarea_response.dart';


class DialogoActualizarTarea extends StatefulWidget {

  final String titulo;
  final String descripcion;

  const DialogoActualizarTarea({
    super.key,
    required this.titulo,
    required this.descripcion
  });

  @override
  State<DialogoActualizarTarea> createState() => _DialogoActualizarTareaState();
}

class _DialogoActualizarTareaState extends State<DialogoActualizarTarea> {

  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool habilitado = false;

  @override
  void initState() {
    super.initState();

    tituloController.text = widget.titulo;
    descripcionController.text = widget.descripcion;
  }

  comprobarCampos() {

    if (tituloController.text != widget.titulo || descripcionController.text != widget.descripcion){
      habilitado = true;
    } else {
      habilitado = false;
    }

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 310,
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Actualizar tarea",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: tituloController,
                  onChanged:(value) => comprobarCampos(),
                  validator: (value) {
                    if (value!.isEmpty) return "Campo vacío";
                  },
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Limpiar Habitación",
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  onChanged:(value) => comprobarCampos(),
                  controller: descripcionController,
                  validator: (value) {
                    if (value!.isEmpty) return "Campo vacío";
                  },
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Descripción",
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancelar",
                          style: GoogleFonts.roboto(
                              color: Colors.red,
                              fontWeight: FontWeight.w600
                          ),
                        )
                    ),
                    TextButton(
                        onPressed: habilitado ? () {

                          if (!formKey.currentState!.validate()) {
                            return ;
                          }

                          DialogoActualizarTareaResponse response = DialogoActualizarTareaResponse(
                              titulo: tituloController.text,
                              descripcion: descripcionController.text,
                              tituloAnterior: widget.titulo,
                              descripcionAnterior: widget.descripcion
                          );

                          Navigator.pop(context, response);

                        } : null,
                        child: Text(
                          "Actualizar",
                          style: GoogleFonts.roboto(
                            color: habilitado ? Color(0xff0F52FF) : Colors.black12,
                            fontWeight: FontWeight.w600
                          ),
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
