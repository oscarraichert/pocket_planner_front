import 'dart:convert';

import 'package:pocket_planner_front/src/extract/extract_entry.model.dart';

import 'package:http/http.dart' as http;

class HttpClientService {
  static Future<List<ExtractEntryModel>> getExtract() async {
    var response = await http.get(
        Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjZjZTExYWVjZjllYjE0MDI0YTQ0YmJmZDFiY2Y4YjMyYTEyMjg3ZmEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI4MjQ2NTM2MjgyOTYtZzRpajk3ODVoOWMxZ2tiaW1tNWFmNDJvNGw3bWtldDMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4MjQ2NTM2MjgyOTYtYWhyOWpyM2FxZ3IzNjdtdWw0cDM1OWRqNHBsc2w2N2EuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTY3OTk0NDk1MzI1NTIyMTAxODEiLCJlbWFpbCI6Im9zY2FyZG9zc2FudG9pc0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6Im9zY2FyIHNhbnRvcyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLbS1fbDFxdHpST3VEOXprQ20tNHNVQmk5V1lILTZOMmJ5M05CcFhmNzAwd19iU2pCWT1zOTYtYyIsImdpdmVuX25hbWUiOiJvc2NhciIsImZhbWlseV9uYW1lIjoic2FudG9zIiwiaWF0IjoxNzEzNjYxMzE4LCJleHAiOjE3MTM2NjQ5MTh9.Xcezd86Rg7Tz6Vlr2baPHMNuxWiT4vrC9x31e8WIHSWb_oFMVhBfb7ApYaqAGWDImtQZErhEjs_4ZlXYrrr0ytn3evZG-0nQAi9vW2sdOFwum580a0OhqLG0ffhAHzTmCVppo1NA42HTP6kOqvEZVGYB3mkvlK11FugvL_30tjR8aYyJJHuZHBzvN-obTgaiCVWISa_7NENBJYhbs9sCdA0OSn0nY6Lf1ON8hja4TbYvHI6rc0b7o9_jvC22jaU03drYKLE5IzRXW2z4ZnzoB1C0WnPUp0wPC1WFXMByMNS5SYWB6tKDzCWUzEAFc4VqpKKwjGi4pZSIdKCHPAs-OQ'
        });

    var entriesJson = jsonDecode(response.body) as List<dynamic>;

    var entries = entriesJson.map((e) => ExtractEntryModel.fromJson(e)).toList();

    return entries;
  }
}