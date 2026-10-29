import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  final VoidCallback? onBukaTabPrediksi;

  const HalamanBeranda({super.key, this.onBukaTabPrediksi});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Selamat Datang di AgriClima LTSM',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Aplikasi untuk mencatat hasil prediksi mikroklimat tanaman di lahan Kelompok Tani Sri Mulya, agar kebutuhan penyiraman tiap petak mudah dipantau.',
          style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.memory, size: 32, color: colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Model: LTSM (Deep Learning)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Prediksi 24 jam ke depan',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '3 parameter: suhu udara, kelembapan udara, kelembapan tanah',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/tentang'),
          icon: const Icon(Icons.info_outline),
          label: const Text('Tentang Aplikasi'),
        ),
      ],
    );
  }
}
