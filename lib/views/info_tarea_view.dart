import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InfoTareaView extends StatelessWidget {

  final String titulo;
  final String descripcion;
  final DateTime fechaCreacion;
  final bool completado;
  late String fechaFormateada;

  InfoTareaView({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.fechaCreacion,
    required this.completado
  }) {
    fechaFormateada = DateFormat("dd-MM-y--hh-mm-ss").format(fechaCreacion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
        backgroundColor: Colors.transparent,
        title: Container(
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
          ),
          child: Center(
              child: Text(
                titulo,
                style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600),
              )
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
      
              const SizedBox(height: 20,),
      
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichTextPersonalizado(
                        titulo: "Fecha de creación",
                        valor: fechaFormateada
                      ),
                      const SizedBox(height: 10,),
                      RichTextPersonalizado(
                        titulo: "Descripción",
                        valor: descripcion
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        completado ? "Completada" : "No completada",
                        style: GoogleFonts.roboto(
                          color: completado ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class RichTextPersonalizado extends StatelessWidget {

  final String titulo;
  final String valor;

  const RichTextPersonalizado({
    super.key,
    required this.titulo,
    required this.valor
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "$titulo: ",
          style: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          children: [
            TextSpan(
                text: valor,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                )
            )
          ]
      ),
    );
  }
}
