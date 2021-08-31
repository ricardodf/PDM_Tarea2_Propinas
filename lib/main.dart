import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2 - is714522',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calcular IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final heightInputController = TextEditingController();
  final weightInputController = TextEditingController();

  bool isFemale = true;
  var imcToShow = "";

  @override
  void dispose() {
    heightInputController.dispose();
    weightInputController.dispose();
    super.dispose();
  }

  void calculate() {
    var total = double.parse(weightInputController.text) /
        (double.parse(heightInputController.text) *
            double.parse(heightInputController.text));
    setState(() {
      imcToShow = total.toStringAsPrecision(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Ingrese sus datos para calcular el IMC")],
            ),
            Container(height: 18),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isFemale = true;
                    });
                  },
                  icon: Icon(Icons.female,
                      color: isFemale ? Colors.blue : Colors.grey)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isFemale = false;
                    });
                  },
                  icon: Icon(Icons.male,
                      color: isFemale ? Colors.grey : Colors.blue)),
            ]),
            Row(
              children: [
                Icon(Icons.height),
                Container(width: 18),
                Expanded(
                    child: TextField(
                  controller: heightInputController,
                  decoration: const InputDecoration(
                      hintText: 'Ingresar altura (metros)'),
                ))
              ],
            ),
            Container(height: 12),
            Row(
              children: [
                Icon(Icons.line_weight),
                Container(width: 18),
                Expanded(
                    child: TextField(
                        controller: weightInputController,
                        decoration: const InputDecoration(
                            hintText: 'Ingresar peso (kilos)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]))
              ],
            ),
            Container(height: 18),
            TextButton(
              child: const Text('Calcular'),
              onPressed: () => [
                calculate(),
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Tu IMC: $imcToShow'),
                    content: Column(
                      children: [
                        isFemale
                            ? Text("Tabla del IMC para mujeres")
                            : Text("Tabla del IMC para hombres"),
                        Container(height: 16),
                        Row(
                          children: [
                            Text("Edad"),
                            Container(width: 12),
                            Text("IMC Ideal")
                          ],
                        ),
                        Row(
                          children: [
                            Text("16-17"),
                            Container(width: 12),
                            isFemale ? Text("19-24") : Text("20-26")
                          ],
                        ),
                        Row(
                          children: [
                            Text("18-19"),
                            Container(width: 12),
                            isFemale ? Text("19-24") : Text("20-26")
                          ],
                        ),
                        Row(
                          children: [
                            Text("19-24"),
                            Container(width: 12),
                            isFemale ? Text("19-24") : Text("20-26")
                          ],
                        ),
                        Row(
                          children: [
                            Text("25-34"),
                            Container(width: 12),
                            isFemale ? Text("20-25") : Text("22-27")
                          ],
                        ),
                        Row(
                          children: [
                            Text("35-44"),
                            Container(width: 12),
                            isFemale ? Text("21-26") : Text("23-28")
                          ],
                        ),
                        Row(
                          children: [
                            Text("44-54"),
                            Container(width: 12),
                            isFemale ? Text("22-27") : Text("24-29")
                          ],
                        ),
                        Row(
                          children: [
                            Text("54-64"),
                            Container(width: 12),
                            isFemale ? Text("23-28") : Text("26-31")
                          ],
                        ),
                        Row(
                          children: [
                            Text("65-90"),
                            Container(width: 12),
                            isFemale ? Text("25-30") : Text("27-32")
                          ],
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Aceptar'),
                        child: const Text('Aceptar'),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
