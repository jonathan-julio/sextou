import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sextou_app/telaVotarEvento.dart';
import 'loginPage.dart';
import 'telaAddEvento.dart';
import 'meusEventos.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;





class MyHomePage extends StatefulWidget {
  final String title;
  final String id;
  final String name;
  final String email;
  final String senha;
  const MyHomePage({Key key, this.title , this.id, this.name, this.email , this.senha}) : super(key: key);
  _MyHomePageState createState() => _MyHomePageState();

}
class Evento {
  String _id;
  String latitude;
  String longitude;
  Evento(String id ,String latitude, String longitude, ) {
    this._id = id;
    this.latitude = latitude;
    this.longitude = longitude;
  }
}
class _MyHomePageState extends State<MyHomePage> {
  double longitude;
  double latitude;
  List<Marker> myMarker = [];
  List<Evento> eventos = [];
  var eventoJson;
  getCurrentLocation() async {
    final position = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = double.parse('${position.latitude}');
      longitude = double.parse('${position.longitude}');
    });
    print(position.toString());
  }

  void getAllEvents() async {
    var response = await http.get(
        Uri.parse("https://8a9bacc5a169.ngrok.io/api/v1/evento"));
    if (response.statusCode == 200) {
      eventoJson = json.decode(response.body);
      setState(() {
        for (var u in eventoJson){
          eventos.add(new Evento(u['_id'], u['latitude1'].toString(), u['longitude1'].toString()));
        }
      });
    } else {
      throw Exception(json.decode(response.body)['mesage']);
    }
  }
  void initState() {
    super.initState();
    getAllEvents();
    getCurrentLocation();
    //getId(widget.name, widget.senha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sextou"),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Colors.redAccent,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://www.meiahora.com.br/_midias/jpg/2020/11/27/700x930/1_mc_poze-20603451.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Text(
                        widget.name, // Nomeusuario
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Text(
                        widget.email, // Emailsuario
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.list_rounded),
                title: Text("Meus eventos",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => meusEventos(id : widget.id)));
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.add_location_alt),
                title: Text("Criar Novo evento",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => addEventos(id : widget.id)));
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Adicionar evento",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.zoom_in),
                title: Text("Eventos em destaque",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {
                  home: LoginPage();
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (latitude == null) {
                myMarker.add(new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: new LatLng(37.42, -122.08),
                    builder: (context) => new Container(
                            child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45.0,
                          onPressed: () {
                            print("Clicou ein 1");
                          },
                        ))));
                myMarker.add(new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: new LatLng(37.427877, -122.090115),
                    builder: (context) => new Container(
                            child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45.0,
                          onPressed: () {
                              for (var u in eventos) {
                                print(u.latitude);
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyHomePage(title: "sextouu",id : widget.id, name: widget.name,
                                              email : widget.email, senha : widget.senha)));
                            print("Clicou ein 2");
                          },
                        ))));
                myMarker.add(new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: new LatLng(37.406555, -122.078291),
                    builder: (context) => new Container(
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.red,
                              iconSize: 45.0,
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) => meuEvento(context, widget.id)));
                                  });
                                },
                             ))));
                return Container(
                    child: Center(
                      child: SpinKitThreeBounce(
                        color: Colors.redAccent,
                        size: 50.0,
                      ),
                ));
              }
              return FlutterMap(
                options: new MapOptions(
                    center: new LatLng(latitude, longitude), minZoom: 0.0),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  new MarkerLayerOptions(markers: myMarker),
                ],
              );
            },
          ),
        ));
  }
}
