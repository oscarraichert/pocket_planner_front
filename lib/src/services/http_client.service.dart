import 'dart:convert';

import 'package:pocket_planner_front/src/extract/extract_entry.model.dart';

import 'package:http/http.dart' as http;

class HttpClientService {
  static Future<List<ExtractEntryModel>> getExtract() async {
    var response = await http.get(
        Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjZjZTExYWVjZjllYjE0MDI0YTQ0YmJmZDFiY2Y4YjMyYTEyMjg3ZmEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI4MjQ2NTM2MjgyOTYtZzRpajk3ODVoOWMxZ2tiaW1tNWFmNDJvNGw3bWtldDMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4MjQ2NTM2MjgyOTYtYWhyOWpyM2FxZ3IzNjdtdWw0cDM1OWRqNHBsc2w2N2EuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTY3OTk0NDk1MzI1NTIyMTAxODEiLCJlbWFpbCI6Im9zY2FyZG9zc2FudG9pc0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6Im9zY2FyIHNhbnRvcyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLbS1fbDFxdHpST3VEOXprQ20tNHNVQmk5V1lILTZOMmJ5M05CcFhmNzAwd19iU2pCWT1zOTYtYyIsImdpdmVuX25hbWUiOiJvc2NhciIsImZhbWlseV9uYW1lIjoic2FudG9zIiwiaWF0IjoxNzEzODEyNjk4LCJleHAiOjE3MTM4MTYyOTh9.KmbOp5C3TMfzyi8CD5jHNPdgYAod7GM8SprdxTeO7fyY2LLdotUA0RB0m4rD2xO2KPcx8O9_z5qttLYxFPSQ9EC2Dy3nIq03JBKm2QEs3sgnPUQGbm3qHYKCKDuicbv1yvjcc00mFOfEAmnPH2sQKUGQwKb-_3pwUjjJ30XzRurj4fY32r5SIZXCiPmhF9JQW1SL5L45sc3yNPsCtoDU2NAw09UxsEjBGH1Yw-D0f6kO9bPEbvjLofOBALtESay5hFK1SlaQTt5fLj__ElZXh_agC6QpY-WMg7G7mEumCWnj5DeOOx0E1r7W6LW3jXEsL7AtDf7a3SOfU3sADSrqSg'
        });

    var entriesJson = jsonDecode(response.body) as List<dynamic>;

    var entries = entriesJson.map((e) => ExtractEntryModel.fromJson(e)).toList();

    return entries;
  }
}