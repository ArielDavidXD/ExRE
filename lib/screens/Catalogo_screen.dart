import 'package:exre/data/recurso.dart';
import 'detalles_screen.dart';
import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';
import 'dart:math';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  String filtroSeleccionado = "Todos";

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

  final categorias =
  recursos.map((recursos) => recursos.categoria).toSet().toList();

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
                      child: Icon(obtenerIcono(recursos.tipo),
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

  Widget botonFav(bool estaod, VoidCallback alTocar) {
    return InkWell(
      onTap: alTocar,
      child: Icon(
        estaod
            ? Icons.star
            : Icons.star_border_outlined,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final recursosFiltrados = filtroSeleccionado == "Todos"
        ? recursos
        : recursos
        .where((recurso) => recurso.categoria == filtroSeleccionado)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Catalogo",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Buscar por titulo, categoria o autor",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),


            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

            child: Row(
              children: [
                ChoiceChip(
                  label: const Text("Todos"),
                  selected: filtroSeleccionado == "Todos",
                  onSelected: (_) {
                    setState(() {
                      filtroSeleccionado = "Todos";
                    });
                  },
                ),
                for(final categoria in categorias)
                    ChoiceChip(
                    label:  Text(categoria),
                    selected: filtroSeleccionado == categoria,
                    onSelected: (value) {
                    setState(() {
                    filtroSeleccionado = categoria;
                    });
                    },
                    ),


              ],
            ),
            ),

            SizedBox(height: 15),

            Text("Resultados (${recursosFiltrados.length})"),

            SizedBox(height: 10),

            Expanded(
              child: ListView.separated(
                itemCount: recursosFiltrados.length,

                itemBuilder: (context, index) {
                  final recurso = recursosFiltrados[index];

                  return crearTarjetas(recurso, index);
                },

                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}