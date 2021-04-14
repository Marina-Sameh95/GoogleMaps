import 'dart:async';
import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/provider/data_provider.dart';
import 'package:provider/provider.dart';




class MapProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text("Map")),
        backgroundColor:  Color.fromARGB(250, 25, 112, 147),
      ),
      body: ChangeNotifierProvider<DataProvider> (
        create: (context) => DataProvider(),
          child: MapBody(),
      ),
    );
  }
}

class MapBody extends StatefulWidget {
  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
BitmapDescriptor customMarker;
Completer<GoogleMapController> _controller = Completer();
Iterable markers = [];

Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
  return Marker(
      markerId: MarkerId(AppConstant.list[index]['id']),
      position: LatLng(
        AppConstant.list[index]['lat'],
        AppConstant.list[index]['lon'],
      ),
      // icon:customMarker,
      infoWindow: InfoWindow(title: AppConstant.list[index]["title"]),

  );
});

@override
void initState() {
  setState(() {
    markers = _markers;
  });
  super.initState();

}
//
// createMarker(context) {
//   if (customMarker == null) {
//     ImageConfiguration configuration = createLocalImageConfiguration(context);
//     BitmapDescriptor.fromAssetImage(configuration, 'img/boy.png')
//         .then((icon) {
//       setState(() {
//         customMarker = icon;
//       });
//     });
//   }
// }

getCustomMarker() async{
  customMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'img/boy.png');
  customMarker = await BitmapDescriptor.defaultMarker;
}


  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (BuildContext context, DataProvider data, Widget child) =>
          Container(
            color: Colors.black,
            child: Container(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(51.807979, 10.340948),
                  zoom: 13.0
                ),
                onMapCreated: (GoogleMapController googleMapController) {
                  _controller.complete(googleMapController);
                },
                markers: Set.from(markers),
              ),
            ),
          ),
    );
  }
}

class AppConstant {
  static List<Map<String, dynamic>> list = [
    {"title": "one", "id": "1", "lat": 51.807979, "lon": 10.340948},
    {"title": "two", "id": "2", "lat": 51.807768, "lon": 10.341856},
    {"title": "three", "id": "3", "lat":51.807204, "lon": 10.342045},
    {"title": "four", "id": "4", "lat":51.808285, "lon": 10.341562},
    {"title": "five", "id": "5", "lat":51.808013, "lon": 10.342656},
  ];
}