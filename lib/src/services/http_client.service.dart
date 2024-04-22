import 'dart:convert';

import 'package:pocket_planner_front/src/extract/extract_entry.model.dart';

import 'package:http/http.dart' as http;

class HttpClientService {
  static Future<List<ExtractEntryModel>> getExtract() async {
    var response = await http.get(
        Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjZjZTExYWVjZjllYjE0MDI0YTQ0YmJmZDFiY2Y4YjMyYTEyMjg3ZmEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI4MjQ2NTM2MjgyOTYtZzRpajk3ODVoOWMxZ2tiaW1tNWFmNDJvNGw3bWtldDMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4MjQ2NTM2MjgyOTYtYWhyOWpyM2FxZ3IzNjdtdWw0cDM1OWRqNHBsc2w2N2EuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTY3OTk0NDk1MzI1NTIyMTAxODEiLCJlbWFpbCI6Im9zY2FyZG9zc2FudG9pc0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6Im9zY2FyIHNhbnRvcyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLbS1fbDFxdHpST3VEOXprQ20tNHNVQmk5V1lILTZOMmJ5M05CcFhmNzAwd19iU2pCWT1zOTYtYyIsImdpdmVuX25hbWUiOiJvc2NhciIsImZhbWlseV9uYW1lIjoic2FudG9zIiwiaWF0IjoxNzEzODA4NzE1LCJleHAiOjE3MTM4MTIzMTV9.FENcGJOAOafv-taPNB2qjW9Je_XQ9qprfVy3-wzwbyBker4gnc_e2_BaKgYI2QRtRongam8k6_iUO9yFllhLJGlqEqg4tOMp9cyWM16O1tJIrCCTGHrixE56GigziBA6Tp5n_HuTEp7SygFhM9WZ7YESX9m1EBoB1fxoS6VVnsiYqBJS2_CUl5Rz9jTeTvXKZQq8DpAOk5JJE_FpUFu6nNVh1IlwBRqE8PXZXFQkiGuDHYyybk82pW5WEoFA2Uuz9wN4C8zpVXiAWVpbw0A_S9z_7ckcCszAd21ceF0k41XOIVL2mARIkvTo2VM21JjnpZJjYJ3DrRhEe18gLFC2hA'
        });

    var entriesJson = jsonDecode(response.body) as List<dynamic>;

    var entries = entriesJson.map((e) => ExtractEntryModel.fromJson(e)).toList();

    return entries;
  }
}