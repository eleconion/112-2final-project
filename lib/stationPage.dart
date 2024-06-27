import 'package:flutter/material.dart';
import 'estimatedPage.dart';
import 'schedulePage.dart';
import 'station.dart';
class StationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("附近站點"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<Station>>(
        future: fetchData(),
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
            final List<Station> stations = snapshot.data!;

            return ListView.builder(
              itemCount: stations.length,
              itemBuilder: (context, index) {
                final Station station = stations[index];
                return ListTile(
                  title: Text('${station.stationName?.zhTw ?? ''}'),
                  subtitle: Text(
                    '${station.stationID?.toString() ?? ''}, ${station.stationAddress ?? '無提供地址'}',
                  ),
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.red, // Icon color
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EstimatedPage(stationID:station.stationID.toString(),city: cityCodeToName[station.locationCityCode.toString()]!,stationName: station.stationName?.zhTw ?? '',)),
                          );
                        },
                        child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '即時預估',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SchedulePage(stationName: station.stationName?.zhTw.toString() ?? '',stationID:station.stationID.toString(),city: cityCodeToName[station.locationCityCode.toString()]!)),
                          );

                        },
                        child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '時刻表',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                );
              },
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