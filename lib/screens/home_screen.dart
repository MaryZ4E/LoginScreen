import 'package:flutter/material.dart';
import 'package:login/widgets/formulario.dart';

//import 'package:login/screens/photo_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(227),
        title: const Text('Registro'),
        
        
        
      ),
      
      body: const Formulario() ,
      
      
    );
  }
}