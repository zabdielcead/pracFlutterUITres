
import 'package:flutter/material.dart';
import 'package:radialprogress/src/widgets/radial_progress.dart';


class GraficasCircularesPage extends StatefulWidget {
  

  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {

  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
                                child: Icon(Icons.refresh),
                                onPressed: (){
                                  setState(() {
                                    porcentaje += 10;
                                    if( porcentaje > 100){
                                      porcentaje = 0;
                                    }
                                  });
                                }
                              ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                      CustomRadialProgress(porcentaje: porcentaje, color: Colors.blue,),
                      CustomRadialProgress(porcentaje: porcentaje, color: Colors.red,),
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                      CustomRadialProgress(porcentaje: porcentaje, color: Colors.yellow,),
                      CustomRadialProgress(porcentaje: porcentaje, color: Colors.pink,),
                 ],
               ),
          ]
        )
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  final double porcentaje;
  final Color  color;

  const CustomRadialProgress({   
    @required this.porcentaje,
    @required this.color
  }) ;


  @override
  Widget build(BuildContext context) {
    return Center(
           // child: Text('${porcentaje}%', style: TextStyle(fontSize: 50 ))
            child: Container(
              width: 180,
              height: 180,
              //color: Colors.red,
              child: RadialProgress(
                        procentaje: porcentaje,
                        colorPrimario: color,
                        colorSecundario: Colors.red,
                        grosorSecundario:10.0,
                        grosorPrimario: 20.0,
                    ),
              //child: Text('${porcentaje}%', style: TextStyle(fontSize: 50 ))
            ),
          );
  }
}