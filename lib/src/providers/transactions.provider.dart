import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pocket_planner_front/src/models/transaction/transaction.model.dart';
import 'package:pocket_planner_front/src/models/transaction/new_transaction.model.dart';
import 'package:pocket_planner_front/src/services/transaction.service.dart';

class TransactionsProvider with ChangeNotifier {
  var transactions = TransactionService.getTransactions();

  Future<List<Transaction>> get all async {
    return await transactions;
  }

  Future<int> get count async {
    return await transactions.then((x) => x.length);
  }

  void add(NewTransaction newEntry) {
    log('insert');
    TransactionService.insertTransaction(newEntry);
    notifyListeners();
  }
}