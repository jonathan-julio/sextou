import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';




class telaMapa extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus eventos"),
      ),
        body:  FlutterMap(
          options: new MapOptions(
            center: new LatLng(40.00 , -20.00), minZoom: 10.0
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a','b','c']
            )
          ],
        )
      );
  }
}
