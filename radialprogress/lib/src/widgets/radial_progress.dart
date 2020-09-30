import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {

  final procentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorSecundario;
  final double grosorPrimario;

  const RadialProgress({
  @required  this.procentaje, 
    this.colorPrimario = Colors.blue, // si no manda color entonces lo tendra en azul
    this.colorSecundario,
    this.grosorSecundario,
    this.grosorPrimario
  }); 
  

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin{

  AnimationController controller;
  double porcentajeAnterior;

  @override
  void initState() {
    // TODO: implement initState
    porcentajeAnterior = widget.procentaje;

    controller = new AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {

    controller.forward( from: 0.0);
    final diferenciaAnimar = widget.procentaje - porcentajeAnterior;
    porcentajeAnterior = widget.procentaje;



    return AnimatedBuilder(
              animation: controller, 

              builder: (BuildContext context, Widget child){
                 return Container(
                    padding: EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: double.infinity,
                    child: CustomPaint(
                      child: CustomPaint(
                        painter: _MiRadialProgress( 
                          ( widget.procentaje - diferenciaAnimar + (diferenciaAnimar* controller.value)),
                          widget.colorPrimario,
                          widget.colorSecundario,
                          widget.grosorSecundario,
                          widget.grosorPrimario
                        )
                      ),
                    )
                  ); 
              }
          );

   
  }
}

class _MiRadialProgress extends CustomPainter {

  final porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorSecundario;
  final double grosorPrimario;
  

  _MiRadialProgress(
    this.porcentaje,
    this.colorPrimario,
    this.colorSecundario,
    this.grosorSecundario,
    this.grosorPrimario
  );



  @override
  void paint(Canvas canvas, Size size) {
      // TODO: implement paint
      // circulo completado

      //final porcentaje = 40;

      final Rect rect = new Rect.fromCircle(
        center: Offset(0,0),
        radius: 160
      );


      final Gradient gradiente =  new LinearGradient(
                                      colors: <Color>[
                                        Color(0xffC012FF),
                                        Color(0xff6D05E8),
                                        Colors.red
                                      ]
                                  );


      final paint = new Paint()// lapiz
            ..strokeWidth = grosorSecundario
            ..color       = Colors.grey
            ..style       = PaintingStyle.stroke;

            final center = new Offset(size.width * 0.5, size.height/2);
            final radio  = min(size.width * 0.5, size.height *0.5); 

            canvas.drawCircle(center,radio , paint);

            // arco
             final paintArco = new Paint()// lapiz
                  ..strokeWidth = grosorPrimario
                 // ..color       = colorPrimario  // se comenta porque se va ameter un gradiente
                  ..shader      = gradiente.createShader(rect)
                  ..strokeCap   = StrokeCap.round
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