import 'package:flutter/material.dart';
import 'estimatedTime.dart';

class EstimatedPage extends StatelessWidget {
  final String stationID;
  final String city;
  final String stationName;
  const EstimatedPage({required this.stationID,required this.city,required this.stationName});
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
      body: FutureBuilder<List<EstimatedTime>>(
        future: fetchData(stationID,city),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If any error occurred during data fetching
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            // If data is successfully fetched
            bool isEmpty = true;
            final List<EstimatedTime> estimatedTimes = snapshot.data!;
            for(var estimatedTime in estimatedTimes){
              if (estimatedTime.stopStatus == 0){
                isEmpty = false;
                break;
              }
            }
            if(isEmpty){
              return AlertDialog(
                title: const Text('查無資料!'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('請返回至上頁'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('確定'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }else{
              return ListView.builder(
                  itemCount: estimatedTimes.length,
                  itemBuilder: (context, index) {
                    final EstimatedTime estimatedTime = estimatedTimes[index];
                    if (estimatedTime.stopStatus == 0) {
                      isEmpty = false;
                      return ListTile(
                        title: Text(
                          estimatedTime.routeName?.zhTw.toString() ?? '',
                          style: TextStyle(
                            fontSize: 20,
                          ),),
                        subtitle: Text(
                          '車牌: ${estimatedTime.plateNumb.toString() ?? '無提供車牌'}, 預計還要${estimatedTime
                              .estimateTime.toString() ?? ''}秒',
                        ),
                        leading: Icon(
                          Icons.bus_alert_sharp,
                          color: Colors.blueAccent,
                        ),
                      );
                    }
                    else {
                      return SizedBox.shrink();
                    }
                  }
              );
            }
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