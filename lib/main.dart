import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'meusEventos.dart';
import 'telaMapa.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double longitude ;
  double latitude ;
  List<Marker> myMarker = [];
  @override
  void initState(){
    super.initState();
    getCurrentLocation();
  }
  getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = double.parse('${position.latitude}');
      longitude = double.parse('${position.longitude}');
      print("cords");
      print(latitude);
      print(longitude);
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
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (latitude == null){
              myMarker.add(
                  new Marker(
                      width: 45.0,
                      height: 45.0,
                      point: new LatLng(37.42,-122.08),
                      builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.red,
                            iconSize: 45.0,
                            onPressed: (){
                              print("Clicou ein 1");
                            },
                          )
                      )
                  )
              );
              myMarker.add(
                  new Marker(
                      width: 45.0,
                      height: 45.0,
                      point: new LatLng(37.427877,-122.090115),
                      builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.red,
                            iconSize: 45.0,
                            onPressed: (){
                              print("Clicou ein 2");
                            },
                          )
                      )
                  )
              );
              myMarker.add(
                  new Marker(
                      width: 45.0,
                      height: 45.0,
                      point: new LatLng(37.406555,-122.078291),
                      builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.red,
                            iconSize: 45.0,
                            onPressed: (){
                              setState (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => telaEventoPublico(2)));
                              }
                              );
                              print("Clicou ein 3");
                            },
                          )
                      )
                  )
              );
              return Container(
                  child : Center(
                    child: SpinKitThreeBounce(
                      color: Colors.redAccent,
                      size: 50.0,
                    ),
                  )
              );
            };
            return FlutterMap(
              options: new MapOptions(
                  center: new LatLng(latitude , longitude),
                  minZoom: 0.0
              ),
              layers: [
                new TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a','b','c']

                ),

                new MarkerLayerOptions(markers: myMarker),
              ],
            );
          },
        ),
      )
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

