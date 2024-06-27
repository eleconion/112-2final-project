
import 'package:http/http.dart' as http;
import 'dart:convert';
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

class CityData{
  String? CityID;
  String? CityName;
  String? CityCode;
  String? City;
  String? CountyID;
  String? Version;
  CityData({
    this.CityID,
    this.CityCode,
    this.CityName,
    this.City,
    this.CountyID,
    this.Version,
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      CityID : json['CityID'],
      CityCode : json['CityCode'],
      CityName : json['CityName'],
      City : json['City'] ,
      CountyID : json['CountyID'],
      Version : json['Version'] ,
    );
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CityID'] = CityID;
    map['CityCode'] = CityCode;
    map['CityName'] = CityName;
    map['City'] = City;
    map['CountyID'] = CountyID;
    map['Version'] = Version;
    return map;
  }
}


Future<List<CityData>> fetchCity() async {
  String apiUrl="https://tdx.transportdata.tw/api/basic/v2/Basic/City?%24format=JSON";
  String accessToken = await authenticate();
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    final List<CityData> cities  = jsonData.map((data) => CityData.fromJson(data)).toList();
    return cities;
  } else {
    print('Failed to fetch city: ${response.statusCode}');
  }
  return [];
}

Future<List<Station>> fetchStation(String city) async {
  String apiUrl="https://tdx.transportdata.tw/api/basic/v2/Bus/Station/City/$city?%24top=100&%24format=JSON";

  String accessToken = await authenticate();

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    print("getstation");
    final List<dynamic> jsonData = jsonDecode(response.body);
    final List<Station> stops  = jsonData.map((data) => Station.fromJson(data)).toList();
    return stops;

  } else {
    print('Failed to fetch station: ${response.statusCode}');
    // throw Exception('Failed to fetch data');
  }
  return [];
}
