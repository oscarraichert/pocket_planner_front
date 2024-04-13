import 'package:flutter/material.dart';

class ExtractPage extends StatelessWidget {
  const ExtractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extract'),
        elevation: 20,
      ),
      body: const Center(
        child: Text('sexo'),
      ),
    );
  }
}
