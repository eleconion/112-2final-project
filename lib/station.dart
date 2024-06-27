import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'auth.dart';
class Station {
  String? stationUID;
  String? stationID;
  StationName? stationName;
  StationPosition? stationPosition;
  String? stationAddress;
  String? stationGroupID;
  List<Stops>? stops;
  String? locationCityCode;
  String? bearing;
  String? updateTime;
  num? versionID;

  Station({
    required this.stationUID,
    required this.stationID,
    required this.stationName,
    required this.stationPosition,
    required this.stationAddress,
    required this.stationGroupID,
    required this.stops,
    required this.locationCityCode,
    required this.bearing,
    required this.updateTime,
    required this.versionID,
  });

  factory Station.fromJson(dynamic json) {
    return Station(
        stationUID : json['StationUID'],
        stationID : json['StationID'],
        stationName : json['StationName'] != null ? StationName.fromJson(json['StationName']) : null,
        stationPosition : json['StationPosition'] != null ? StationPosition.fromJson(json['StationPosition']) : null,
        stationAddress : json['StationAddress'],
        stationGroupID : json['StationGroupID'],
        stops: json['Stops'] != null ? (json['Stops'] as List).map((item) => Stops.fromJson(item)).toList() : null,
        locationCityCode : json['LocationCityCode'],
        bearing : json['Bearing'],
        updateTime : json['UpdateTime'],
        versionID : json['VersionID'],
    );
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StationUID'] = stationUID;
    map['StationID'] = stationID;
    if (stationName != null) {
      map['StationName'] = stationName?.toJson();
    }
    if (stationPosition != null) {
      map['StationPosition'] = stationPosition?.toJson();
    }
    map['StationAddress'] = stationAddress;
    map['StationGroupID'] = stationGroupID;
    if (stops != null) {
      map['Stops'] = stops?.map((v) => v.toJson()).toList();
    }
    map['LocationCityCode'] = locationCityCode;
    map['Bearing'] = bearing;
    map['UpdateTime'] = updateTime;
    map['VersionID'] = versionID;
    return map;
  }

}

class Stops {
  String? stopUID;
  String? stopID;
  StopName? stopName;
  String? routeUID;
  String? routeID;
  RouteName? routeName;

  Stops({required this.stopUID, required this.stopID, required this.stopName, required this.routeUID, required this.routeID, required this.routeName});

  factory Stops.fromJson(dynamic json) {
    return Stops(
      stopUID : json['StopUID'],
      stopID : json['StopID'],
      stopName : json['StopName'] != null ? StopName.fromJson(json['StopName']) : null,
      routeUID : json['RouteUID'],
      routeID : json['RouteID'],
      routeName : json['RouteName'] != null ? RouteName.fromJson(json['RouteName']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StopUID'] = stopUID;
    map['StopID'] = stopID;
    if (stopName != null) {
      map['StopName'] = stopName?.toJson();
    }
    map['RouteUID'] = routeUID;
    map['RouteID'] = routeID;
    if (routeName != null) {
      map['RouteName'] = routeName?.toJson();
    }
    return map;
  }

}


class RouteName {
  String? zhTw;
  String? en;
  RouteName({required this.zhTw, required this.en});

  factory RouteName.fromJson(dynamic json) {
    return RouteName(
      zhTw : json['Zh_tw'],
      en : json['En'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Zh_tw'] = zhTw;
    map['En'] = en;
    return map;
  }

}

class StopName {
  String? zhTw;
  String? en;

  StopName({required this.zhTw, required this.en});

  factory StopName.fromJson(Map<String, dynamic> json) {
    return StopName(
      zhTw: json['Zh_tw'],
      en: json['En'],
    );
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Zh_tw'] = zhTw;
    map['En'] = en;
    return map;
  }

}

class StationPosition {
  num? positionLon;
  num? positionLat;
  String? geoHash;

  StationPosition({required this.positionLon, required this.positionLat, required this.geoHash});

  factory StationPosition.fromJson(dynamic json) {
    return StationPosition(
        positionLon : json['PositionLon'],
        positionLat : json['PositionLat'],
        geoHash : json['GeoHash'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PositionLon'] = positionLon;
    map['PositionLat'] = positionLat;
    map['GeoHash'] = geoHash;
    return map;
  }

}



class StationName {
  String? zhTw;
  String? en;

  StationName({required this.zhTw, required this.en});

  factory StationName.fromJson(dynamic json) {
    return StationName(
        zhTw : json['Zh_tw'],
        en : json['En'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Zh_tw'] = zhTw;
    map['En'] = en;
    return map;
  }
}

Map<String, String> cityCodeToName = {
  "TPE": "Taipei",
  "NWT": "NewTaipei",
  "TAO": "Taoyuan",
  "TXG": "Taichung",
  "TNN": "Tainan",
  "KHH": "Kaohsiung",
  "KEE": "Keelung",
  "HSZ": "Hsinchu",
  "HSQ": "HsinchuCounty",
  "MIA": "MiaoliCounty",
  "CHA": "ChanghuaCounty",
  "NAN": "NantouCounty",
  "YUN": "YunlinCounty",
  "CYQ": "ChiayiCounty",
  "CYI": "Chiayi",
  "PIF": "PingtungCounty",
  "ILA": "YilanCounty",
  "HUA": "HualienCounty",
  "TTT": "TaitungCounty",
  "KIN": "KinmenCounty",
  "PEH": "PenghuCounty",
  "LIE": "LienchiangCounty"
};


Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
}


Future<List<double>> getCurrentLocation() async {
  try {
    Position position = await _determinePosition();
    double latitude = position.latitude;
    double longitude = position.longitude;

    print('緯度: $latitude, 經度: $longitude');
    return [22.637053, 120.326189];
  //   return [latitude,longitude];
  } catch (e) {
    print('無法取得當前位置: $e');
    return [0.0, 0.0];
  }
}

Future<List<Station>> fetchData() async {
  List<double> position = await getCurrentLocation();
  String apiUrl="https://tdx.transportdata.tw/api/advanced/v2/Bus/Station/NearBy?%24top=20&%24spatialFilter=nearby%28${position[0]}%2C%20${position[1]}%2C%20500%29&%24format=JSON";
  String accessToken = await authenticate();

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    final List<Station> stations  = jsonData.map((data) => Station.fromJson(data)).toList();
    return stations;
  } else {
    print('Failed to fetch data: ${response.statusCode}');
  }
  return [];
}
