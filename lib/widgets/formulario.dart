import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final GlobalKey<FormState> _formularioEstado = GlobalKey<FormState>();
  String? _imagenSeleccionada;

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagenSeleccionada = pickedFile.path;
      });
    }
  }

  Future<void> _tomarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagenSeleccionada = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formularioEstado,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color.fromARGB(255, 158, 158, 158)),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.black), // Color del texto dentro de la caja
                cursorColor: Colors.blue, // Color del cursor al escribir
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Debe de ingresar un usuario";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Usuario",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey), // Color del texto de sugerencia
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.black), // Color del texto dentro de la caja
                cursorColor: Colors.blue, // Color del cursor al escribir
                validator: (value) {
                   if (value!.isEmpty) {
                  return 'Por favor ingresa tu correo electrónico';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Por favor ingresa un correo electrónico válido';
                }
                return null;
              },
                decoration: const InputDecoration(
                  hintText: "Correo Electrónico",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey), // Color del texto de sugerencia
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.black), // Color del texto dentro de la caja
                cursorColor: Colors.blue, // Color del cursor al escribir
                obscureText: true,
                validator: (value) {
                  if (value!.length < 6) {
                    return "La contraseña debe de contener al menos 6 caracteres";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Contraseña",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey), // Color del texto de sugerencia
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _seleccionarImagen,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imagenSeleccionada != null
                          ? FileImage(File(_imagenSeleccionada!))
                          : null,
                      child: _imagenSeleccionada == null
                          ? Icon(Icons.photo, size: 50)
                          : null,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _tomarFoto,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.camera_alt, size: 50),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formularioEstado.currentState!.validate()) {
                    print("Todo salió bien");
                  } else {
                    print("Hay errores");
                  }
                },
                child: Text("Enviar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Formulario"),
      ),
      body: Formulario(),
    ),
  ));
}
