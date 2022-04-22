class Location {
  String? _heading;
  String? _latitude;
  String? _longitude;

  Location(_heading, _latitude, _longitude);

  // method that assign values to respective instance variables
  Location.fromJson(Map<String, dynamic> json) {
    _heading = json['heading'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  // accessor methods
  String? get getHeading {
    return _heading;
  }

  String? get getLatitude {
    return _latitude;
  }

  String? get getLongitude {
    return _longitude;
  }
}
