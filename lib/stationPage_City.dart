import 'package:flutter/material.dart';
import 'dataFetch.dart';
import 'estimatedPage.dart';
import 'schedulePage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCityStationPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyCityStationPage extends StatefulWidget {
  const MyCityStationPage({super.key, required this.title});


  final String title;

  @override
  State<MyCityStationPage> createState() => CityStationpagestate();
}

class CityStationpagestate extends State<MyCityStationPage> {
  String? selectedCity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<CityData>>(
              future: fetchCity(),
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
                  final List<CityData> cities = snapshot.data!;
                  return DropdownButton<String>(
                    value: selectedCity,
                    hint: Text('Select City'),
                    items: cities.map((CityData city) {
                      return DropdownMenuItem<String>(
                        value: city.City,
                        child: Text(city.CityName ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue;
                      });
                    },
                  );
                } else {
                  return Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ]
        ),
      ),
      body: FutureBuilder<List<Station>>(
        future: fetchStation(selectedCity.toString()),
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
            final List<Station> stops = snapshot.data!;
            return ListView.builder(
              itemCount: stops.length,
              itemBuilder: (context, index) {
                final Station stop = stops[index];
                print(stop.stationName?.zhTw ?? '');
                return ListTile(
                  title: Text(stop.stationName?.zhTw ?? ''),
                  subtitle: Text(
                    '${stop.stationID?.toString() ?? ''}, ${stop.stationName?.zhTw ?? ''}',
                  ),
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EstimatedPage(stationID:stop.stationID.toString(),city: selectedCity!,stationName: stop.stationName?.zhTw ?? '')),
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
                            MaterialPageRoute(builder: (context) => SchedulePage(stationName: stop.stationName?.zhTw.toString() ?? '',stationID:stop.stationID.toString(),city: selectedCity!)),
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