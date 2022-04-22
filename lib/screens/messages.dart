import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quicloc/models/message.dart';
import 'package:flutter/services.dart' as root_bundle;

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late Future<List<Message>> list;
  final Random _random = Random();
  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    list = readJsonFile();
  }

  // method to read from the json file
  Future<List<Message>> readJsonFile() async {
    // read json file
    final jsondata =
        await root_bundle.rootBundle.loadString('assets/messages.json');
    // decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;
    // map json and initialize using Messages model
    return list.map((item) {
      return Message.fromJson(item);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        // leading: const Icon(Icons.menu),
        title: const Text('Messages'),
      ),
      body: FutureBuilder(
        future: list,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          if (snapshot.hasData) {
            var items = snapshot.data as List<Message>;
            // create and return a ListView widget
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colors[_random.nextInt(colors.length)],
                    foregroundColor: Colors.black,
                    child: Text(
                      items[index].getSubject.toString()[0],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      items[index].getSubject.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text(
                    items[index].getMessageText.toString(),
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                  trailing: Column(
                    children: [
                      Text(items[index].getDisplay.toString()),
                      const SizedBox(height: 8.0),
                      const Icon(
                        Icons.star_outline_outlined,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}
