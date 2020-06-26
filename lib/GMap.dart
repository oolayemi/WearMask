import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GMap extends StatefulWidget {
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  GoogleMapController _controller;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker, marker2;
  double lat, long;
  Circle circle;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              color: Colors.white,
              onPressed: () {
                saveAsMyLocation();
              })
        ],
        title: Text(
          'Choose your residence',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 28.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(6.5236, -3.6006),
          zoom: 19,
        ),
        markers: Set.of(
            (marker != null && marker2 != null) ? [marker, marker2] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      /*floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          tooltip: 'Choose current location',
          onPressed: () {
            getCurrentLocation();
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
    );
  }

  void saveAsMyLocation() {
    print(lat);
    print('\n');
    print(long);
    Fluttertoast.showToast(
        msg: "Is this your locaion?",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).accentColor,
        textColor: Colors.white,
        fontSize: 20.0);
  }

  void getCurrentLocation() async {
    try {
      var location = await _locationTracker.getLocation();

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        lat = newLocalData.latitude;
        long = newLocalData.longitude;

        if (_controller != null) {
          _controller
              .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
            target: LatLng(newLocalData.latitude, newLocalData.longitude),
            tilt: 0,
            zoom: 19,
          )));
          updateMarker(newLocalData);
        }
      });

      updateMarker(location);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint('Permission Denied');
      }
    }
  }

  void updateMarker(LocationData newLocationData) {
    LatLng latLng = LatLng(newLocationData.latitude, newLocationData.longitude);
    LatLng latLng2 = LatLng(newLocationData.latitude + 0.000142,
        newLocationData.longitude + 0.000142);
    this.setState(() {
      marker = Marker(
        markerId: MarkerId('Home'),
        infoWindow: InfoWindow(title: 'Home'),
        position: latLng,
        zIndex: 2,
        //rotation: newLocationData.heading,
        draggable: false,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      );
      circle = Circle(
        circleId: CircleId("Yup"),
        radius: newLocationData.accuracy,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70),
      );
      marker2 = Marker(
        markerId: MarkerId('Reminder'),
        infoWindow: InfoWindow(title: 'Reminder location'),
        position: latLng2,
        //rotation: newLocationData.heading,
        draggable: false,
        //anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });
  }
}

/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class GMap extends StatefulWidget {
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose your residence',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          //_zoomminusfunction(),
          //_zoomplusfunction(),
          //_buildContainer(),
        ],
      ),
    );
  }



Widget _googlemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition( target: LatLng(6.5236, -3.6006), zoom: 10),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: {
          lagosMaker, abujaMaker
        },
      ),
    );
  }
}


Marker lagosMaker = Marker(
  markerId: MarkerId('Lagos'),
  position:  LatLng(6.5236, -3.6006),
  infoWindow: InfoWindow(title: 'Lagos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet
  ),
);

Marker abujaMaker = Marker(
  markerId: MarkerId('Abuja'),
  position:  LatLng(9.0765, -7.3986),
  infoWindow: InfoWindow(title: 'Abuja'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet
  ),
);
*/
