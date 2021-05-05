import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Evento {
  String id;
  String nome;
  String email;
  String local;
  Evento(String id, String nome, String email, String local) {
    this.id = id;
    this.nome = nome;
    this.email = email;
    this.local = local;
  }
}


class meusEventos extends StatelessWidget{
  final String id;
  const meusEventos({Key key, this.id}) : super(key: key);

  Future <List<Evento>> _getUsers() async {
    var data = await http.get("https://8a9bacc5a169.ngrok.io/api/v1/meus-eventos/${id}");
    var jsonData = json.decode(data.body);
    List<Evento> eventos = [];
    for (var u in jsonData){
      //print(u[0]);
      Evento user = Evento(u[0]['_id'], u[0]['name'], u[0]['sobre'],  u[0]['address1']);
      eventos.add(user);
    }
    return eventos;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meus eventos"),
      ),
      body : Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.data == null){
              return Container(
                  child : Center(
                    child: SpinKitThreeBounce(
                    color: Colors.redAccent,
                    size: 50.0,
                  ),
                  )
              );
            };
            print(snapshot);
            return ListView.builder(
                itemExtent: 90.0,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return Card(child: ListTile(
                    leading: Image(
                        image : NetworkImage('https://hongkong.imd.ufrn.br/filemanagerportal/source/2020/Pr%C3%A9dio%20IMD.jpg'),
                      height: 70.0,
                      width: 70.0,
                    ),
                    title: Text(snapshot.data[index].nome),
                    subtitle:  Text( "${snapshot.data[index].email} \n ${snapshot.data[index].local}" ),
                      trailing : Icon(Icons.more_vert , size: 40.0),
                        onTap: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (BuildContext context) => meusEventos()));

                        },
                  ));
                });
          },
        ),
      )
    );
  }
}
