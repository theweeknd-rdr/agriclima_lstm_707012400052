import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';
import '../models/hasil_prediksi.dart';
import '../state/prediksi_model.dart';
import '../widgets/kartu_statistik.dart';
import '../widgets/prediksi_card.dart';
import 'halaman_input_prediksi.dart';

// Isi tab Prediksi: riwayat prediksi, filter petak, dan kartu statistik.
class HalamanPrediksi extends StatelessWidget {
  const HalamanPrediksi({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PrediksiModel>();
    final daftar = model.daftarTampil;
    final pilihanFilter = ['Semua', ...HasilPrediksi.daftarPetak];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.inputPrediksi);
        },
        icon: const Icon(Icons.add),
        label: const Text('Prediksi baru'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Riwayat Prediksi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Filter petak
                Wrap(
                  spacing: 8,
                  children: pilihanFilter.map((petak) {
                    return ChoiceChip(
                      label: Text(petak),
                      selected: model.filterPetak == petak,
                      onSelected: (dipilih) {
                        model.setFilterPetak(petak);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),

                // Tiga kartu statistik
                Row(
                  children: [
                    Expanded(
                      child: KartuStatistik(
                        judul: 'Total',
                        nilai: model.total,
                        warna: Colors.grey.shade800,
                        ikon: Icons.list_alt,
                      ),
                    ),
                    Expanded(
                      child: KartuStatistik(
                        judul: 'Optimal',
                        nilai: model.jumlahOptimal,
                        warna: Colors.green.shade700,
                        ikon: Icons.check_circle,
                      ),
                    ),
                    Expanded(
                      child: KartuStatistik(
                        judul: 'Perlu Tindakan',
                        nilai: model.jumlahPerluTindakan,
                        warna: Colors.orange.shade800,
                        ikon: Icons.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Daftar hasil prediksi
          Expanded(
            child: daftar.isEmpty
                ? const Center(child: Text('Belum ada data'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                    itemCount: daftar.length,
                    itemBuilder: (context, index) {
                      final data = daftar[index];
                      return PrediksiCard(
                        data: data,
                        onUbah: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HalamanInputPrediksi(dataLama: data),
                            ),
                          );
                        },
                        onHapus: () {
                          model.hapusData(data);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Data dihapus')),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
