import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLg;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('Map'),
        actions: [
          TextButton.icon(
            icon: const Icon(
              Icons.message,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/messages');
            },
            label: const Text(
              'messages',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latLg.LatLng(-33.943336828229064, 18.468253984264145),
          zoom: 13.0,
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
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: latLg.LatLng(51.5, -0.09),
                builder: (ctx) => const FlutterLogo(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
