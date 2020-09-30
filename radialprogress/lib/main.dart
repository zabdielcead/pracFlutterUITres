import 'package:flutter/material.dart';
import 'package:radialprogress/src/labs/circular_progress_page.dart';
import 'package:radialprogress/src/pages/graficas_circulares_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Progrees',
      home: GraficasCircularesPage()
      
    );
  }
}