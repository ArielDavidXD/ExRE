import 'dart:math';

import 'package:exre/data/recurso.dart';
import 'package:exre/screens/detalles_screen.dart';
import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';

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

    if (tipo == "texto") {
      return Icons.article;
    }

    if (tipo == "libro") {
      return Icons.menu_book;
    }

    return Icons.description;
  }

  Widget crearTarjetas(Recurso recursos, int index) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetallesScreen(
                recurso: recursos,
              ),
            ),
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
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 10,
                      child: Icon(
                        obtenerIcono(recursos.tipo),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 40),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "${recursos.titulo}",
                ),

                Wrap(
                  spacing: 10,
                  children: [
                    Text(
                      "${recursos.categoria}",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),

                    Text(
                      "${recursos.autor}",
                    ),
                  ],
                ),

                SizedBox(height: 5),

                Wrap(
                  spacing: 10,
                  children: [
                    Text(
                      "${recursos.duracion}",
                    ),

                    Text(
                      "${recursos.nivel}",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final favoritos = recursos.where((recurso) => recurso.favorito).toList();

    return Scaffold(
      appBar: AppBar(
      title: const Text("Favoritos", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
    ),
      body: ListView.separated(
            itemCount: favoritos.length,

            itemBuilder: (context, index) {
              final recursos = favoritos[index];

              return crearTarjetas(recursos, index);
            },

            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
          ),

    );
  }
}
