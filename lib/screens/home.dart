import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLg;
import 'package:flutter/services.dart' as root_bundle;
import 'package:quicloc/screens/messages.dart';
import 'dart:convert';
import '../models/location.dart';
import 'package:quicloc/constants/theme.dart';

class Home extends StatefulWidget {
  static const String homeScreenPath = '/homeScreen';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Marker>> markers;
  late Future<List<Location>> locations;

  @override
  void initState() {
    super.initState();
    locations = readCoordinates();
    markers = createMarkers(locations);
  }

  Future<List<Location>> readCoordinates() async {
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

  Future<List<Marker>> createMarkers(Future<List<Location>> locations) async {
    final list = await locations;

    return list.map((location) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: latLg.LatLng(location.getLatitude, location.getLongitude),
        builder: (ctx) => Transform.rotate(
          angle: location.getHeading,
          child: const Image(
            image: AssetImage('assets/images/ic_new_white_taxi.png'),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: const Icon(
          Icons.map,
          color: kSecondary,
        ),
        title: const Text(
          'Map',
          style: kTextStyle,
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(
              Icons.message,
              color: kSecondary,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Messages.messagesScreenPath);
            },
            label: const Text(
              'messages',
              style: kTextStyle,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: markers,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              '${snapshot.error}',
              style: kErrorStyle,
            );
          } else if (snapshot.hasData) {
            var items = snapshot.data as List<Marker>;
            return FlutterMap(
              options: MapOptions(
                center: latLg.LatLng(-29.61889314245627, 22.640473792501435),
                zoom: 5.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/songeziwe/cl27zqw74000214m1rihq4fao/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29uZ2V6aXdlIiwiYSI6ImNsMjdzNzZ0ajAwaHczY284YjB6MWxxeWcifQ.rKWPJBBl-xogFkBMo_GavQ",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1Ijoic29uZ2V6aXdlIiwiYSI6ImNsMjdzNzZ0ajAwaHczY284YjB6MWxxeWcifQ.rKWPJBBl-xogFkBMo_GavQ',
                    'id': 'mapbox.mapbox-streets-v8',
                  },
                ),
                MarkerLayerOptions(
                  markers: items,
                ),
              ],
            );
          } else {
            return const Text("Loading...");
          }
        },
      ),
    );
  }
}
