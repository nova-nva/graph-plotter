import 'dart:math';

import 'package:flutter/material.dart';

import 'graficos.dart';
import 'modelos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int mode = -1;
  int nombreNodo = 1;
  List<Nodo> vNodo = [];
  List<Union> vUnion = [];

  // Controlar los clics
  List<int> vPos = [0, 0];
  int pos = 0;

  int esNodo(x, y){
    int posicion = -1;
    for(var i = 0; i<vNodo.length; i++){
      double distancia = sqrt(pow(x - vNodo[i].x, 2) + pow(y - vNodo[i].y, 2));
      if(distancia < 40){ // menor al radio
        posicion = i;
      }
    }
    return posicion;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              painter: DibujaNodo(vNodo),
            ),
            CustomPaint(
              painter: DibujaUnion(vUnion),
            ),
            GestureDetector(
              onPanDown: (desplazamiento){
                setState(() {
                  switch(mode){
                    case 1:
                      vNodo.add(Nodo(desplazamiento.globalPosition.dx, desplazamiento.globalPosition.dy, 40, Colors.amber[200], nombreNodo.toString()));
                      nombreNodo++;
                      break;
                    case 2:
                      int posicionRecuperada = esNodo(desplazamiento.globalPosition.dx, desplazamiento.globalPosition.dy);
                      if(posicionRecuperada >= 0){
                        print("Es nodo -> $posicionRecuperada");
                      }
                      else{
                        print("No es nodo");
                      }
                      break;
                    case 4:
                      int posicionRecuperada = esNodo(desplazamiento.globalPosition.dx, desplazamiento.globalPosition.dy);
                      if(posicionRecuperada >= 0){
                        vPos[pos] = posicionRecuperada;
                        pos = (pos+1)%2;
                        if(pos == 0){
                          vUnion.add(Union(vNodo[vPos[0]], vNodo[vPos[1]], 25));
                          pos = 0;
                        }
                      }
                      break;
                  }
                });
              },
              onPanUpdate: (desp){
                setState(() {
                  if(mode == 3) {
                    int posicionRecuperada = esNodo(
                        desp.globalPosition.dx, desp.globalPosition.dy);
                    if (posicionRecuperada >= 0) {
                      vNodo[posicionRecuperada].x = desp.globalPosition.dx;
                      vNodo[posicionRecuperada].y = desp.globalPosition.dy;
                    }
                  }
                });
              },
            )
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(Icons.add_circle, color: (mode == 1) ? Colors.green : Colors.red,),
                  onPressed: (){
                    setState(() {
                      mode = 1;
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.search, color: (mode == 2) ? Colors.green : Colors.red,),
                  onPressed: (){
                    setState(() {
                      mode = 2;
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.call_missed_outgoing, color: (mode == 3) ? Colors.green : Colors.red,),
                  onPressed: (){
                    setState(() {
                      mode = 3;
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.edit, color: (mode == 4) ? Colors.green : Colors.red,),
                  onPressed: (){
                    setState(() {
                      mode = 4;
                    });
                  }
              )

            ],
          ),
        ),
      ),
    );
  }
}
