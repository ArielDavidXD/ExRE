import 'package:exre/data/recurso.dart';
import 'package:exre/screens/Inicio_screen.dart';
import 'package:exre/screens/detalles_screen.dart';
import 'package:exre/widgets/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/catalogo_screen.dart';
import '../screens/galeria_screen.dart';
import '../screens/favoritos_screen.dart';
import '../screens/progreso_screen.dart';

final GoRouter appRouter = GoRouter(
    initialLocation: '/inicio',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
routes: [
      GoRoute(path: '/inicio',
      builder: (context, state) {
        return const Inicio_screen();
      },
      ),

      GoRoute(path: '/catalogo',
        builder: (context, state) {
          return const CatalogoScreen();
        },
      ),
  GoRoute(path: '/galeria',
    builder: (context, state) {
      return const GaleriaScreen();
    },
  ),

      GoRoute(path: '/favoritos',
      builder: ((context, state) {
        return const FavoritosScreen();
      })),

  GoRoute(path: '/detalles',
  builder: (((context, state) {
    final recurso = state.extra as Recurso;
    return DetallesScreen(recurso: recurso);
  }))),

      GoRoute(path: '/progreso',
      builder: ((context, state) {
        return const ProgresoScreen();
      }))
    ],
      ),
],

);