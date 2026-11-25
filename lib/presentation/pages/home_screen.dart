import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/barang.dart';
import '../controller/barang_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Dialog form dipakai untuk TAMBAH (barang == null) dan UBAH (barang != null)
  void _showForm(BarangController ctr, {Barang? barang}) {
    final formKey = GlobalKey<FormState>();
    final namaCtr = TextEditingController(text: barang?.nama ?? '');
    final stokCtr = TextEditingController(text: barang?.stok.toString() ?? '');
    final isEdit = barang != null;

    Get.dialog(
      AlertDialog(
        title: Text(isEdit ? 'Ubah Barang' : 'Tambah Barang'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaCtr,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: stokCtr,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Stok wajib diisi';
                  if (int.tryParse(v.trim()) == null) return 'Stok harus angka';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              final data = Barang(
                id: barang?.id,
                nama: namaCtr.text.trim(),
                stok: int.parse(stokCtr.text.trim()),
              );

              Get.back(); // tutup dialog

              if (isEdit) {
                ctr.ubahBarang(data);
              } else {
                ctr.tambahBarang(data);
              }
            },
            child: Text(isEdit ? 'Simpan' : 'Tambah'),
          ),
        ],
      ),
    );
  }

  void _konfirmasiHapus(BarangController ctr, Barang barang) {
    Get.dialog(
      AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Yakin ingin menghapus "${barang.nama}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Get.back();
              ctr.hapusBarang(barang);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctr = Get.find<BarangController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('LIST BARANG'),
          ),
          Expanded(
            child: Obx(() {
              if (ctr.barangList.isEmpty) {
                return const Center(
                  child: Text('Data Belum Ada'),
                );
              }

              return ListView.builder(
                itemCount: ctr.barangList.length,
                itemBuilder: (context, index) {
                  final barang = ctr.barangList[index];

                  return Card(
                    child: ListTile(
                      title: Text(barang.nama),
                      subtitle: Text('Stok Barang ${barang.stok}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showForm(ctr, barang: barang),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _konfirmasiHapus(ctr, barang),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(ctr),
        child: const Icon(Icons.add),
      ),
    );
  }
}