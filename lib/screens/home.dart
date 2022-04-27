import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLg;
import 'package:quicloc/screens/messages.dart';
import 'package:quicloc/services/file_io.dart';
import '../models/location.dart';
import 'package:quicloc/constants/theme.dart';
import 'package:quicloc/shared/flutter_map_widget.dart';

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
    locations = FileIO.readCoordinates();
    markers = createMarkers(locations);
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
            return FlutterMapWidget(items: items);
          } else {
            return const Text("Loading...");
          }
        },
      ),
    );
  }
}
