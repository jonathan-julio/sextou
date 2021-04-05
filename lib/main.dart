import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:menu_lateral/telaMapa.dart';
import 'meusEventos.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Sextou' ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var cordenadas = "";
  double longetude = -35.2;
  double latitude = -5.8;
  Future<Double> getCurrentLocation() async {
    var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      cordenadas = "$position";
      cordenadas = cordenadas.replaceAll("Lat: ", "");
      cordenadas = cordenadas.replaceAll(" Long: ", "");
      cordenadas.split(",");
      latitude = double.parse(cordenadas[0]);
      longetude = double.parse(cordenadas[1]);
      print(cordenadas);
      return longetude;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container (
              width:  double.infinity,
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
                              "https://www.meiahora.com.br/_midias/jpg/2020/11/27/700x930/1_mc_poze-20603451.jpg"
                          ),
                          fit: BoxFit.fill
                        ),
                      ),
                    ),
                    Text( "Mc Poze", // Nomeusuario
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    Text( "mcpoze@mopaz.com", // Emailsuario
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list_rounded ),
              title: Text("Meus eventos",style: new TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 20.0)
              ),
              onTap: (){
                setState (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => meusEventos()));
                        }
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_location_alt ),
              title: Text("Criar Novo evento", style: new TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 20.0)
                ),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.add ),
              title: Text("Adicionar evento", style: new TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 20.0)
              ),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.zoom_in ),
              title: Text("Eventos em destaque", style: new TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 20.0)
              ),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.logout ),
              title: Text("Logout", style: new TextStyle(
                  fontWeight: FontWeight.normal, fontSize: 20.0)
              ),
              onTap: (){
              },
            ),
          ],
        ),

      ),
      body : Container(
        child: FutureBuilder(
            future : getCurrentLocation(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (cordenadas == null){
              return Container(
                  child: FlatButton(
                   onPressed: (){
                     setState (() {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (BuildContext context) => telaMapa()));
                     }
                     );
                   },
                   color: Colors.redAccent,
                   child: Text("Atualizar minha localização",
                     style: TextStyle(
                       color: Colors.white,
                     )),
                  )
              );
            };
          },
        ),
      ),
    );
  }

}
/*
return FlutterMap(
                    options: new MapOptions(
                      center: new LatLng(40.00 , -20.00),
                        minZoom: 10.0
                    ),
                    layers: [
                      new TileLayerOptions(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a','b','c']
                      )
                    ],
                  );
 */

