import 'dart:convert';

import 'package:pocket_planner_front/src/extract/extract_entry.model.dart';

import 'package:http/http.dart' as http;

class HttpClientService {
  static Future<List<ExtractEntryModel>> getExtract() async {
    var response = await http.get(
        Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjZjZTExYWVjZjllYjE0MDI0YTQ0YmJmZDFiY2Y4YjMyYTEyMjg3ZmEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI4MjQ2NTM2MjgyOTYtZzRpajk3ODVoOWMxZ2tiaW1tNWFmNDJvNGw3bWtldDMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4MjQ2NTM2MjgyOTYtYWhyOWpyM2FxZ3IzNjdtdWw0cDM1OWRqNHBsc2w2N2EuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTY3OTk0NDk1MzI1NTIyMTAxODEiLCJlbWFpbCI6Im9zY2FyZG9zc2FudG9pc0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6Im9zY2FyIHNhbnRvcyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLbS1fbDFxdHpST3VEOXprQ20tNHNVQmk5V1lILTZOMmJ5M05CcFhmNzAwd19iU2pCWT1zOTYtYyIsImdpdmVuX25hbWUiOiJvc2NhciIsImZhbWlseV9uYW1lIjoic2FudG9zIiwiaWF0IjoxNzEzNjQxNjcxLCJleHAiOjE3MTM2NDUyNzF9.lCYq52tjs3bNMS3id36KTj_FuCi6xiT0H3NiTgEWjdu-2WIQQBHMkVwuL5xFnXxwJh8ubNm-MgnqYGOFiSDVP0dF06pwEetGOqGt3C0b91K6rTDgCeqCpGJOtz5dcIAAh-yuyCqrVF1vjaTkyl9Yb0X1HGHKxiohZn0oTu94PRHBhjO0iv3uoUqHD6SI8kgd6cnOK2YYgbDlPt1aE_o4gfbixiKYRBdT2XnjKJpuyMhJQheRvB_C1fDqY39yPfMibocWTrx7yf1nYES5tN7VV6gv4mCwkAdm40enNaCT0HGiaWeMBNx7tXo1TQPPfrga9OdK5tXoAdDItM7Sm09L1Q'
        });

    var entriesJson = jsonDecode(response.body) as List<dynamic>;

    var entries = entriesJson.map((e) => ExtractEntryModel.fromJson(e)).toList();

    return entries;
  }
}