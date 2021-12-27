import 'modelos.dart';
import 'package:flutter/material.dart';

class DibujaNodo extends CustomPainter{
  List<Nodo> vNodo;

  DibujaNodo(this.vNodo);

  _msg(double x, double y, String msg, Canvas canvas, double fontSize){
    TextSpan span =  TextSpan(style:  TextStyle(color: Colors.black,fontSize: fontSize), text: msg);
    TextPainter tp =  TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,  Offset(x,y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint lapiz = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = Colors.amber[700];

    Paint pintura = Paint()
    ..style = PaintingStyle.fill;

    for(var item in vNodo){
      pintura.color = item.color;
      canvas.drawCircle(Offset(item.x, item.y), item.radio, pintura);
      canvas.drawCircle(Offset(item.x, item.y), item.radio, lapiz);
      _msg(item.x-10*item.nombre.length, item.y-15, item.nombre, canvas, 25);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DibujaUnion extends CustomPainter{
  List<Union> vUnion;

  DibujaUnion(this.vUnion);

  _msg(double x, double y, String msg, Canvas canvas, double fontSize){
    TextSpan span =  TextSpan(style:  TextStyle(color: Colors.black,fontSize: fontSize), text: msg);
    TextPainter tp =  TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,  Offset(x,y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint lapiz = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.black54;

    for(var item in vUnion){
      canvas.drawLine(Offset(item.n1.x, item.n1.y), Offset(item.n2.x, item.n2.y), lapiz);
      _msg((item.n2.x - item.n1.x)/2 + item.n1.x, (item.n2.y - item.n1.y)/2 + item.n1.y, item.peso.toString(), canvas, 15);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}