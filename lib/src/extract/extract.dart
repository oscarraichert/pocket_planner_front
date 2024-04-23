import 'package:flutter/material.dart';
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
        builder: (BuildContext context, AsyncSnapshot<List<ExtractEntryModel>> snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExtractEntry(
                    service: snapshot.data!.elementAt(index).description,
                    date: snapshot.data!.elementAt(index).date,
                    value: snapshot.data!.elementAt(index).value,
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Container());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const MessageBox(message: 'Loading...');
          } else {
            return const MessageBox(message: 'No entries found');
          }
        },
      ),
    );
  }
}

class ExtractEntry extends StatelessWidget {
  const ExtractEntry({super.key, required this.service, required this.value, required this.date});

  final String value;
  final String service;
  final String date;

  @override
  Widget build(BuildContext context) {
    DateTime inputDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var formatedDate = DateFormat('MMMM dd, yyyy').format(inputDate);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            color: Theme.of(context).hoverColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatedDate,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            text: service,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$$value',
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
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

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                color: Theme.of(context).hoverColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}