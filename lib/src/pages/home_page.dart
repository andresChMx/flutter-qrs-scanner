import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scan_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              switch (currentIndex) {
                case 0:
                  //return MapasPage();
                  break;
                case 1:
                  scansBloc.borrarScanTodos();
                  break;
              }
            },
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: (){_scanQR(context);},
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    String futureString = 'http://google.com';
    // try{
    //   print("asdf");
    //   futureString= await new QRCodeReader().scan();
    // }catch(e){
    //   futureString=e.toString();
    // }
    if (futureString != null) {
      ScanModel scan = ScanModel(valor: futureString);
      scansBloc.agregarScans(scan);

      ScanModel scan2 = ScanModel(valor: 'geo:37.23433,-115.80666');
      scansBloc.agregarScans(scan2);
      if(Platform.isIOS){
        Future.delayed(Duration(milliseconds:750),(){
          utils.abrirScan(context,scan);
        });
      }else{
        utils.abrirScan(context,scan);
      }
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Maps')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Directions'))
      ],
    );
  }
}
