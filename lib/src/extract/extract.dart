import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExtractPage extends StatelessWidget {
  const ExtractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extract'),
        elevation: 20,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Theme.of(context).focusColor,
                child: const Text('sexo maluco'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Theme.of(context).focusColor,
                child: const Text('sexo2'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
