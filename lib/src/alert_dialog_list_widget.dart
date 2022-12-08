import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlertDialogWithListWidget extends StatelessWidget {
  final List<LatLng> locationHistory;
  const AlertDialogWithListWidget({Key? key, required this.locationHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location History'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width/1.3,
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: locationHistory.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Column(
                  children: [
                    Text('Latitude: ${locationHistory[index].latitude}'),
                    Text('Longitude ${locationHistory[index].longitude}'),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 2, thickness: 2.0, color: Colors.black54,),
            ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
