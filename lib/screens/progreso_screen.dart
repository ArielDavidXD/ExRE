import 'package:flutter/material.dart';

class ProgresoScreen extends StatefulWidget {
  const ProgresoScreen({super.key});

  @override
  State<ProgresoScreen> createState() => _ProgresoScreenState();
}

class _ProgresoScreenState extends State<ProgresoScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Progreso", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
    );
  }
}
