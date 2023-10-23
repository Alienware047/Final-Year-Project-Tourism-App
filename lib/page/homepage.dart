import 'package:flutter/Material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:mapme2/custom_widgets/drawer.dart';
import '../custom_widgets/button_navigation.dart';
import '../custom_widgets/mymapwiget.dart';
import '../model/constants.dart';
import '../model/tourist_location.dart';
import '../model/user.dart';
// import 'package:backdrop/backdrop.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
// import 'package:graphs/graphs.dart';
import 'package:mapme2/model/polyline_service.dart';


class Graph {
  Map<Node, List<Node>> nodes(node) => node.edges;
  // Interesting data
}
class Node {
  final LatLng position;
  List<Edge> edges;

  Node({required this.position}) : edges = [];
}
class Edge {
  final Node targetNode;
  final double weight;

  Edge({required this.targetNode, required this.weight});
}


class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GoogleMapController? _mapController;
  double _currentZoom = 8.0;
  LatLng _initialCameraPosition = const LatLng(7.3349, -2.3123);
  LatLng? _tappedLocation;
  LatLng? _destinationLocation;
  Set<Marker> _markers = {};

  Polyline? _routePolyline;
  // List<LatLng> polylinePoints = [];
  List<Node> nodes = []; // Create a list of nodes
  List<LatLng> shortestPath = [];


  List<TouristSite>? touristSites = [];

  var points;

  MapsRoutes route =  MapsRoutes();
  DistanceCalculator distanceCalculator =  DistanceCalculator();
  String googleApiKey = 'AIzaSyB7_nP-22H9XnTxdHtCXHime0y2rc3xwEY';
  String totalDistance = 'No route';



  @override
  void initState() {
    super.initState();
    loadProperties();

    // _addDestinationMarkers();
  }

  Future _getCurrentLocation() async {
    print("_getCurrentLocation started");

    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
        print("ieiie: ${position.latitude}");

        _initialCameraPosition = LatLng(position.latitude, position.longitude);


      _setCameraToUserLocation(position); // Call the method here
    } catch (e) {
      print("Error getting current location: $e");
    }

    print("_getCurrentLocation ended");
  }


  List<LatLng> calculateShortestPath(LatLng start, LatLng destination) {

    List<LatLng> path = [];
    for (double t = 0.0; t <= 1.0; t += 0.1) {
      double lat = start.latitude + (destination.latitude - start.latitude) * t;
      double lng = start.longitude + (destination.longitude - start.longitude) * t;
      path.add(LatLng(lat, lng));
    }
    // Replace this with your actual A* pathfinding implementation
    // This is a simple example for demonstration purposes
    path.add(start);

    // Simulate a path by adding intermediate points


    path.add(destination);

    return path;
  }

  void _addDestinationMarkers() async {
    if (_destinationLocation == null) {
      return;
    }
    LatLng? destinationCoordinates = _tappedLocation;// Example coordinates

    List<LatLng> path = calculateShortestPath(
        _initialCameraPosition, destinationCoordinates!
    );

    // Draw the polyline on the map
    _drawPolylineOnMap(path);


    _markers.add(
      Marker(
        markerId: const MarkerId('marker1'),
        position: _destinationLocation!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: 'Destination 1',
          snippet: 'This is the first destination.',
        ),
      ),
    );

    setState(() {});
  }

  void _drawPolylineOnMap(List<LatLng> graphs) {
    final Polyline polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.blue,
      points: graphs,
    );

    setState(() {
      _routePolyline = polyline;
    });
  }

  void _setCameraToUserLocation(Position position) {
    if (_mapController != null) {
      LatLng userLocation = LatLng(position.latitude, position.longitude);
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(userLocation, _currentZoom),
      );

      // Add a marker at the user's location
      _markers.add(
        Marker(
          markerId: const MarkerId('userMarker'),
          position: userLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );

      setState(() {});
    }
  }

  Future<void> _showSearchDialog() async {
    var p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constants.apiKey,
        mode: Mode.fullscreen,
        language: "ar",
        region: "ar",
        offset: 0,
        hint: "Type here...",
        radius: 1000,
        types: [],
        strictbounds: false
    );
  }

   markers() async {
    print("markers started");


    for (var i = 0; i < touristSites!.length; i++){

      print("Mark: ${touristSites?.length}");

      _markers.add(
          Marker(
            infoWindow:  InfoWindow(
                title: touristSites?[i].name,
                snippet: touristSites?[i].description
            ),
            markerId:  MarkerId(touristSites?[i].id ?? ""),
            position: touristSites?[i].latLngLocation ?? const LatLng(0, 0),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta
            ),

            // icon: await  BitmapDescriptor.fromAssetImage(
            //     const ImageConfiguration(),
            //     "assets/tourist.jpg"
            // ),
          )
      );

      print("Marker: ${_markers.length}");

      print("markers ended");

    }







  }

  Future loadProperties() async{

     await _getCurrentLocation();





      // touristSites =  await TouristSite.getLocations();
      // await markers();




    // return touristSites;

  }


  @override
  Widget build(BuildContext context) {

    print(touristSites!.length);



    // Set<Polyline> polylines = _routePolyline != null ? {_routePolyline!} : {};

    return Scaffold(
      appBar:  AppBar(
        actions: [
          IconButton(onPressed: _showSearchDialog, icon: const Icon(Icons.search))
        ],
      ),
       drawer: SideBarMenu(user: widget.user, touristSites: [],),
      bottomNavigationBar: ButtonNav(user: widget.user, onTabSelected: (index) { 0; },),
      body: FutureBuilder(
        future: TouristSite.getLocations(),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            print("hes");

            touristSites = snapshot.data['touristSites'];
            points = snapshot.data['points'];

            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _initialCameraPosition,
                zoom: _currentZoom,
              ),

              markers: touristSites!.map<Marker>((touristSite){
                if(touristSite.id == "Self"){
                  return Marker(
                      infoWindow:  InfoWindow(
                          title: touristSite.name,
                          snippet: touristSite.description
                      ),
                      markerId:  MarkerId(touristSite.id ?? ""),
                      position: touristSite.latLngLocation ?? const LatLng(0, 0),
                      icon: BitmapDescriptor.defaultMarker


                    // icon: await  BitmapDescriptor.fromAssetImage(
                    //     const ImageConfiguration(),
                    //     "assets/tourist.jpg"
                    // ),
                  );
                }
                return Marker(
                  onTap: (){
                    print(touristSite.latLngLocation?.latitude);
                    print(touristSite.latLngLocation?.longitude);

                  },
                  infoWindow:  InfoWindow(
                      title: touristSite.name,
                      snippet: touristSite.description
                  ),
                  markerId:  MarkerId(touristSite.id ?? ""),
                  position: touristSite.latLngLocation ?? const LatLng(0, 0),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta
                  ),

                  // icon: await  BitmapDescriptor.fromAssetImage(
                  //     const ImageConfiguration(),
                  //     "assets/tourist.jpg"
                  // ),
                );

              }).toSet(),








              // markers: _tappedLocation != null
              //     ? {
              //   Marker(
              //     markerId: const MarkerId('tappedMarker'),
              //     position: _tappedLocation!,
              //     icon: BitmapDescriptor.defaultMarker,
              //   ),
              //   ..._markers,
              // }
              //     : _markers,
              // polylines: polylines,
              polylines: {
                const Polyline(polylineId: PolylineId("1"), points: [LatLng(7.67184, -1.96014), LatLng(7.668520000000001,-1.961)],width: 1),
                const Polyline(polylineId: PolylineId("2"), points: [LatLng(7.668520000000001,-1.961), LatLng(7.637750000000003,-1.9137499999999996)], width: 1),
                const Polyline(polylineId: PolylineId("3"), points: [LatLng(7.637750000000003,-1.9137499999999996), LatLng(7.638010000000003,-1.9095099999999998)], width: 1),
                const Polyline(polylineId: PolylineId("4"), points: [LatLng(7.638010000000003,-1.9095099999999998), LatLng(7.6620500000000025,-1.8123499999999986)], width: 1),
              },
              onMapCreated: (controller) async {


                _mapController = controller;




                // _setCameraToUserLocation(
                //     Position(
                //       latitude: _initialCameraPosition.latitude,
                //       longitude: _initialCameraPosition.longitude,
                //       timestamp: null,
                //       accuracy: 20,
                //       altitude: 0,
                //       heading: 12,
                //       speed: 50,
                //       speedAccuracy: 20,
                //     )
                // );
              },
              onCameraMove: (position) {
                _currentZoom = position.zoom;
              },
              onTap: (LatLng tappedPoint) async {


                await route.drawRoute(points, 'Test routes',
                    const Color.fromRGBO(255, 0, 0, 1.0), googleApiKey,
                    travelMode: TravelModes.driving
                );
                print("points: ${route.routes.toList()[0].points}");
                // setState(() {
                //   totalDistance =
                //       distanceCalculator.calculateRouteDistance(points, decimals: 1);
                // });

                print(tappedPoint.latitude);
                print(tappedPoint.longitude);


                // setState(() {
                //   _tappedLocation = tappedPoint;
                //   _destinationLocation = tappedPoint; // Set tapped location as destination
                //   _addDestinationMarkers();
                // });
              },
            );
          }

          print("he");

          return const Center(child: CircularProgressIndicator(color: Colors.green,),);
        }
      )



    );




























    // return BackdropScaffold(
    //   appBar: BackdropAppBar(
    //     title: const Text("Backdrop Example"),
    //     actions: const <Widget>[
    //       BackdropToggleButton(
    //
    //         icon: AnimatedIcons.ellipsis_search,
    //
    //       )
    //     ],
    //   ),
    //   drawer: SideBarMenu(user: widget.user,),
    //   backLayer:  Center(
    //     child: FlutterMap(
    //       options: MapOptions(
    //         center: LatLng(7.333332, -2.333332),
    //
    //         zoom: 13,
    //       ),
    //       nonRotatedChildren: [
    //         // RichAttributionWidget(
    //         //   attributions: [
    //         //     TextSourceAttribution(
    //         //       'OpenStreetMap contributors',
    //         //       onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
    //         //     ),
    //         //   ],
    //         // ),
    //       ],
    //       children: [
    //         TileLayer(
    //           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //           userAgentPackageName: 'com.example.app',
    //         ),
    //       ],
    //     ),
    //   ),
    //   frontLayer:  FlutterMap(
    //     options: MapOptions(
    //       center: LatLng(7.333332, -2.333332),
    //
    //       zoom: 17,
    //     ),
    //     nonRotatedChildren: const [
    //       // RichAttributionWidget(
    //       //   attributions: [
    //       //     TextSourceAttribution(
    //       //       'OpenStreetMap contributors',
    //       //       onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
    //       //     ),
    //       //   ],
    //       // ),
    //     ],
    //     children: [
    //       TileLayer(
    //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //         userAgentPackageName: 'com.example.app',
    //       ),
    //     ],
    //   ),
    // );
  }




}


// Future<void> _drawPolylines(LatLng from, LatLng to) async{
//       Polyline polyline = await polylineService().drawPolyline(from, to)
//
//
//           _polylines.add(polyline);
//
//           _getCurrentLocation(from);
//           _setMarker(to);
//
//           setState(){};
// }




