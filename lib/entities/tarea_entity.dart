class TareaEntity {

  String id;
  String titulo;
  String descripcion;
  DateTime fecha;
  bool completado;

  TareaEntity({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.completado
  });

}