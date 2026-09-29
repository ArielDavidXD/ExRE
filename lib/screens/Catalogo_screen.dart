import 'package:exre/data/recurso.dart';
import 'package:go_router/go_router.dart';
import 'detalles_screen.dart';
import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';
import 'package:exre/core/app_colors.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  String filtroSeleccionado = "Todos";
  String textoBusqueda = "";

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

  final categorias = recursos
      .map((recursos) => recursos.categoria)
      .toSet()
      .toList();

  IconData obtenerIcono(String tipo) {
    if (tipo == "video") {
      return Icons.play_arrow;
    }

    if (tipo == "lectura") {
      return Icons.article;
    }

    if (tipo == "practica") {
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

  Widget botonFav(bool estaod, VoidCallback alTocar) {
    return InkWell(
      onTap: alTocar,
      child: Icon(
        estaod ? Icons.star : Icons.star_border_outlined,
        color: estaod
            ? AppColors.primary
            : AppColors.textSecondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recursosFiltradsos = recursos.where((recursos) {
      final coincideCategoria =
          filtroSeleccionado == "Todos" ||
              recursos.categoria == filtroSeleccionado;

      final busqueda = textoBusqueda.toLowerCase();

      final coincideBusqueda =
          recursos.titulo.toLowerCase().contains(busqueda) ||
              recursos.categoria.toLowerCase().contains(busqueda) ||
              recursos.autor.toLowerCase().contains(busqueda);

      return coincideBusqueda && coincideCategoria;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,

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
                color: AppColors.surface,
                border: Border.all(
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(10),
              ),

              child: TextField(
                style: TextStyle(
                  color: AppColors.text,
                ),

                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),

                  hintText:
                  "Buscar por titulo, categoria o autor",

                  hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                  ),

                  border: InputBorder.none,

                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15),
                ),

                onChanged: (text) {
                  setState(() {
                    textoBusqueda = text;
                  });
                },
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

                    selectedColor: AppColors.text,
                    backgroundColor: AppColors.surface,

                    labelStyle: TextStyle(
                      color: filtroSeleccionado == "Todos"
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),

                    onSelected: (_) {
                      setState(() {
                        filtroSeleccionado = "Todos";
                      });
                    },
                  ),

                  for (final categoria in categorias)
                    ChoiceChip(
                      label: Text(categoria),

                      selected: filtroSeleccionado == categoria,

                      selectedColor: AppColors.text,
                      backgroundColor: AppColors.surface,

                      labelStyle: TextStyle(
                        color: filtroSeleccionado == categoria
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),

                      onSelected: (_) {
                        setState(() {
                          filtroSeleccionado = categoria;
                        });
                      },
                    ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Text(
              "Resultados (${recursosFiltradsos.length})",
              style: TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: ListView.separated(
                itemCount: recursosFiltradsos.length,

                itemBuilder: (context, index) {
                  final recurso = recursosFiltradsos[index];

                  return crearTarjetas(
                    recurso,
                    index,
                  );
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