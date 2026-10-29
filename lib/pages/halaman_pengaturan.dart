import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../state/tema_model.dart';


class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = context.watch<TemaModel>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Mode Gelap'),
          subtitle: const Text('Ubah tampilan aplikasi ke mode gelap'),
          value: tema.modeGelap,
          onChanged: (nilai) {
            tema.gantiMode(nilai);
          },
        ),
      ],
    );
  }
}
