import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_planner_front/src/models/transaction/transaction.model.dart';
import 'package:pocket_planner_front/src/screens/transaction/new_transaction.screen.dart';
import 'package:pocket_planner_front/src/providers/transactions.provider.dart';
import 'package:pocket_planner_front/src/services/transaction.service.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({super.key});

  @override
  State<TransactionsWidget> createState() => _TransactionsWidgetState();
}

bool entrySelected = false;

class _TransactionsWidgetState extends State<TransactionsWidget> {
  late Future<List<Transaction>> transactions;
  var transactionsProvider = TransactionsProvider();

  @override
  void initState() {
    super.initState();
    transactions = TransactionService.getTransactions();
    entrySelected = false;
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    transactions = TransactionService.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
            heroTag: 'fabAdd',
            onPressed: (() async {
              var result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewTransactionWidget()),
              );
              if (result == true) {
                setState(() => {});
              }
            }),
            icon: const Icon(Icons.add),
            label: const Text('Add', style: TextStyle(fontSize: 20)),
          ),
          Visibility(
            visible: entrySelected,
            child: FloatingActionButton.extended(
              heroTag: 'fabRemove',
              onPressed: (() async {
                log('delete');
              }),
              icon: const Icon(Icons.delete),
              label: const Text('Remove', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
      body: TransactionsBody(transactionsModel: transactionsProvider),
    );
  }
}

class TransactionsBody extends StatelessWidget {
  const TransactionsBody({super.key, required this.transactionsModel});

  final TransactionsProvider transactionsModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: transactionsModel.all,
      builder: (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done && snapshot.data!.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TransactionEntry(transaction: snapshot.data!.elementAt(index));
                  },
                  separatorBuilder: (BuildContext context, int index) => Container(),
                ),
              ),
              const SizedBox(height: 85),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const MessageCard(message: 'Loading...');
        } else {
          return const MessageCard(message: 'No transactions found');
        }
      },
    );
  }
}

class TransactionEntry extends StatelessWidget {
  const TransactionEntry({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    DateTime inputDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(transaction.date, true);
    var formatedDate = DateFormat('MMMM dd, yyyy').format(inputDate);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: GestureDetector(
        onTap: () async {
          entrySelected = true;
          log('${transaction.id}');
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              color: Theme.of(context).hoverColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatedDate,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            overflow: TextOverflow.ellipsis,
                            TextSpan(text: transaction.description),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${transaction.value}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                color: Theme.of(context).hoverColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(message),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
