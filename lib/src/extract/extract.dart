import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExtractEntry(
                    service: snapshot.data!.elementAt(index).description,
                    date: snapshot.data!.elementAt(index).date,
                    value: snapshot.data!.elementAt(index).value,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Container());
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
    DateTime inputDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var formatedDate = DateFormat('MM/dd/yyyy').format(inputDate);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        color: Theme.of(context).focusColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Service',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: service,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(
                          formatedDate,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Value',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '\$$value',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
