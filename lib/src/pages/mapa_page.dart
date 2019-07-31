import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:flutter_map/flutter_map.dart';
class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenadas QR"),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body:_crearFlutterMap(scan)
    );
  }
  Widget _crearFlutterMap(ScanModel scan){
    return FlutterMap(
      options: MapOptions(
        center:scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _crearMapa()
      ],
    );
  }
  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiYW5kY2hvcXVlbSIsImEiOiJjanlxbDVxbTAwMHp0M2RxcDQ4MHp4MDE0In0.2-iFq1rdqXvGZumHmZdMYQ',
        'id':'mapbox.streets'
      }
    );
  }
}