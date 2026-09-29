import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:exre/data/recursos.dart';
import 'package:exre/core/app_colors.dart';

class Inicio_screen extends StatefulWidget {
  const Inicio_screen({super.key});

  @override
  State<Inicio_screen> createState() => _inicio_screenState();
}

class _inicio_screenState extends State<Inicio_screen>
    with WidgetsBindingObserver {
  String estadoCiclo = "La app está activa y visible";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.resumed:
          estadoCiclo = "La app está activa y visible";
          break;

        case AppLifecycleState.inactive:
          estadoCiclo = "La app está inactiva";
          break;

        case AppLifecycleState.paused:
          estadoCiclo = "La app está en segundo plano";
          break;

        case AppLifecycleState.detached:
          estadoCiclo = "La app está desconectada";
          break;

        case AppLifecycleState.hidden:
          estadoCiclo = "La app está oculta";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,

        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "BIENVENIDO A",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),

            Text(
              "ExRE",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      body:
      SingleChildScrollView(
    child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explorador de Recursos de Estudio",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),

            SizedBox(height: 5),

            Text(
              "Consulta y organiza tus recursos de aprendizaje.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),

            SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: Card(
                    color: AppColors.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "${recursos.length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                          Text(
                            "Disponibles",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Card(
                    color: AppColors.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "${recursos.where((recursos) => recursos.favorito == true).length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                          Text(
                            "Favoritos",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Card(
                    color: AppColors.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "${recursos.where((recursos) => recursos.completado == true).length}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                          Text(
                            "Completados",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Accesos Rapidos",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.4,
              shrinkWrap: true,

              children: [
                Card(
                  color: AppColors.catalogo,
                  child: InkWell(
                    onTap: () {
                      context.go('/catalogo');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book,
                          size: 35,
                          color: Colors.white,
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Catalogo",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  color: AppColors.favoritos,
                  child: InkWell(
                    onTap: () {
                      context.go('/favoritos');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: 35,
                          color: Colors.white,
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Favoritos",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  color: AppColors.galeria,
                  child: InkWell(
                    onTap: () {
                      context.go('/galeria');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo,
                          size: 35,
                          color: Colors.white,
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Galeria",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  color: AppColors.progreso,
                  child: InkWell(
                    onTap: () {
                      context.go('/progreso');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.percent,
                          size: 35,
                          color: Colors.white,
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Progreso",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Row(
                children: [
                  Icon(Icons.monitor_heart, color: AppColors.primary),

                  SizedBox(width: 10),
Expanded(child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estado de ciclo de vida",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      Text(
                        estadoCiclo,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
)
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
