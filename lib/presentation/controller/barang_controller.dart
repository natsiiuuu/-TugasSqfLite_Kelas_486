import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repo/barang_repo.dart';
import '../../model/barang.dart';

class BarangController extends GetxController {
  final BarangRepo repo;

  BarangController(this.repo);

  var barangList = <Barang>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBarang();
  }

  // READ
  Future<void> getBarang() async {
    try {
      barangList.value = await repo.getAllBarang();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data: $e',
          backgroundColor: Colors.red);
    }
  }

  // CREATE
  Future<void> tambahBarang(Barang barang) async {
    try {
      await repo.insert(barang);
      await getBarang();
      Get.snackbar(
        'Sukses',
        'Barang dengan nama ${barang.nama} berhasil ditambahkan',
      );
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambah: $e', backgroundColor: Colors.red);
    }
  }

  // UPDATE
  Future<void> ubahBarang(Barang barang) async {
    try {
      await repo.update(barang);
      await getBarang();
      Get.snackbar(
        'Sukses',
        'Barang ${barang.nama} berhasil diubah',
      );
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengubah: $e', backgroundColor: Colors.red);
    }
  }

  // DELETE
  Future<void> hapusBarang(Barang barang) async {
    try {
      await repo.delete(barang.id!);
      await getBarang();
      Get.snackbar(
        'Sukses',
        'Barang ${barang.nama} berhasil dihapus',
      );
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus: $e', backgroundColor: Colors.red);
    }
  }
}