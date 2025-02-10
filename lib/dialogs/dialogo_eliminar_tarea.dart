import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tareas_app/responses/dialogo_crear_tarea_response.dart';

dialogoEliminarTarea(BuildContext context) {

  return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 310,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Eliminar tarea",
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
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

                        Navigator.pop(context, true);

                      },
                      child: Text(
                        "Eliminar",
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
  );
}
