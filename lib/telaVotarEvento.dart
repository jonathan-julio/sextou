import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class meuEvento extends StatefulWidget{
  final String idEvento;
  const meuEvento(BuildContext context, id, {Key key, this.idEvento }) : super(key: key);
  @override
  _meusEventos createState() => _meusEventos();
}

class _meusEventos extends State<meuEvento>{

  String name;
  String address1;
  String address2;
  String latitude;
  String longitude;
  String sobre;
  List usuariosVotou;
  Future<String> getEventoId(String id) async {
    var response = await http.post(
        Uri.parse("https://8a9bacc5a169.ngrok.io/api/v1/evento/${id}"));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        var body = json.decode(response.body);
        name = body.name;
        address1 = body.address1;
        address2 = body.address2;
        latitude = body.latitude;
        longitude = body.longitude;
        sobre = body.sobre;
        usuariosVotou = body.usuariosVotou;
      });
    } else {
      throw Exception(json.decode(response.body)['mesage']);
    }
  }

  bool data1 = false;
  bool data2 = false;
  bool hora1 = false;
  bool hora2 = false;

  void _alterarData1(bool newValue, context, String title, String desc) => setState(() {
    data1 = newValue;
    if (data1) {
      data2 = false;
    } else {
    }
  });
  void _alterarData2(bool newValue, context, String title, String desc) => setState(() {
    data2 = newValue;
    if (data2) {
      data1 = false;
    } else {
    }
  });
  void _alterarHora1(bool newValue, context, String title, String desc) => setState(() {
    hora1 = newValue;
    if (hora1) {
      hora2 = false;
    } else {
    }
  });
  void _alterarHora2(bool newValue, context, String title, String desc) => setState(() {
    hora2 = newValue;
    if (hora2) {
      hora1 = false;
    } else {
    }
  });


  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height * 0.16;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Meus eventos"),
        ),
        body : Center(
      child: Material(
      type: MaterialType.transparency,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                child: Image(
                  image : NetworkImage('https://hongkong.imd.ufrn.br/filemanagerportal/source/2020/Pr%C3%A9dio%20IMD.jpg'),
                  width: MediaQuery.of(context).size.width * 1,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  IconButton(
                                    icon: Icon(Icons.calendar_today_outlined ),
                                    color: Colors.redAccent,
                                    iconSize: 15.0,
                                    onPressed: () {
                                    },
                                  ),
                                  Text("09/03/21",style: TextStyle(fontSize: 15,
                                      color: Colors.black)),
                                  Container (
                                      child : Checkbox(
                                          value: data1,
                                          onChanged: (newValue){
                                            _alterarData1(newValue, context,  name, sobre);
                                          }
                                      )
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  IconButton(
                                    icon: Icon(Icons.calendar_today_outlined ),
                                    color: Colors.redAccent,
                                    iconSize: 15.0,
                                    onPressed: () {
                                    },
                                  ),
                                  Text("09/03/21",style: TextStyle(fontSize: 15,
                                      color: Colors.black)),
                                  Container (
                                      child : Checkbox(
                                          value: data2,
                                          onChanged: (newValue){
                                            _alterarData2(newValue, context, name, sobre);
                                          }
                                      )
                                  ),
                                ]
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  IconButton(
                                    icon: Icon(Icons.access_time_sharp ),
                                    color: Colors.redAccent,
                                    iconSize: 15.0,
                                    onPressed: () {
                                    },
                                  ),
                                  Text("07:00",style: TextStyle(fontSize: 15,
                                      color: Colors.black)),
                                  Container (
                                      child : Checkbox(
                                          value: hora1,
                                          onChanged: (newValue){
                                            _alterarHora1(newValue, context,  name, sobre);
                                          }
                                      )
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  IconButton(
                                    icon: Icon(Icons.access_time_sharp ),
                                    color: Colors.redAccent,
                                    iconSize: 15.0,
                                    onPressed: () {
                                    },
                                  ),
                                  Text("07:15",style: TextStyle(fontSize: 15,
                                      color: Colors.black)),
                                  Container (
                                      child : Checkbox(
                                          value: hora2,
                                          onChanged: (newValue){
                                            _alterarHora2(newValue, context,  name, sobre);
                                          }
                                      )
                                  ),
                                ]
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.grey,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Sobre:", style: TextStyle( fontSize: 17)),
                  )
              ),

              Container(
                padding: EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 0.0),
                // width: 200,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${sobre}",
                    maxLines: 3,
                    style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Endereço: ", style: TextStyle( fontSize: 17)),
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
                // width: 200,fontWeight: FontWeight.bold
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Av. Cap. Mor Gouveia, 3000 - Lagoa Nova, Natal - RN, 59078-970",
                    maxLines: 3,
                    style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.grey,
              ),
              Center(
                child: Text("Comparecer ", style: TextStyle( fontSize: 20)),
              ),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Colors.redAccent,
                              child: Container(
                                child: Text("NÃO", style: TextStyle(
                                    color: Colors.white, fontSize: 20),),
                              ),
                              onPressed : () async {
                                Navigator.of(context).pop();
                              }
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Colors.green,
                              child: Container(
                                child: Text("SIM", style: TextStyle(
                                    color: Colors.white, fontSize: 20),),
                              ),
                              onPressed : () async {
                                Navigator.of(context).pop();
                              }
                          ),
                        ),
                      ])
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
