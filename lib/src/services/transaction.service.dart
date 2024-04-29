import 'dart:convert';
import 'dart:developer';
import 'package:pocket_planner_front/src/models/transaction/transaction.model.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_planner_front/src/models/transaction/new_transaction.model.dart';
import 'package:pocket_planner_front/src/services/auth.service.dart';

class TransactionService {
  static Future<List<Transaction>> getTransactions() async {
    var response = await http.get(
      Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
      headers: {
        'Authorization': 'Bearer ${await AuthService.getAuthToken()}',
      },
    );

    var entriesJson = jsonDecode(response.body) as List<dynamic>;
    var entries = entriesJson.map((e) => Transaction.fromJson(e)).toList();

    log('get transactions');

    return entries;
  }

  static Future<String> insertTransaction(NewTransaction newTransaction) async {
    var result = await http.post(
      Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
      headers: {
        'Authorization': 'Bearer ${await AuthService.getAuthToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(NewTransaction.toJson(newTransaction)),
    );    

    return result.body;
  }
}
