import 'package:exre/core/app_colors.dart';
import 'package:exre/data/recurso.dart';
import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';
import 'package:go_router/go_router.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {

  final colores = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.indigo,
  ];

  Color obtenerColor(int index) {
    return colores[index % colores.length];
  }

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

  Widget crearTarjetas(Recurso recursos, int index) {
    return Card(
      color: AppColors.surface,
      child: InkWell(
        onTap: () {
          context.push(
            '/detalles',
            extra: recursos,
          );
        },

        child: Row(
          children: [

            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: obtenerColor(index),
              ),

              child: Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 20,
                      child: Icon(
                        obtenerIcono(recursos.tipo),
                        size: 25,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "${recursos.titulo}",
                    style: TextStyle(
                      color: AppColors.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  Wrap(
                    spacing: 10,
                    children: [
                      Text(
                        "${recursos.categoria}",
                        style: TextStyle(
                          color: obtenerColor(index),
                        ),
                      ),

                      Text(
                        "${recursos.autor}",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  Wrap(
                    spacing: 10,
                    children: [
                      Text(
                        "${recursos.duracion}",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),

                      Text(
                        "${recursos.nivel}",
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 10),

            InkWell(
              onTap: () {
                setState(() {
                  recursos.favorito = !recursos.favorito;
                });
              },

              child: CircleAvatar(
                radius: 15,
                child: Icon(
                  recursos.favorito
                      ? Icons.star
                      : Icons.star_border,
                  size: 20,
                ),
              ),
            ),

            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final favoritos = recursos
        .where((recurso) => recurso.favorito)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Favoritos",
          style: TextStyle(
            color: AppColors.text,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: favoritos.isEmpty
            ? Center(
          child: Text("No hay favoritos", style: TextStyle(color: AppColors.text, fontSize: 18),),
        )
            :
        ListView.separated(
          itemCount: favoritos.length,

          itemBuilder: (context, index) {
            final recursos = favoritos[index];

            return crearTarjetas(recursos, index);
          },

          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
        ),
      ),
    );
  }
}