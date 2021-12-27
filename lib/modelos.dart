import 'package:flutter/material.dart';

class Nodo{
  double x, y, radio;
  Color color;
  String nombre;

  Nodo(this.x, this.y, this.radio, this.color, this.nombre);
}

class Union{
  Nodo n1, n2;
  double peso;

  Union(this.n1, this.n2, this.peso);
}