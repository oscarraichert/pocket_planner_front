import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ExtractPage extends StatelessWidget {
  const ExtractPage({super.key});

  getExtract() async {
    var response = await http.get(
        Uri.parse('https://pocket-planner-api.fly.dev/api/user/transaction'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjZjZTExYWVjZjllYjE0MDI0YTQ0YmJmZDFiY2Y4YjMyYTEyMjg3ZmEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI4MjQ2NTM2MjgyOTYtZzRpajk3ODVoOWMxZ2tiaW1tNWFmNDJvNGw3bWtldDMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4MjQ2NTM2MjgyOTYtYWhyOWpyM2FxZ3IzNjdtdWw0cDM1OWRqNHBsc2w2N2EuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTY3OTk0NDk1MzI1NTIyMTAxODEiLCJlbWFpbCI6Im9zY2FyZG9zc2FudG9pc0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6Im9zY2FyIHNhbnRvcyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLbS1fbDFxdHpST3VEOXprQ20tNHNVQmk5V1lILTZOMmJ5M05CcFhmNzAwd19iU2pCWT1zOTYtYyIsImdpdmVuX25hbWUiOiJvc2NhciIsImZhbWlseV9uYW1lIjoic2FudG9zIiwiaWF0IjoxNzEzNDA0NTU5LCJleHAiOjE3MTM0MDgxNTl9.NNoOAdKxhqSkACaRlmlAouYZ-W2gUVQV8xOGOFTnRBo_ma73oyOwrR_zRbV1docn_DHl0X6TJJXf0py2qTX-DUsNG2nAoiJzSYy_4OpX61SnTM6gF36m8IPDfm9jk2-If0OXqbD4iY53v--ottoNMVvKWNl_5_U2HpVWImIAMR6SQP8r8pmLvCIu9N4XNDWsoMS6KSl1BQKfTRxJlzEZIiJR64oPwb7H6e0fUsFPA8aM9IIzzQHiT6BaOk-bQOKMlqpQmG3QfF-ExeFjh7JJ7d1QK11xt0zhnky-nURBHPo01Px3BpZRQf0MLZTB-ykhiDhb6G8qLsfjx9okJQAbwA'
        });

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {

    getExtract();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Extract'),
        elevation: 20,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: const [
            ExtractEntry(service: 'puteiro', value: 150),
          ],
        ),
      ),
    );
  }
}

class ExtractEntry extends StatelessWidget {
  const ExtractEntry({super.key, required this.service, required this.value});

  final int value;
  final String service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 72,
        color: Theme.of(context).focusColor,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service'),
                  Text('Value'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(service),
                  Text(
                    '\$$value',
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
