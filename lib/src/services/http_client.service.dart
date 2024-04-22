import 'dart:convert';

import 'package:pocket_planner_front/src/extract/extract_entry.model.dart';

import 'package:http/http.dart' as http;
import 'package:pocket_planner_front/src/services/user.service.dart';

class HttpClientService {
  static Future<List<ExtractEntryModel>> getExtract() async {
    var response = await http.get(
        Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
        headers: {
          'Authorization':
              'Bearer ${await UserService.getAuthToken()}'
        });

    var entriesJson = jsonDecode(response.body) as List<dynamic>;

    var entries = entriesJson.map((e) => ExtractEntryModel.fromJson(e)).toList();

    return entries;
  }
}