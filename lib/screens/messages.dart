import 'package:flutter/material.dart';
import 'package:quicloc/constants/theme.dart';
import 'package:quicloc/models/message.dart';
import 'package:quicloc/services/file_io.dart';
import 'package:quicloc/widgets/message_tile.dart';

class Messages extends StatefulWidget {
  static const String messagesScreenPath = '/messagesScreen';

  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late Future<List<Message>> list;

  @override
  void initState() {
    super.initState();
    list = FileIO.readJsonFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text(
          'Messages',
          style: kTextStyle,
        ),
      ),
      body: FutureBuilder(
        future: list,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              '${snapshot.error}',
              style: kTextStyle,
            ));
          }
          if (snapshot.hasData) {
            var items = snapshot.data as List<Message>;
            // create and return a ListView widget
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MessageTile(items: items, index: index);
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
