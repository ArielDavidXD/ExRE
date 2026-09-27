import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,

      bottomNavigationBar: BottomNavigationBar(currentIndex: _getCurrentIndex(context),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/inicio');
              break;

            case 1:
              context.go('/catalogo');
              break;

            case 2:
              context.go('/galeria');
              break;

            case 3:
              context.go('/favoritos');
              break;
            case 4:
              context.go('/progreso');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "Inicio",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Catalogo",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: "Galeria",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favoritos",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.percent),
            label: "Progreso",
          ),

        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location.startsWith('/catalogo')) {
      return 1;
    }

    if (location.startsWith('/galeria')) {
      return 2;
    }

    if (location.startsWith('/favoritos')) {
      return 3;
    }

    if (location.startsWith('/progreso')) {
      return 4;
    }

    return 0;
  }
}

