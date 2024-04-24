import 'package:flutter/material.dart';

class NewExtractWidget extends StatefulWidget {
  const NewExtractWidget({super.key});

  @override
  State<NewExtractWidget> createState() => _NewExtractState();
}

class _NewExtractState extends State<NewExtractWidget> {
  final descriptionController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Extract Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor), borderRadius: const BorderRadius.all(Radius.circular(20))),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        maxLength: 35,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          isDense: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a description';
                          }
                          return null;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Value:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      TextFormField(
                        controller: valueController,
                        maxLength: 35,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          isDense: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a value';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () => {
                          print(descriptionController.text),
                          print(valueController.text)
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
