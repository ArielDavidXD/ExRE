import 'package:exre/data/recurso.dart';
import 'package:exre/screens/detalles_screen.dart';
import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';
import 'package:exre/core/app_colors.dart';
import 'package:go_router/go_router.dart';

class ProgresoScreen extends StatefulWidget {
  const ProgresoScreen({super.key});

  @override
  State<ProgresoScreen> createState() => _ProgresoScreenState();
}

class _ProgresoScreenState extends State<ProgresoScreen>
    with WidgetsBindingObserver {

  final recursosCompletados = recursos
      .where((recurso) => recurso.completado)
      .length;

  final recursosTotal = recursos.length;

  double porcentaje = 0;
  int pend = 0;

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

  final colores = [
    AppColors.catalogo,
    AppColors.galeria,
    AppColors.favoritos,
    AppColors.progreso,
  ];

  Color obtenerColor(int index) {
    return colores[index % colores.length];
  }

  Color obtenerColorCategoria(String categoria) {
    switch (categoria) {
      case "Flutter":
        return AppColors.flutter;

      case "Android":
        return AppColors.android;

      case "Layouts":
        return AppColors.layouts;

      case "Scrollables":
        return AppColors.scrollables;

      case "Slivers":
        return AppColors.slivers;

      case "Navegacion":
        return AppColors.navegacion;

      default:
        return AppColors.primary;
    }
  }

  String estadoCiclo = "La app está activa y visible";
  String horaUltimoEvento = "";

  double porciento(int completados, int total) {
    if (total == 0) {
      return 0;
    }

    return (completados / total) * 100;
  }

  int pendientes(int completados, int total) {
    return total - completados;
  }

  Widget crearTarjetas(Recurso recurso, int index) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(12),

        onTap: () {
          context.push(
            '/detalles',
            extra: recurso,
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(10),

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
                          obtenerIcono(recurso.tipo),
                          size: 25,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      recurso.titulo,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Wrap(
                      spacing: 10,

                      children: [
                        Text(
                          recurso.categoria,
                          style: TextStyle(
                            color: obtenerColor(index),
                          ),
                        ),

                        Text(
                          recurso.autor,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Wrap(
                      spacing: 10,

                      children: [
                        Text(
                          recurso.duracion,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),

                        Text(
                          recurso.nivel,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),

                        const Text(
                          "Completado",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget crearProgresos() {
    final categorias = recursos
        .map((recurso) => recurso.categoria)
        .toSet()
        .toList();

    return ListView.separated(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemBuilder: (context, index) {
        final categoria = categorias[index];

        final totalCategoria = recursos
            .where(
              (recurso) => recurso.categoria == categoria,
        )
            .length;

        final completadosCategoria = recursos
            .where(
              (recurso) =>
          recurso.categoria == categoria &&
              recurso.completado,
        )
            .length;

        final progreso = totalCategoria == 0
            ? 0.0
            : completadosCategoria / totalCategoria;

        final colorCategoria =
        obtenerColorCategoria(categoria);

        return Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,

                      decoration: BoxDecoration(
                        color: colorCategoria,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      categoria,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),

                Text(
                  "$completadosCategoria/$totalCategoria",

                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            LinearProgressIndicator(
              value: progreso,

              minHeight: 5,

              borderRadius: BorderRadius.circular(10),

              backgroundColor:
              AppColors.progressBackground,

              color: colorCategoria,
            ),
          ],
        );
      },

      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },

      itemCount: categorias.length,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    horaUltimoEvento = obtenerHora();
  }

  String obtenerHora() {
    final ahora = DateTime.now();

    return "${ahora.hour.toString().padLeft(2, '0')}:"
        "${ahora.minute.toString().padLeft(2, '0')}";
  }

  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state,
      ) {
    setState(() {
      switch (state) {
        case AppLifecycleState.resumed:
          estadoCiclo =
          "La app está activa y visible";
          break;

        case AppLifecycleState.inactive:
          estadoCiclo =
          "La app está inactiva";
          break;

        case AppLifecycleState.paused:
          estadoCiclo =
          "La app está en segundo plano";
          break;

        case AppLifecycleState.detached:
          estadoCiclo =
          "La app está desconectada";
          break;

        case AppLifecycleState.hidden:
          estadoCiclo =
          "La app está oculta";
          break;
      }

      horaUltimoEvento = obtenerHora();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listaCompletados = recursos
        .where((recurso) => recurso.completado)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,

        foregroundColor: AppColors.text,

        title: const Text(
          "Progreso",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,

                  border: Border.all(
                    color: AppColors.primary,
                  ),

                  borderRadius:
                  BorderRadius.circular(14),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(18),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            "${porciento(
                              recursosCompletados,
                              recursosTotal,
                            ).toInt()}%",

                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),

                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,

                            children: [
                              Text(
                                "$recursosCompletados Completados",

                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.text,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                "${pendientes(
                                  recursosCompletados,
                                  recursosTotal,
                                )} Pendientes",

                                style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                  AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 6,
                        width: double.infinity,

                        child: LinearProgressIndicator(
                          value: recursosTotal == 0
                              ? 0
                              : recursosCompletados /
                              recursosTotal,

                          borderRadius:
                          BorderRadius.circular(10),

                          backgroundColor:
                          AppColors.progressBackground,

                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: AppColors.surface,

                  border: Border.all(
                    color: AppColors.primary,
                  ),

                  borderRadius:
                  BorderRadius.circular(12),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Row(
                    children: [
                      Icon(
                        Icons.history,
                        color:
                        AppColors.textSecondary,
                      ),

                      const SizedBox(width: 10),

                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "Último evento de ciclo de vida",

                            style: TextStyle(
                              fontSize: 12,
                              color:
                              AppColors.textSecondary,
                            ),
                          ),

                          Text(
                            "$estadoCiclo a las "
                                "$horaUltimoEvento",

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: AppColors.background,

                  borderRadius:
                  BorderRadius.circular(10),
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Resumen por categoria",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),

                    const SizedBox(height: 12),

                    crearProgresos(),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Recursos completados",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),

              const SizedBox(height: 10),

              ListView.separated(
                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemBuilder: (context, index) {
                  final recurso =
                  listaCompletados[index];

                  return crearTarjetas(
                    recurso,
                    index,
                  );
                },

                separatorBuilder:
                    (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },

                itemCount:
                listaCompletados.length,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}