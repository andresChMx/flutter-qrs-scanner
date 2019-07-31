import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:flutter_map/flutter_map.dart';
class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map=MapController();
  List<String> tiposMapa=<String>['streets', 'dark','light', 'outdoors', 'satellite'];
  int currentTipoMapa=0;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Coordenadas QR"),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.my_location),
            onPressed: (){map.move(scan.getLatLng(), 15);},
          )
        ],
      ),
      body:_crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        setState(() {
          currentTipoMapa=(currentTipoMapa+1)%tiposMapa.length;
        });
      },
    );
  }

  Widget _crearFlutterMap(ScanModel scan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center:scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan)
      ],
    );
  }

  TileLayerOptions _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiYW5kY2hvcXVlbSIsImEiOiJjanlxbDVxbTAwMHp0M2RxcDQ4MHp4MDE0In0.2-iFq1rdqXvGZumHmZdMYQ',
        'id':'mapbox.${tiposMapa[currentTipoMapa]}'// streets, dark,light, outdoors, satellite
      }
    );
  }

  _crearMarcadores(ScanModel scan){
    return MarkerLayerOptions(
      markers:<Marker>[
        Marker(
          width: 100.0,
          height:100.0,
          point:scan.getLatLng(),
          builder: (context){
            return Container(child: Icon(Icons.location_on,size: 70.0,color: Theme.of(context).primaryColor,),);
          }
        )
      ]
    );
  }
}