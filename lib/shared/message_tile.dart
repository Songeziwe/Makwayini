import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quicloc/models/message.dart';
import 'package:quicloc/shared/custom_icon.dart';

class MessageTile extends StatelessWidget {
  final List<Message>? items;
  final Random _random = Random();
  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.orange,
  ];
  final int? index;

  MessageTile({this.items, this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colors[_random.nextInt(colors.length)],
        foregroundColor: Colors.black,
        child: Text(
          items![index!].getSubject.toString()[0],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          items![index!].getSubject.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      subtitle: Text(
        items![index!].getMessageText.toString(),
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      trailing: Column(
        children: [
          Text(items![index!].getDisplay.toString()),
          const SizedBox(height: 8.0),
          const CustomIcon(),
        ],
      ),
    );
  }
}
