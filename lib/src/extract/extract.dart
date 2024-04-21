import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocket_planner_front/src/extract/extract_entry.model.dart';
import 'package:pocket_planner_front/src/services/http_client.service.dart';

class ExtractWidget extends StatefulWidget {
  const ExtractWidget({super.key});

  @override
  State<ExtractWidget> createState() => _ExtractWidgetState();
}

class _ExtractWidgetState extends State<ExtractWidget> {
  late Future<List<ExtractEntryModel>> entries;

  @override
  void initState() {
    super.initState();
    entries = HttpClientService.getExtract();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extract'),
        elevation: 20,
      ),
      body: FutureBuilder<List<ExtractEntryModel>>(
        future: entries,
        builder: (BuildContext context,
            AsyncSnapshot<List<ExtractEntryModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExtractEntry(
                    service: snapshot.data!.elementAt(index).description,
                    date: snapshot.data!.elementAt(index).date,
                    value: snapshot.data!.elementAt(index).value,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 8));
          } else {
            return Container(
              margin: const EdgeInsets.all(8),
              height: 55,
              color: Theme.of(context).focusColor,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'No extract entries.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ExtractEntry extends StatelessWidget {
  const ExtractEntry(
      {super.key,
      required this.service,
      required this.value,
      required this.date});

  final String value;
  final String service;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      color: Theme.of(context).focusColor,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Service', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: service,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Text(date),
                Text('\$$value', textAlign: TextAlign.end),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
