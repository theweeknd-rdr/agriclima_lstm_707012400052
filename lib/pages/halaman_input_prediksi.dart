import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hasil_prediksi.dart';
import '../state/prediksi_model.dart';

// Form input hasil prediksi LTSM.
// Jika dataLama diisi, form dipakai untuk mengubah data.
class HalamanInputPrediksi extends StatefulWidget {
  final HasilPrediksi? dataLama;

  const HalamanInputPrediksi({super.key, this.dataLama});

  @override
  State<HalamanInputPrediksi> createState() => _HalamanInputPrediksiState();
}

class _HalamanInputPrediksiState extends State<HalamanInputPrediksi> {
  final _suhuController = TextEditingController();
  final _kelembapanUdaraController = TextEditingController();
  final _kelembapanTanahController = TextEditingController();
  final _petugasController = TextEditingController();

  String _petak = HasilPrediksi.daftarPetak[0];
  String _tanaman = HasilPrediksi.daftarTanaman[0];
  bool _dataBenar = false;

  // Pesan error (null = tidak ada error)
  String? _errorSuhu;
  String? _errorKelembapanUdara;
  String? _errorKelembapanTanah;
  String? _errorPetugas;

  @override
  void initState() {
    super.initState();
    final lama = widget.dataLama;
    if (lama != null) {
      _petak = lama.petak;
      _tanaman = lama.tanaman;
      _suhuController.text = HasilPrediksi.formatAngka(lama.suhuUdara);
      _kelembapanUdaraController.text =
          HasilPrediksi.formatAngka(lama.kelembapanUdara);
      _kelembapanTanahController.text =
          HasilPrediksi.formatAngka(lama.kelembapanTanah);
      _petugasController.text = lama.namaPetugas;
    }
  }

  @override
  void dispose() {
    _suhuController.dispose();
    _kelembapanUdaraController.dispose();
    _kelembapanTanahController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  // Ubah teks menjadi angka, null jika bukan angka
  double? _keAngka(String teks) {
    final angka = double.tryParse(teks.trim().replaceAll(',', '.'));
    if (angka == null || !angka.isFinite) {
      return null;
    }
    return angka;
  }

  // Cek semua isian, tampilkan pesan error jika ada yang salah
  bool _validasi() {
    final suhu = _keAngka(_suhuController.text);
    final udara = _keAngka(_kelembapanUdaraController.text);
    final tanah = _keAngka(_kelembapanTanahController.text);
    final petugas = _petugasController.text.trim();

    setState(() {
      _errorSuhu = suhu == null ? 'Suhu harus berupa angka' : null;
      _errorKelembapanUdara = (udara == null || udara < 0 || udara > 100)
          ? 'Kelembapan harus berupa angka 0-100'
          : null;
      _errorKelembapanTanah = (tanah == null || tanah < 0 || tanah > 100)
          ? 'Kelembapan harus berupa angka 0-100'
          : null;
      _errorPetugas = petugas.isEmpty ? 'Nama petugas tidak boleh kosong' : null;
    });

    return _errorSuhu == null &&
        _errorKelembapanUdara == null &&
        _errorKelembapanTanah == null &&
        _errorPetugas == null;
  }

  Future<void> _simpan() async {
    if (!_validasi()) {
      return;
    }

    final dataBaru = HasilPrediksi(
      petak: _petak,
      tanaman: _tanaman,
      suhuUdara: _keAngka(_suhuController.text)!,
      kelembapanUdara: _keAngka(_kelembapanUdaraController.text)!,
      kelembapanTanah: _keAngka(_kelembapanTanahController.text)!,
      namaPetugas: _petugasController.text.trim(),
      waktu: widget.dataLama?.waktu ?? DateTime.now(),
    );

    final model = context.read<PrediksiModel>();

    // AlertDialog konfirmasi sebelum data disimpan
    final yakin = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Simpan data prediksi berikut?'),
            const SizedBox(height: 8),
            Text('${dataBaru.petak} - ${dataBaru.tanaman}'),
            Text('Status: ${dataBaru.status}'),
            Text('Rekomendasi: ${dataBaru.rekomendasi}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (yakin != true) {
      return;
    }

    if (widget.dataLama == null) {
      model.tambahData(dataBaru);
    } else {
      model.ubahData(widget.dataLama!, dataBaru);
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data Tersimpan')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dataLama == null ? 'Input Prediksi' : 'Ubah Prediksi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Petak
            const Text(
              'Petak',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            for (final petak in HasilPrediksi.daftarPetak)
              RadioListTile<String>(
                title: Text(petak),
                value: petak,
                groupValue: _petak,
                contentPadding: EdgeInsets.zero,
                onChanged: (nilai) {
                  setState(() {
                    _petak = nilai!;
                  });
                },
              ),
            const SizedBox(height: 8),

            // Nama tanaman
            DropdownButtonFormField<String>(
              value: _tanaman,
              decoration: const InputDecoration(
                labelText: 'Nama Tanaman',
                border: OutlineInputBorder(),
              ),
              items: HasilPrediksi.daftarTanaman.map((tanaman) {
                return DropdownMenuItem<String>(
                  value: tanaman,
                  child: Text(tanaman),
                );
              }).toList(),
              onChanged: (nilai) {
                setState(() {
                  _tanaman = nilai!;
                });
              },
            ),
            const SizedBox(height: 12),

            // Prediksi suhu udara
            TextField(
              controller: _suhuController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Prediksi Suhu Udara (°C)',
                border: const OutlineInputBorder(),
                errorText: _errorSuhu,
              ),
            ),
            const SizedBox(height: 12),

            // Prediksi kelembapan udara
            TextField(
              controller: _kelembapanUdaraController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Prediksi Kelembapan Udara (%)',
                border: const OutlineInputBorder(),
                errorText: _errorKelembapanUdara,
              ),
            ),
            const SizedBox(height: 12),

            // Prediksi kelembapan tanah
            TextField(
              controller: _kelembapanTanahController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Prediksi Kelembapan Tanah (%)',
                border: const OutlineInputBorder(),
                errorText: _errorKelembapanTanah,
              ),
            ),
            const SizedBox(height: 12),

            // Nama petugas
            TextField(
              controller: _petugasController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Nama Petugas',
                border: const OutlineInputBorder(),
                errorText: _errorPetugas,
              ),
            ),
            const SizedBox(height: 8),

            // Checkbox konfirmasi
            CheckboxListTile(
              title: const Text('Data sudah benar'),
              value: _dataBenar,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              onChanged: (nilai) {
                setState(() {
                  _dataBenar = nilai ?? false;
                });
              },
            ),
            const SizedBox(height: 8),

            // Tombol Simpan: aktif hanya jika checkbox dicentang
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _dataBenar ? _simpan : null,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
