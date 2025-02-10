import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tareas_app/responses/dialogo_crear_tarea_response.dart';

dialogoCrearTarea(BuildContext context) {

  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  "Crea una tarea",
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: tituloController,
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
                        onPressed: () {

                          if (!formKey.currentState!.validate()) {
                            return ;
                          }

                          DialogoCrearTareaResponse response = DialogoCrearTareaResponse(
                            titulo: tituloController.text,
                            descripcion: descripcionController.text
                          );

                          Navigator.pop(context, response);

                        },
                        child: Text(
                          "Crear",
                          style: GoogleFonts.roboto(
                              color: Color(0xff0F52FF),
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
