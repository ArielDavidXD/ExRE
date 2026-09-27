import 'dart:math';

import 'package:exre/screens/Catalogo_screen.dart';
import 'package:exre/screens/detalles_screen.dart';
import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';
import 'package:exre/data/recurso.dart';

class GaleriaScreen extends StatefulWidget {
  const GaleriaScreen({super.key});

  @override
  State<GaleriaScreen> createState() => _GaleriaScreenState();
}

class _GaleriaScreenState extends State<GaleriaScreen> {

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

  Widget crearTarjeta(
      Recurso recurso, int index
      ) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetallesScreen(recurso: recurso),
            ),
          );
        },

        child: Column(
          children: [

            // PARTE DE ARRIBA
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: obtenerColor(index),),

                child: Stack(
                  children: [

                    // COMPLETADO
                    if (recurso.completado)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: CircleAvatar(
                          radius: 18,
                          child: Icon(
                            Icons.check,
                            size: 20,
                          ),
                        ),
                      ),

                    // FAVORITO
                       Positioned(
                      top: 10,
                      right: 10,
                         child: InkWell(
                         onTap: (){
                        setState(() {
                          recurso.favorito = !recurso.favorito;
                        });
                         },
                      child: CircleAvatar(
                        radius: 18,
                        child: Icon(
                          recurso.favorito
                              ? Icons.star
                              : Icons.star_border,
                          size: 20,
                        ),
                      ),
                    ),
                      ),



                    // ICONO CENTRAL
                    Center(
                      child: Icon(
                       obtenerIcono(recurso.tipo),
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // PARTE DE ABAJO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    recurso.titulo,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    recurso.categoria,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Galeria",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,

          children: [
            for (int index = 0; index < recursos.length; index++)
              crearTarjeta(
                recursos[index],
                index,
              ),
          ],
        ),
      ),
    );
  }
}