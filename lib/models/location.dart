class Location {
  double _heading = 0;
  double? _latitude;
  double? _longitude;

  Location(_heading, _latitude, _longitude);

  // method that assign values to respective instance variables
  Location.fromJson(Map<String, dynamic> json) {
    _heading = double.parse(json['heading']);

    _latitude = json['latitude'] is String
        ? double.parse(json['latitude'])
        : json['latitude'];
    _longitude = json['longitude'] is String
        ? double.parse(json['longitude'])
        : json['longitude'];

    // _latitude = json['latitude'].toDouble();
    // _longitude = json['longitude'].toDouble();
  }

  // accessor methods
  double get getHeading {
    return _heading;
  }

  double? get getLatitude {
    return _latitude;
  }

  double? get getLongitude {
    return _longitude;
  }
}
