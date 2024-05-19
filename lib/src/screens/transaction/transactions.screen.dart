import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_planner_front/src/models/transaction/transaction.model.dart';
import 'package:pocket_planner_front/src/screens/transaction/new_transaction.screen.dart';
import 'package:pocket_planner_front/src/services/transaction.service.dart';
import 'package:pocket_planner_front/src/widgets/message_card.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({super.key});

  @override
  State<TransactionsWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends State<TransactionsWidget> {
  String _selectedTransaction = '';

  @override
  setState(VoidCallback fn) {
    super.setState(fn);
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
              if (result != null) {
                await TransactionService.insertTransaction(result).then(
                  (_) => setState(() => ()),
                );
              }
            }),
            icon: const Icon(Icons.add),
            label: const Text('Add', style: TextStyle(fontSize: 20)),
          ),
          Visibility(
            visible: true,
            child: FloatingActionButton.extended(
              heroTag: 'fabRemove',
              onPressed: (() async {
                await TransactionService.deleteTransaction(_selectedTransaction).then(
                  (_) => setState(() => ()),
                );
              }),
              icon: const Icon(Icons.delete),
              label: const Text('Remove', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: TransactionService.getTransactions(),
        builder: (BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: TransactionList(snapshot: snapshot, callback: (val) => _selectedTransaction = val),
                ),
                const SizedBox(height: 85),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MessageCard(message: 'Loading...');
          }
          return const MessageCard(message: 'No Transactions Found!');
        },
      ),
    );
  }
}

typedef SelectedCallback = void Function(String val);

class TransactionList extends StatefulWidget {
  const TransactionList({
    super.key,
    required this.snapshot,
    required this.callback,
  });

  final void Function(String val) callback;
  final AsyncSnapshot<List<Transaction>> snapshot;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  String selectedTransaction = '';

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.callback(widget.snapshot.data!.elementAt(index).id.values.first);
              selectedTransaction = widget.snapshot.data!.elementAt(index).id.values.first;
            });
          },
          child: TransactionEntry(transaction: widget.snapshot.data!.elementAt(index), selectedTransaction: selectedTransaction),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Container(),
    );
  }
}

class TransactionEntry extends StatelessWidget {
  const TransactionEntry({super.key, required this.transaction, required this.selectedTransaction});

  final Transaction transaction;
  final String selectedTransaction;

  @override
  Widget build(BuildContext context) {
    DateTime inputDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(transaction.date, true);
    var formatedDate = DateFormat('MMMM dd, yyyy').format(inputDate);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            color: selectedTransaction == transaction.id.values.first ? Theme.of(context).focusColor : Theme.of(context).hoverColor,
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
    );
  }
}
