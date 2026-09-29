import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';
import 'package:exre/data/recurso.dart';
import 'package:exre/core/app_colors.dart';

class DetallesScreen extends StatefulWidget {
  final Recurso recurso;

  const DetallesScreen({super.key, required this.recurso});

  @override
  State<DetallesScreen> createState() => _DetallesScreenState();
}

class _DetallesScreenState extends State<DetallesScreen> {
  IconData obtenerIcono(String tipo) {
    if (tipo == "video") {
      return Icons.play_arrow;
    }

    if (tipo == "lectura") {
      return Icons.article;
    }

    if(tipo == "practica"){
      return Icons.build;
    }

    if (tipo == "documento") {
      return Icons.description;
    }

    return Icons.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,

              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        obtenerIcono(widget.recurso.tipo),
                        size: 75,
                        color: AppColors.primary,
                      ),
                    ),

                    // FAVORITO
                    Positioned(
                      top: 10,
                      right: 10,

                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.recurso.favorito = !widget.recurso.favorito;
                          });
                        },

                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primary,

                          child: Icon(
                            widget.recurso.favorito
                                ? Icons.star
                                : Icons.star_border,
                            size: 20,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Text(
              "${widget.recurso.categoria}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            Text(
              "${widget.recurso.titulo}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),

            Wrap(
              spacing: 8,
              children: [
                Icon(Icons.man, color: AppColors.primary),

                Text(
                  "${widget.recurso.autor}",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),

            SizedBox(height: 15),

            Wrap(
    spacing: 8,
              runSpacing: 8,
              children: [
                Card(
                  color: AppColors.surface,

                  child: Padding(
                    padding: EdgeInsets.all(10),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          size: 14,
                          color: AppColors.primary,
                        ),

                        Text(
                          "${widget.recurso.duracion}",
                          style: TextStyle(fontSize: 14, color: AppColors.text),
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  color: AppColors.surface,

                  child: Padding(
                    padding: EdgeInsets.all(10),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.north_east,
                          size: 14,
                          color: AppColors.primary,
                        ),

                        Text(
                          "${widget.recurso.nivel}",
                          style: TextStyle(fontSize: 14, color: AppColors.text),
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  color: AppColors.surface,

                  child: Padding(
                    padding: EdgeInsets.all(10),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_arrow,
                          size: 14,
                          color: AppColors.primary,
                        ),

                        Text(
                          "${widget.recurso.tipo}",
                          style: TextStyle(fontSize: 14, color: AppColors.text),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Descripcion",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.text,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "${widget.recurso.descripcion}",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),

            SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.recurso.completado = !widget.recurso.completado;
                      });
                    },

                    child: Row(
                      children: [
                        widget.recurso.completado
                            ? Text(
                                "Retirar de Completado",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              )
                            : Text(
                                "Marcar como Completado",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),

                        SizedBox(width: 5),

                        Icon(Icons.check, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
