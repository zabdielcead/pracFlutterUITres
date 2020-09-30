import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';


class CircularProgressPage extends StatefulWidget {
  
  

  @override
  _CircularProgressPageState createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> with SingleTickerProviderStateMixin{

  AnimationController controller;
  double porcentaje       = 0.0 ;
  double nuevoPorcentaje  = 0.0;


  @override
  void initState() { 
    controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    controller.addListener(() {
      //print('valor controller ${controller.value}');

      setState(() {
        porcentaje = lerpDouble(porcentaje, nuevoPorcentaje, controller.value);  // función que permite interpolar dos numeros
        
      });
    });

    super.initState();
    
  }

  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          porcentaje = nuevoPorcentaje;
          nuevoPorcentaje += 10;

          if(porcentaje > 100){
              nuevoPorcentaje = 0;
              porcentaje = 0;
          }
          controller.forward( from: 0.0 );

          setState(() {
            
          });
        },
        backgroundColor: Colors.pink,
        child: Icon(Icons.refresh),
      ),
      body: Center(
              child: Container(
                    padding: EdgeInsets.all(5),
                    width: 300,
                    height: 300,
                   // color: Colors.red,
                    child: CustomPaint(
                      painter: _MiRadialProgress(porcentaje),
                    ),
                  ),
              ),
    );
  }
}

class _MiRadialProgress extends CustomPainter {

  final porcentaje;

  _MiRadialProgress(this.porcentaje);



  @override
  void paint(Canvas canvas, Size size) {
      // TODO: implement paint
      // circulo completado

      //final porcentaje = 40;

      final paint = new Paint()// lapiz
            ..strokeWidth = 4
            ..color       = Colors.grey
            ..style       = PaintingStyle.stroke;

            final center = new Offset(size.width * 0.5, size.height/2);
            final radio  = min(size.width * 0.5, size.height *0.5); 

            canvas.drawCircle(center,radio , paint);

            // arco
             final paintArco = new Paint()// lapiz
                  ..strokeWidth = 10
                  ..color       = Colors.pink
                  ..style       = PaintingStyle.stroke;
            
            // parte que se ira llenando   
            double arcAngle = 2 * pi * (porcentaje / 100);
            canvas.drawArc(
                            Rect.fromCircle(center:center, radius: radio), 
                            -pi/2, 
                            arcAngle, 
                            false, 
                            paintArco
                          );

    }
  
    @override
    bool shouldRepaint(CustomPainter oldDelegate)  => true;


}