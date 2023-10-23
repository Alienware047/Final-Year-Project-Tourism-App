// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:math';
//
// import 'package:location/location.dart';
//
//
//
// class MyMapWidget1 extends StatefulWidget {
//   const MyMapWidget1({Key? key}) : super(key: key);
//
//   @override
//   State<MyMapWidget1> createState() => _MyMapWidget1State();
// }
//
// class _MyMapWidget1State extends State<MyMapWidget1> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   static const LatLng sourceLocation = LatLng(7.3349, -2.3123, );
//   static const LatLng destination = LatLng(7.3349, -2.3123);
//
//   List<LatLng> polylineCoordinates = [];
//   LocationData? currentLocation;
//
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
//
//
//   void getCurrentLocation() async {
//     Location location = Location();
//
//
//
//     location.getLocation().then((location) {
//       currentLocation = location;
//     },);
//
//     GoogleMapController googleMapController = await _controller.future;
//
//
//     location.onLocationChanged.listen((newLoc) {
//       currentLocation = newLoc;
//
//       googleMapController.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(
//               zoom : 13.5,
//               target: LatLng(
//                   newLoc!.latitude!,
//                   newLoc!.longitude!))));
//
//       setState(() {});
//     });
//   }
//   // void setCustomMarkerIcon(){
//   //    BitmapDescriptor.fromAssetImage(Imageconfiguration.empty, ImageConfiguration.empty,)
//   // }
//
//   void getPolylinePoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         google_api_Key,
//         PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
//         PointLatLng(destination.latitude, destination.longitude));
//
//     if (result.points.isNotEmpty){
//       result.points.forEach(
//             (PointLatLng point)=> polylineCoordinates.add(
//             LatLng(point.latitude, point.longitude)
//         ),
//       );
//       setState(() {});
//     }
//   }
//
//   @override
//   void initState(){
//     getCurrentLocation();
//     getPolylinePoints();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: currentLocation == null
//           ? const Center(child: Text("Loading"),)
//           :GoogleMap(
//         initialCameraPosition:
//         CameraPosition(
//             target: LatLng(
//                 currentLocation!.latitude!, currentLocation!.longitude!),
//             zoom: 14.5
//         ),
//         polylines: {
//           Polyline(
//             polylineId: PolylineId("route"),
//             points: polylineCoordinates,
//             color: Colors.deepOrange,
//             width: 6,
//           )
//         },
//         markers:{
//           Marker(
//               markerId: const MarkerId("currentLocation"),
//               position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
//           ),
//           const Marker(
//               markerId: MarkerId("source"),
//               position: sourceLocation
//           ),
//           const Marker(
//               markerId: MarkerId("destination"),
//               position: destination
//           )
//         } ,
//         onMapCreated: (mapController){
//           _controller.complete(mapController);
//         },
//
//       ),
//     );
//   }
// }
//
