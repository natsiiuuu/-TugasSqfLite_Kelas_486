import '../dao/barang_dao.dart';
import '../../model/barang.dart';

abstract class BarangRepo {
  Future<int> insert(Barang barang);
  Future<List<Barang>> getAllBarang();
  Future<int> update(Barang barang);
  Future<int> delete(int id);
}

class BarangRepoImpl implements BarangRepo {
  final BarangDao dao;

  BarangRepoImpl(this.dao);

  @override
  Future<List<Barang>> getAllBarang() => dao.getAllBarang();

  @override
  Future<int> insert(Barang barang) => dao.insert(barang);

  @override
  Future<int> update(Barang barang) => dao.update(barang);

  @override
  Future<int> delete(int id) => dao.delete(id);
}