import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth.dart';

class EstimatedTime {
  String? plateNumb;
  String? stopUID;
  String? stopID;
  StopName? stopName;
  String? routeUID;
  String? routeID;
  RouteName? routeName;
  String? subRouteUID;
  String? subRouteID;
  SubRouteName? subRouteName;
  num? direction;
  num? estimateTime;
  num? stopCountDown;
  String? currentStop;
  String? destinationStop;
  num? stopSequence;
  num? stopStatus;
  num? messageType;
  String? nextBusTime;
  bool? isLastBus;
  List<Estimates>? estimates;
  String? dataTime;
  String? transTime;
  String? srcRecTime;
  String? srcTransTime;
  String? srcUpdateTime;
  String? updateTime;

  EstimatedTime({
    this.plateNumb,
    this.stopUID,
    this.stopID,
    this.stopName,
    this.routeUID,
    this.routeID,
    this.routeName,
    this.subRouteUID,
    this.subRouteID,
    this.subRouteName,
    this.direction,
    this.estimateTime,
    this.stopCountDown,
    this.currentStop,
    this.destinationStop,
    this.stopSequence,
    this.stopStatus,
    this.messageType,
    this.nextBusTime,
    this.isLastBus,
    this.estimates,
    this.dataTime,
    this.transTime,
    this.srcRecTime,
    this.srcTransTime,
    this.srcUpdateTime,
    this.updateTime,
  });

  factory EstimatedTime.fromJson(dynamic json) {
    return EstimatedTime(
      plateNumb : json['PlateNumb'],
      stopUID : json['StopUID'],
      stopID : json['StopID'],
      stopName : json['StopName'] != null ? StopName.fromJson(json['StopName']) : null,
      routeUID : json['RouteUID'],
      routeID : json['RouteID'],
      routeName : json['RouteName'] != null ? RouteName.fromJson(json['RouteName']) : null,
      subRouteUID : json['SubRouteUID'],
      subRouteID : json['SubRouteID'],
      subRouteName : json['SubRouteName'] != null ? SubRouteName.fromJson(json['SubRouteName']) : null,
      direction : json['Direction'],
      estimateTime : json['EstimateTime'],
      stopCountDown : json['StopCountDown'],
      currentStop : json['CurrentStop'],
      destinationStop : json['DestinationStop'],
      stopSequence : json['StopSequence'],
      stopStatus : json['StopStatus'],
      messageType : json['MessageType'],
      nextBusTime : json['NextBusTime'],
      isLastBus : json['IsLastBus'],
      estimates: json['Estimates'] != null ? (json['Estimates'] as List).map((item) => Estimates.fromJson(item)).toList() : null,
      dataTime : json['DataTime'],
      transTime : json['TransTime'],
      srcRecTime : json['SrcRecTime'],
      srcTransTime : json['SrcTransTime'],
      srcUpdateTime : json['SrcUpdateTime'],
      updateTime : json['UpdateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PlateNumb'] = plateNumb;
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
    map['SubRouteUID'] = subRouteUID;
    map['SubRouteID'] = subRouteID;
    if (subRouteName != null) {
      map['SubRouteName'] = subRouteName?.toJson();
    }
    map['Direction'] = direction;
    map['EstimateTime'] = estimateTime;
    map['StopCountDown'] = stopCountDown;
    map['CurrentStop'] = currentStop;
    map['DestinationStop'] = destinationStop;
    map['StopSequence'] = stopSequence;
    map['StopStatus'] = stopStatus;
    map['MessageType'] = messageType;
    map['NextBusTime'] = nextBusTime;
    map['IsLastBus'] = isLastBus;
    if (estimates != null) {
      map['Estimates'] = estimates?.map((v) => v.toJson()).toList();
    }
    map['DataTime'] = dataTime;
    map['TransTime'] = transTime;
    map['SrcRecTime'] = srcRecTime;
    map['SrcTransTime'] = srcTransTime;
    map['SrcUpdateTime'] = srcUpdateTime;
    map['UpdateTime'] = updateTime;
    return map;
  }
}

/// PlateNumb : "string"
/// EstimateTime : 0
/// IsLastBus : true
/// VehicleStopStatus : 0

class Estimates {
  String? plateNumb;
  num? estimateTime;
  bool? isLastBus;
  num? vehicleStopStatus;

  Estimates({required this.plateNumb, required this.estimateTime, required this.isLastBus,required this.vehicleStopStatus});

  factory Estimates.fromJson(dynamic json) {
    return Estimates(
      plateNumb : json['PlateNumb'],
      estimateTime : json['EstimateTime'],
      isLastBus : json['IsLastBus'],
      vehicleStopStatus : json['VehicleStopStatus'],
    );

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PlateNumb'] = plateNumb;
    map['EstimateTime'] = estimateTime;
    map['IsLastBus'] = isLastBus;
    map['VehicleStopStatus'] = vehicleStopStatus;
    return map;
  }

}

/// Zh_tw : "string"
/// En : "string"

class SubRouteName {
  String? zhTw;
  String? en;

  SubRouteName({required this.zhTw, required this.en});

  factory SubRouteName.fromJson(dynamic json) {
    return SubRouteName(
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

/// Zh_tw : "string"
/// En : "string"

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

/// Zh_tw : "string"
/// En : "string"

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


Future<List<EstimatedTime>> fetchData(String stationID, String city) async {
  String apiUrl="https://tdx.transportdata.tw/api/advanced/v2/Bus/EstimatedTimeOfArrival/City/$city/PassThrough/Station/$stationID?%24top=30&%24format=JSON";
  String accessToken = await authenticate();
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((data) => EstimatedTime.fromJson(data)).toList();
  } else {
    print('Failed to fetch data: ${response.statusCode}');
  }
  return [];
}