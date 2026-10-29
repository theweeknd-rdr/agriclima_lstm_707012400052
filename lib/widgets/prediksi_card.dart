import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';

// Kartu satu hasil prediksi pada daftar riwayat.
class PrediksiCard extends StatelessWidget {
  final HasilPrediksi data;
  final VoidCallback onUbah;
  final VoidCallback onHapus;

  const PrediksiCard({
    super.key,
    required this.data,
    required this.onUbah,
    required this.onHapus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Petak, nama tanaman, dan status mikroklimat
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${data.petak} - ${data.tanaman}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: data.warna,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(data.ikon, size: 16, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        data.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Prediksi kelembapan tanah + progress
            Text(
              'Prediksi kelembapan tanah: '
              '${HasilPrediksi.formatAngka(data.kelembapanTanah)}%',
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: data.kelembapanTanah / 100,
              color: data.warna,
              backgroundColor: Colors.grey.shade300,
              minHeight: 8,
            ),
            const SizedBox(height: 12),

            // Suhu udara dan kelembapan udara
            Text('Prediksi suhu udara: ${HasilPrediksi.formatAngka(data.suhuUdara)} °C'),
            Text(
              'Prediksi kelembapan udara: '
              '${HasilPrediksi.formatAngka(data.kelembapanUdara)}%',
            ),
            const SizedBox(height: 8),

            // Rekomendasi dan catatan perawatan
            Text(
              'Rekomendasi: ${data.rekomendasi}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: data.warna,
              ),
            ),
            const SizedBox(height: 4),
            Text('Catatan perawatan: ${data.catatanPerawatan}'),
            const SizedBox(height: 8),

            // Petugas, waktu, dan tombol aksi
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Petugas: ${data.namaPetugas}\nWaktu prediksi: ${data.waktuTeks}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                IconButton(
                  onPressed: onUbah,
                  icon: const Icon(Icons.edit),
                  tooltip: 'Ubah',
                ),
                IconButton(
                  onPressed: onHapus,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Hapus',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
