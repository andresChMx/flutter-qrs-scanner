import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE Scans('
            'id INTEGER PRIMARY KEY,'
            'tipo TEXT,'
            'valor TEXT'
            ')'
            );
        });
  }
  //crear registros
  nuevoScanRaw(ScanModel nuevoScan) async{
    final db=await database;
    final res=await db.rawInsert(
      'INSERT INTO Scans (id,tipo,valor) '
      'VALUES (${nuevoScan.id},${nuevoScan.tipo},${nuevoScan.valor})'
    );
    return res;//retorna numero de inserciones realizadas (1 en este caso)
  }
  //crear registro de forma mas facil,rapida,segura
  nuevoScan(ScanModel nuevoScan) async{
    final db=await database;
    final res=await db.insert('Scans', nuevoScan.toJson());
    return res;
  }
}
