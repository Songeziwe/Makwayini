import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLg;

class FlutterMapWidget extends StatelessWidget {
  const FlutterMapWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Marker> items;

  @override
  Widget build(BuildContext context) {
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
  }
}
