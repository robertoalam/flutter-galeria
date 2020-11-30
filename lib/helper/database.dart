import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

    static final _databaseName = "galeria.db";
    static final _databaseVersion = 1;

    // make this a singleton class
    DatabaseHelper._privateConstructor();
    static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

    // only have a single app-wide reference to the database
    static Database _database;
    Future<Database> get database async {
        if (_database != null) return _database;
        // lazily instantiate the db the first time it is accessed
        _database = await _initDatabase();
        return _database;
    }

    // this opens the database (and creates it if it doesn't exist)
    _initDatabase() async {
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, _databaseName);
        return await openDatabase(path,
            version: _databaseVersion,
            onCreate: _onCreate);
    }

    // SQL code to create the database table
    Future _onCreate(Database db, int version) async {
        await db.execute(''' CREATE TABLE IF NOT EXISTS configuracao ( chave TEXT NOT NULL, valor TEXT NOT NULL ); ''');
        await db.execute(''' CREATE TABLE IF NOT EXISTS arquivos ( _id INTEGER PRIMARY KEY AUTOINCREMENT, acao VARCHAR(10) ,origem TEXT NOT NULL, destino TEXT ); ''');
        // await db.execute(''' CREATE TABLE IF NOT EXISTS arquivo_mover ( _id INTEGER PRIMARY KEY AUTOINCREMENT, origem TEXT NOT NULL, destino TEXT NOT NULL ); ''');
        // await db.execute(''' CREATE TABLE IF NOT EXISTS arquivo_deletar ( _id INTEGER PRIMARY KEY AUTOINCREMENT, origem TEXT NOT NULL ); ''');
        await db.execute(''' CREATE TABLE IF NOT EXISTS logs ( _id INTEGER PRIMARY KEY AUTOINCREMENT, acao VARCHAR(10) , log TEXT NULL , dt_log Datetime ); ''');
        popularConfiguracao(db);
    }

    popularConfiguracao(db){
        db.execute(''' INSERT INTO configuracao (chave,valor) VALUES ('dt_instalacao',datetime('now','localtime')); ''');
        db.execute(''' INSERT INTO configuracao (chave,valor) VALUES ('no_aberturas',0); ''');
        db.execute(''' INSERT INTO configuracao (chave,valor) VALUES ('ds_view','grid'); ''');
        db.execute(''' INSERT INTO configuracao (chave,valor) VALUES ('no_view',3); ''');
        return 1;
    }

    // Helper methods
    // Inserts a row in the database where each key in the Map is a column name
    // and the value is the column value. The return value is the id of the
    // inserted row.
    Future<int> insert(tabela,Map<String, dynamic> row) async {
        Database db = await instance.database;
        return await db.insert(tabela, row);
    }

    executar(String comando) async {
        Database db = await instance.database;
        return await db.execute(comando);
    }

    Where(tabela , where) async {
        Database db = await instance.database;
        return await db.query(tabela , where: where);
    }

    // All of the rows are returned as a list of maps, where each map is
    // a key-value list of columns.
    Future<List<Map<String, dynamic>>> queryAllRows(tabela) async {
        Database db = await instance.database;
        return await db.query(tabela);
    }

    // All of the methods (insert, query, update, delete) can also be done using
    // raw SQL commands. This method uses a raw query to give the row count.
    Future<int> queryRowCount(tabela) async {
        Database db = await instance.database;
        return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tabela'));
    }

    Future<List<Map<String, dynamic>>> queryCustom(sql) async {
        Database db = await instance.database;
        List<Map> list = await db.rawQuery(sql);
        return list;
    }

    // We are assuming here that the id column in the map is set. The other
    // column values will be used to update the row.
    Future<int> update(tabela , primaryKey , Map<String, dynamic> row) async {
        Database db = await instance.database;
        String primaryValue = row['_id'].toString() ;
        return await db.update(tabela, row, where:" $primaryKey = $primaryValue ");
    }

    // Deletes the row specified by the id. The number of affected rows is
    // returned. This should be 1 as long as the row exists.
    Future<int> delete(tabela,int id) async {
        Database db = await instance.database;
        // return await db.delete(tabela, where: '$columnId = ?', whereArgs: [id]);
        return await db.delete(tabela, where: '_id = ?', whereArgs: ['_id']);
    }
}