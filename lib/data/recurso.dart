class Recurso {
  final String titulo;
  final String categoria;
  final String autor;
  final String duracion;
  final String nivel;
  final String tipo;
  final String descripcion;

  bool favorito;
  bool completado;

  Recurso({
    required this.titulo,
    required this.categoria,
    required this.autor,
    required this.duracion,
    required this.nivel,
    required this.tipo,
    required this.descripcion,
    this.favorito = false,
    this.completado = false,
  });



}