import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
class DireccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future:DBProvider.db.getTodosScans(),
      builder: (BuildContext context,AsyncSnapshot<List<ScanModel>> snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.data.length==0){
          return Center(child: Text("No hay informacion"),);
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context,i){
            return  ListTile(
                leading: Icon(Icons.cloud_circle,color: Theme.of(context).primaryColor),
                title: Text(snapshot.data[i].valor),
                trailing:Icon(Icons.arrow_right,color: Colors.grey,)
              );
          },
        );
        
      },
    );
  }
}