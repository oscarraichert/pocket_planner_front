import 'package:flutter/material.dart';

class NewExtractWidget extends StatefulWidget {
  const NewExtractWidget({super.key});

  @override
  State<NewExtractWidget> createState() => _NewExtractState();
}

class _NewExtractState extends State<NewExtractWidget> {
  final descriptionController = TextEditingController();
  final valueController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      extractEntryFormField(35, 'Description', descriptionController),
                      extractEntryFormField(12, 'Value', valueController),
                      ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () => {
                          if (formKey.currentState!.validate())
                            {
                              print(descriptionController.text),
                              print(valueController.text),
                            }
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

  Column extractEntryFormField(int maxLength, String formLabel, TextEditingController fieldController) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(formLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          controller: fieldController,
          maxLength: maxLength,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            isDense: true,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
