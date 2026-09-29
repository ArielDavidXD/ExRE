import 'package:exre/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';
import 'package:exre/data/recurso.dart';
import 'package:go_router/go_router.dart';

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

  Widget crearTarjeta(
      Recurso recurso, int index
      ) {
    return Card(
      color: AppColors.surface,
      child: InkWell(
        onTap: () {
          context.push(
            '/detalles',
            extra: recurso,
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    recurso.categoria,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Galeria",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.text
          ),
        ),
      ),

      body: Padding(
        padding:  EdgeInsets.all(20),

        child:GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.85,),
            itemCount: recursos.length,
            itemBuilder: (context, index){
          final recurso = recursos[index];

          return crearTarjeta(recurso, index);
      }

        ),
      ),
    );
  }
}