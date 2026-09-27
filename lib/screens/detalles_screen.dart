import 'package:exre/data/recursos.dart';
import 'package:flutter/material.dart';
import 'package:exre/data/recursos.dart';
import 'package:exre/data/recurso.dart';

class DetallesScreen extends StatefulWidget {
  final Recurso recurso;

  const DetallesScreen({super.key, required this.recurso});

  @override
  State<DetallesScreen> createState() => _DetallesScreenState();
}

class _DetallesScreenState extends State<DetallesScreen> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: const Icon(Icons.arrow_back),
    onPressed: () {
    Navigator.pop(context);
    },
        ),
      ),

      body: Padding(
    padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,

            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Stack(
                children: [
                     Center(
                child: Icon(
                  obtenerIcono(widget.recurso.tipo),
                  size: 75,
                ),
              ),


                  // FAVORITO
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          widget.recurso.favorito = !widget.recurso.favorito;
                        });
                      },
                      child: CircleAvatar(
                        radius: 18,
                        child: Icon(
                          widget.recurso.favorito
                              ? Icons.star
                              : Icons.star_border,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
        ]
            ),

          ),
          ),

          Text("${widget.recurso.categoria}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
          Text("${widget.recurso.titulo}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
          Wrap(
            spacing: 8,
            children: [
              Icon(Icons.man),
              Text("${widget.recurso.autor}")
            ],
          ),

          SizedBox(height: 15,),


          Row(
            children: [
              Card(
                child: Padding(padding: EdgeInsets.all(10),
                child:
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined, size: 14,),
                    Text("${widget.recurso.duracion}", style: TextStyle(fontSize: 14),),
                  ],
                ),

              ),
              ),

              Card(
                child: Padding(padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.north_east, size: 14,),
                    Text("${widget.recurso.nivel}", style: TextStyle(fontSize: 14),),
                  ],
                ),
                ),

              ),

              Card(
                child: Padding(padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.play_arrow, size: 14,),
                    Text("${widget.recurso.tipo}", style: TextStyle(fontSize: 14),),
                  ],
                ),
                ),
              )
            ],
          ),

          SizedBox(height: 15,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Descripcion", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

              SizedBox(height: 10,),

              Text("${widget.recurso.descripcion}")
            ],
          ),

          SizedBox(height: 40,),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check),
                SizedBox(width: 5,),
                Text("Marcar como completado", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
              ],
            ),

          )
        ],

      ),
      )
    );
  }
}
