import 'package:quicloc/models/location.dart';
import 'package:quicloc/models/message.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'dart:convert';

class FileIO {
  static Future<List<Message>> readJsonFile() async {
    // read json file
    final jsondata =
        await root_bundle.rootBundle.loadString('assets/messages.json');
    // decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;
    // file_io json and initialize using Messages model
    return list.map((item) {
      return Message.fromJson(item);
    }).toList();
  }

  static Future<List<Location>> readCoordinates() async {
    // read json file
    final jsondata = await root_bundle.rootBundle
        .loadString('assets/vehicleCoordinates.json');
    // decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;
    // file_io json and initialize using Messages model
    return list.map((item) {
      return Location.fromJson(item);
    }).toList();
  }
}
