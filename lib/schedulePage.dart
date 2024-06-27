import 'package:flutter/material.dart';
import "schedule.dart";

class SchedulePage extends StatelessWidget {
  final String stationID;
  final String city;
  final String stationName;
  const SchedulePage({ required this.stationName, required this.stationID,required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stationName),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<Schedule>>(
        future: fetchData(stationID,city),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final List<Schedule> schedules = snapshot.data!;
            return ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final Schedule schedule = schedules[index];
                  List<Map<String, String>> arrivalTime = [];
                  for (var timetables in schedule.timetables ?? []) {
                    for (var stopTimes in timetables.stopTimes) {
                      if (stopTimes.stopName.zhTw == stationName) {
                        arrivalTime.add({
                          'tripID': timetables.tripID ?? '',
                          'arrivalTime': stopTimes.arrivalTime ?? ''});
                      }
                    }
                  }
                  arrivalTime.sort((a, b) => a['arrivalTime']!.compareTo(b['arrivalTime']!));
                  return Column(
                    children: arrivalTime.map((arrivalTime) {
                      return ListTile(
                        title: Text(
                          schedule.routeName?.zhTw.toString() ?? '',
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          '班次代號: ${arrivalTime['tripID']}, 預計抵達時間${arrivalTime['arrivalTime']}',
                        ),
                        leading: Icon(
                          Icons.bus_alert_sharp,
                          color: Colors.blueAccent,
                        ),
                      );
                    }).toList(),
                  );
                }
            );
          } else {
            // If there is no data
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}