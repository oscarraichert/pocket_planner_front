import 'package:flutter/material.dart';

class NewExtractWidget extends StatelessWidget {
  const NewExtractWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Extract Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              color: Theme.of(context).hoverColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          alignment: Alignment.center,
          child: const Column(
            children: [
              Text('Form', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
