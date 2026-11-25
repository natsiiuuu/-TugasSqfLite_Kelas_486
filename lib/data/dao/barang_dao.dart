import '../database/db_helper.dart';
import '../../model/barang.dart';

class BarangDao {
  final DbHelper _dbHelper;

  BarangDao(this._dbHelper);

  static const _nameTable = DbHelper.tableName;

  Future<int> insert(Barang barang) async {
    final db = await _dbHelper.database;
    return db.insert(_nameTable, barang.toMap());
  }

  Future<List<Barang>> getAllBarang() async {
    final db = await _dbHelper.database;
    final maps = await db.query(_nameTable, orderBy: 'id DESC');
    return maps.map((map) => Barang.fromMap(map)).toList();
  }

  Future<int> update(Barang barang) async {
    final db = await _dbHelper.database;
    return db.update(
      _nameTable,
      barang.toMap(),
      where: 'id = ?',
      whereArgs: [barang.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete(
      _nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}