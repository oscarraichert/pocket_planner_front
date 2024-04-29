import 'package:flutter/material.dart';
import 'package:pocket_planner_front/src/models/transaction/new_transaction.model.dart';
import 'package:pocket_planner_front/src/services/transaction.service.dart';

class NewTransactionWidget extends StatefulWidget {
  const NewTransactionWidget({super.key});

  @override
  State<NewTransactionWidget> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransactionWidget> {
  final descriptionController = TextEditingController();
  final valueController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      transactionFormField(35, 'Description', descriptionController),
                      transactionFormField(12, 'Value', valueController, inputType: TextInputType.number),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              var newEntry = NewTransaction(descriptionController.text, valueController.text);
                              await TransactionService.insertTransaction(newEntry);
                              Navigator.pop(context, true);
                            }
                          },
                        ),
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

  Column transactionFormField(int maxLength, String formLabel, TextEditingController fieldController, {TextInputType? inputType}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(formLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextFormField(
          keyboardType: inputType,
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
