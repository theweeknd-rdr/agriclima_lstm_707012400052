import 'package:flutter/material.dart';

// Kartu kecil untuk menampilkan satu angka statistik.
class KartuStatistik extends StatelessWidget {
  final String judul;
  final int nilai;
  final Color warna;
  final IconData ikon;

  const KartuStatistik({
    super.key,
    required this.judul,
    required this.nilai,
    required this.warna,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon, color: warna),
            const SizedBox(height: 4),
            Text(
              '$nilai',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: warna,
              ),
            ),
            Text(
              judul,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
