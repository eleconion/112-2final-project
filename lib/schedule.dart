import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth.dart';

class Schedule {
  String? routeUID;
  String? routeID;
  RouteName? routeName;
  String? subRouteUID;
  String? subRouteID;
  SubRouteName? subRouteName;
  num? direction;
  String? operatorID;
  String? operatorCode;
  String? operatorNo;
  List<Timetables>? timetables;
  List<Frequencys>? frequencys;
  String? updateTime;
  num? versionID;

  Schedule({
    this.routeUID,
    this.routeID,
    this.routeName,
    this.subRouteUID,
    this.subRouteID,
    this.subRouteName,
    this.direction,
    this.operatorID,
    this.operatorCode,
    this.operatorNo,
    this.timetables,
    this.frequencys,
    this.updateTime,
    this.versionID,
  });

  factory Schedule.fromJson(dynamic json) {
    return Schedule(
        routeUID: json['RouteUID'],
        routeID : json['RouteID'],
        routeName : json['RouteName'] != null ? RouteName.fromJson(json['RouteName']) : null,
        subRouteUID : json['SubRouteUID'],
        subRouteID : json['SubRouteID'],
        subRouteName : json['SubRouteName'] != null ? SubRouteName.fromJson(json['SubRouteName']) : null,
        direction : json['Direction'],
        operatorID : json['OperatorID'],
        operatorCode : json['OperatorCode'],
        operatorNo : json['OperatorNo'],
        timetables : json['Timetables'] != null ? (json['Timetables'] as List).map((item) => Timetables.fromJson(item)).toList() : null,
        frequencys : json['Frequencys'] != null ? (json['Frequencys'] as List).map((item) => Frequencys.fromJson(item)).toList() : null,
        updateTime : json['UpdateTime'],
        versionID : json['VersionID'],
        );
  }
    Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['OperatorID'] = operatorID;
    map['OperatorCode'] = operatorCode;
    map['OperatorNo'] = operatorNo;
    if (timetables != null) {
      map['Timetables'] = timetables?.map((v) => v.toJson()).toList();
    }
    if (frequencys != null) {
      map['Frequencys'] = frequencys?.map((v) => v.toJson()).toList();
    }
    map['UpdateTime'] = updateTime;
    map['VersionID'] = versionID;
    return map;
    }
  }

class Frequencys {
  String? startTime;
  String? endTime;
  num? minHeadwayMins;
  num? maxHeadwayMins;
  ServiceDay? serviceDay;
  List<SpecialDays>? specialDays;

  Frequencys({required this.startTime, required this.endTime, required this.minHeadwayMins,required this.maxHeadwayMins,required this.serviceDay,required this.specialDays});

  factory Frequencys.fromJson(dynamic json) {
    return Frequencys(
        startTime : json['StartTime'],
        endTime : json['EndTime'],
        minHeadwayMins : json['MinHeadwayMins'],
        maxHeadwayMins : json['MaxHeadwayMins'],
        serviceDay: json['ServiceDay'] != null ? ServiceDay.fromJson(json['ServiceDay']) : null,
        specialDays: json['SpecialDays'] != null ? (json['SpecialDays'] as List).map((item) => SpecialDays.fromJson(item)).toList() : null
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StartTime'] = startTime;
    map['EndTime'] = endTime;
    map['MinHeadwayMins'] = minHeadwayMins;
    map['MaxHeadwayMins'] = maxHeadwayMins;
    if (serviceDay != null) {
      map['ServiceDay'] = serviceDay?.toJson();
    }
    if (specialDays != null) {
      map['SpecialDays'] = specialDays?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SpecialDays {
  List<String>? dates;
  DatePeriod? datePeriod;
  num? serviceStatus;
  String? description;

  SpecialDays({required this.dates, required this.datePeriod, required this.serviceStatus,required this.description});

  factory SpecialDays.fromJson(dynamic json) {
      return SpecialDays(
          dates : json['Dates'] != null ? json['Dates'].cast<String>() : [],
          datePeriod: json['DatePeriod'] != null ? DatePeriod.fromJson(json['DatePeriod']) : null,
          serviceStatus : json['ServiceStatus'],
          description : json['Description'],
      );

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Dates'] = dates;
    map['DatePeriod'] = datePeriod?.toJson();
    map['ServiceStatus'] = serviceStatus;
    map['Description'] = description;
    return map;
  }

}


class DatePeriod {
  String? startDate;
  String? endDate;

  DatePeriod({required this.startDate, required this.endDate});

  factory DatePeriod.fromJson(dynamic json) {
    return DatePeriod(
        startDate : json['StartDate'],
        endDate : json['EndDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StartDate'] = startDate;
    map['EndDate'] = endDate;
    return map;
  }
}

class ServiceDay {
  String? serviceTag;
  num? sunday;
  num? monday;
  num? tuesday;
  num? wednesday;
  num? thursday;
  num? friday;
  num? saturday;
  num? nationalHolidays;

  ServiceDay({required this.serviceTag, required this.sunday, required this.monday, required this.tuesday, required this.wednesday, required this.thursday,
    required this.friday, required this.saturday, required this.nationalHolidays});

  factory ServiceDay.fromJson(dynamic json) {
    return ServiceDay(
      serviceTag : json['ServiceTag'],
      sunday : json['Sunday'],
      monday : json['Monday'],
      tuesday : json['Tuesday'],
      wednesday : json['Wednesday'],
      thursday : json['Thursday'],
      friday : json['Friday'],
      saturday : json['Saturday'],
      nationalHolidays : json['NationalHolidays'],
    );
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ServiceTag'] = serviceTag;
    map['Sunday'] = sunday;
    map['Monday'] = monday;
    map['Tuesday'] = tuesday;
    map['Wednesday'] = wednesday;
    map['Thursday'] = thursday;
    map['Friday'] = friday;
    map['Saturday'] = saturday;
    map['NationalHolidays'] = nationalHolidays;
    return map;
  }

}


class Timetables {
  String? tripID;
  bool? isLowFloor;
  ServiceDay? serviceDay;
  List<SpecialDays>? specialDays;
  List<StopTimes>? stopTimes;

  Timetables({required this.tripID, required this.isLowFloor, required this.serviceDay, required this.specialDays, required this.stopTimes});

  factory Timetables.fromJson(dynamic json) {
    return Timetables(
        tripID : json['TripID'],
        isLowFloor : json['IsLowFloor'],
        serviceDay: json['ServiceDay'] != null ? ServiceDay.fromJson(json['ServiceDay']) : null,
        specialDays: json['SpecialDays'] != null ? (json['SpecialDays'] as List).map((item) => SpecialDays.fromJson(item)).toList() : null,
        stopTimes: json['StopTimes'] != null ? (json['StopTimes'] as List).map((item) => StopTimes.fromJson(item)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TripID'] = tripID;
    map['IsLowFloor'] = isLowFloor;
    map['ServiceDay'] = serviceDay?.toJson();
    map['SpecialDays'] = specialDays?.map((v) => v.toJson()).toList();
    map['StopTimes'] = stopTimes?.map((v) => v.toJson()).toList();

    return map;
  }

}
class StopTimes {
  num? stopSequence;
  String? stopUID;
  String? stopID;
  StopName? stopName;
  String? arrivalTime;
  String? departureTime;

  StopTimes({required this.stopSequence, required this.stopUID, required this.stopID, required this.stopName, required this.arrivalTime,required this.departureTime});

  factory StopTimes.fromJson(dynamic json) {
    return StopTimes(
      stopSequence : json['StopSequence'],
      stopUID : json['StopUID'],
      stopID : json['StopID'],
      stopName: json['StopName'] != null ? StopName.fromJson(json['StopName']) : null,
      arrivalTime : json['ArrivalTime'],
      departureTime : json['DepartureTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StopSequence'] = stopSequence;
    map['StopUID'] = stopUID;
    map['StopID'] = stopID;
    map['StopName'] = stopName?.toJson();
    map['ArrivalTime'] = arrivalTime;
    map['DepartureTime'] = departureTime;
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

Future<List<Schedule>> fetchData(String stationID, String city) async {
  String apiUrl="https://tdx.transportdata.tw/api/advanced/v2/Bus/Schedule/City/$city/PassThrough/Station/$stationID?%24top=30&%24format=JSON";
  String accessToken = await authenticate();
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    final List<Schedule> schedules  = jsonData.map((data) => Schedule.fromJson(data)).toList();
    return schedules;
  } else {
    print('Failed to fetch data: ${response.statusCode}');
    throw Exception('Failed to fetch data');
  }
}