import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:running_tracker/models/lari_detail_model.dart';
import 'package:running_tracker/models/lari_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DatabaseInstance {
  final String _databaseName = 'running_tracker.db';
  final int _databaseVersion = 1;

  // Tabel Lari
  final String lariTableName = "lari";
  // ignore: non_constant_identifier_names
  final String id_lari = "id";
  final String mulai = "mulai";
  final String selesai = "selesai";

  // Tabel Lari Detail
  final String lariDetailTableName = "lari_detail";
  // ignore: non_constant_identifier_names
  final String id_lari_detail = "id";
  // ignore: non_constant_identifier_names
  final String lari_id = "lari_id";
  final String latitude = "latitude";
  final String longitude = "longitude";
  final String waktu = "waktu";

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $lariTableName ($id_lari INTEGER PRIMARY KEY, $mulai TEXT NULL, $selesai TEXT NULL)',
    );

    await db.execute(
      'CREATE TABLE $lariDetailTableName ($id_lari_detail INTEGER PRIMARY KEY, $lari_id INTEGER, $latitude DOUBLE, $longitude DOUBLE, $waktu DATETIME)',
    );
  }

  Future<List<LariModel>> getAllLari() async {
    final data = await _database!.query(lariTableName);
    List<LariModel> result = data.map((e) => LariModel.fromJson(e)).toList();

    return result;
  }

  Future<int> insertLari(Map<String, dynamic> row) async {
    final query = await _database!.insert(lariTableName, row);

    return query;
  }

  Future<int> insertLariDetail(Map<String, dynamic> row) async {
    final query = await _database!.insert(lariDetailTableName, row);

    return query;
  }

  Future<List<MapLatLng>> getDetailLari(int lariId) async {
    final data = await _database!
        .rawQuery("SELECT * FROM $lariDetailTableName WHERE lari_id = $lariId");
    List<LariDetailModel> result =
        data.map((e) => LariDetailModel.fromJson(e)).toList();

    List<MapLatLng> arrayMapLatLng = [];

    for (var element in result) {
      arrayMapLatLng.add(MapLatLng(element.latitude, element.longitude));
    }

    return arrayMapLatLng;
  }
}
