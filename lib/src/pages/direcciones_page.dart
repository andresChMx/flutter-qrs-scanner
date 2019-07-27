import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scan_bloc.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.length == 0) {
          return Center(
            child: Text("No hay informacion"),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, i) {
            return Dismissible(
              background: Container(
                color: Colors.red,
              ),
              key: UniqueKey(),
              onDismissed: (direction) {
                scansBloc.borrarScan(snapshot.data[i].id);
              },
              child: ListTile(
                  leading: Icon(Icons.cloud_circle,
                      color: Theme.of(context).primaryColor),
                  title: Text(snapshot.data[i].valor),
                  subtitle: Text("ID: ${snapshot.data[i].id}"),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: (){utils.abrirScan(context,snapshot.data[i]);},
                ),
            );
          },
        );
      },
    );
  }
}
