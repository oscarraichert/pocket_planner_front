import 'dart:convert';

import 'package:pocket_planner_front/src/extract/extract_entry.model.dart';

import 'package:http/http.dart' as http;

class HttpClientService {
  static Future<List<ExtractEntryModel>> getExtract() async {
    var response = await http.get(
        Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjZjZTExYWVjZjllYjE0MDI0YTQ0YmJmZDFiY2Y4YjMyYTEyMjg3ZmEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI4MjQ2NTM2MjgyOTYtZzRpajk3ODVoOWMxZ2tiaW1tNWFmNDJvNGw3bWtldDMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4MjQ2NTM2MjgyOTYtYWhyOWpyM2FxZ3IzNjdtdWw0cDM1OWRqNHBsc2w2N2EuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTY3OTk0NDk1MzI1NTIyMTAxODEiLCJlbWFpbCI6Im9zY2FyZG9zc2FudG9pc0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6Im9zY2FyIHNhbnRvcyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLbS1fbDFxdHpST3VEOXprQ20tNHNVQmk5V1lILTZOMmJ5M05CcFhmNzAwd19iU2pCWT1zOTYtYyIsImdpdmVuX25hbWUiOiJvc2NhciIsImZhbWlseV9uYW1lIjoic2FudG9zIiwiaWF0IjoxNzEzNjY2MzQ2LCJleHAiOjE3MTM2Njk5NDZ9.mohSk-vG6girnBiGqARVwJdPxzq3jeTb67MsFGrmvZxmNiec-lJJ7aGqoC0glCQh9ZtyXJKWPpUSPlWVKFDmbbjuC-sIXZEWxebOETJCQ3p2geCZvmymmM1HK6CrVQxVy37lVCbsJvrKWRfd4KHLg2LJDHRMk3K8fBlCs8DFB96kSerc8Nf1Mt8VBf32nwgo5jvrXVILoKXL6tor9vc0-ehGfCRNEVQ92jJlPaeByDy-fquoKSaWJNy_AY8hCtBtyO62mIkbrBIzjX3H9-iCMB3y_O6l21eBqQcc9sys7Urr-B84gRWxH8WnpBN65K3H_t0MwCnl-_4A2bLBKdc5cQ'
        });

    var entriesJson = jsonDecode(response.body) as List<dynamic>;

    var entries = entriesJson.map((e) => ExtractEntryModel.fromJson(e)).toList();

    return entries;
  }
}