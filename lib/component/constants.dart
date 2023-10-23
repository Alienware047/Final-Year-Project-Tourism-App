import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomMarker extends Marker {
  CustomMarker({required LatLng markerPoint})
      : super(
    width: 100.0,
    height: 300.0,
    point: markerPoint,
    builder: (ctx) => Container(
      child: const Icon(
        Icons.location_on,
        color: Colors.red,
        size: 30.0,
      ),
    ),
  );
}
class Constant extends StatefulWidget {
  const Constant({Key? key}) : super(key: key);

  @override
  State<Constant> createState() => _ConstantState();
}

class _ConstantState extends State<Constant> {
  final mapController =MapController();
  LatLng initialCameraPosition = LatLng(7.3349, -2.3123);
  LatLng? destinationMarkerPosition;
  List<LatLng> graphhopperPath = [];


  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      initialCameraPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void onMapTap(Map<String, LatLng> tapDetails) {
    setState(() {
      destinationMarkerPosition = tapDetails['latlng'];
      if (destinationMarkerPosition != null) {
        calculateGraphhopperPath();
      }
    });
  }

  Future<void> calculateGraphhopperPath() async {
    if (destinationMarkerPosition != null) {
      String baseUrl = 'https://graphhopper.com/api/1/route';
      String apiKey = '9435f25f-0344-4c8a-840b-b2532ad8c587'; // Replace with your GraphHopper API key

      String url =
          '$baseUrl?point=${initialCameraPosition
              .latitude},${initialCameraPosition.longitude}&point=${destinationMarkerPosition!
                  .latitude},${destinationMarkerPosition!.longitude}&vehicle=car&locale=en-US&instructions=true&key=$apiKey';

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResult = json.decode(response.body);
        List<dynamic> paths = jsonResult['paths'];
        if (paths.isNotEmpty) {
          List<dynamic> points = paths[0]['points']['coordinates'];
          List<LatLng> route = points.map(
                (point) =>
                LatLng(
                  point[1].toDouble(),
                  point[0].toDouble(),
                ),
          ).toList();
          print('GraphHopper path: $route');
          setState(() {
            graphhopperPath = route;
          });
        }
      } else {
        print('Error calculating GraphHopper path: ${response.statusCode}');
      }
    } else {
      setState(() {
        graphhopperPath = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: initialCameraPosition,
        zoom: 13,
        minZoom: 10,
        maxZoom: 17.5,
        onTap: (tapPosition, tapLatLng) {
          onMapTap({'latlng': tapLatLng});
        },
      ),
      children:[ TileLayer(
        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        subdomains: const ['a', 'b', 'c'],
      ),
        MarkerLayer(
          markers: [
            Marker(
              width: 100.0,
              height: 300.0,
              point: initialCameraPosition,
              builder: (ctx) =>
                  Container(
                    child: const Icon(Icons.person_pin_circle, color: Colors.black),
                  ),
            ),
            if (destinationMarkerPosition != null)
              CustomMarker(markerPoint: destinationMarkerPosition!),
          ],
        ),
        PolylineLayer(
          polylines: [
            if (graphhopperPath.isNotEmpty)
              Polyline(
                points: graphhopperPath,
                strokeWidth: 2.0,
              ),
          ],
        ),
      ]
    );
  }
}