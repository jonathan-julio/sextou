
import 'package:flutter/material.dart';

// ignore: camel_case_types
class telaEventoPublico extends StatelessWidget{
telaEventoPublico(int id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evento publico "),
      ),
        body:  Container(
          child: Column(
            children : <Widget>[
            Image(
              image : NetworkImage('https://hongkong.imd.ufrn.br/filemanagerportal/source/2020/Pr%C3%A9dio%20IMD.jpg'),
              width: 500.0,
            ),
              FlatButton.icon(
                color : Colors.redAccent,
                icon: const Icon(Icons.android),
                label: Text('I am a label'),
                onPressed: () {
                  print("foi");
                },),
              Text("Informações do evento aqui"),
              

        ]
          ),

        ),
      );
  }

}
