import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:latlong2/latlong.dart';

import '../custom_widgets/button_navigation.dart';
import '../custom_widgets/drawer.dart';
import 'package:mapme2/component/aStar.dart';

import '../model/user.dart';

class Fuller extends StatefulWidget {
  final User user;
  const Fuller({Key? key, required this.user}) : super(key: key);

  @override
  State<Fuller> createState() => _FullerState();
}

class   _FullerState extends State<Fuller> with OSMMixinObserver {
final MapController mapController = MapController.withPosition(
  initPosition: GeoPoint(latitude: 8.083057322902107, longitude: -1.7970215374290048),
  areaLimit: BoundingBox(
    east: 1.199041,
    north: 11.118361,
    south: 4.737284,
    west: -3.255425,
  ),
);

GeoPoint? destinationPoint1 = GeoPoint(latitude: 8.083057322902107, longitude: -1.7970215374290048);

@override
void initState() {
  super.initState();
  mapController.addObserver(this); // Add this state as the observer
}

void zoomIn() async {
  double currentZoom = await mapController.getZoom();
  await mapController.setZoom(zoomLevel: currentZoom + 1);
}

void zoomOut() async {
  double currentZoom = await mapController.getZoom();
  await mapController.setZoom(zoomLevel: currentZoom - 1);
}
void onMapTappMarker() async {
  GeoPoint userPosition = await mapController.myLocation();
  if (userPosition != null && destinationPoint1 != null) {
    RoadInfo roadInfo1 = await mapController.drawRoad(
      userPosition,
      destinationPoint1!,
      roadType: RoadType.car,
      roadOption: const RoadOption(
        roadColor: Colors.red,
        roadWidth: 15.0,
      ),
    );

    double distanceCar = calculateHScore(
        LatLng(userPosition.latitude, userPosition.longitude),
        LatLng(destinationPoint1!.latitude, destinationPoint1!.longitude)
    );


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Distance to Astar Destination: ${distanceCar.toStringAsFixed(2)} km'),
          ],
        ),
        duration: const Duration(seconds: 70),
      ),
    );

  }
}
@override
Future<void> mapIsReady(bool isReady) async {
  if (isReady) {
    // Add tap listener to the map
    mapController.listenerMapLongTapping.addListener(onMapTapped);
    mapController.listenerMapSingleTapping.addListener(onMapTappMarker);


  }

}
void onMapTapped() async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Location Details"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Fuller Falls"),
              const Text(
                "Fuller Waterfalls are located in a town called Yabraso, 7 km West of Kintampo, Ghana."
                    " They are estimated to be 173 meters above sea level, falling gently over a series of cascades along river Oyoko at Yabraso (tributary of the Black Volta). "
                    "The falls were discovered in 1988 by a Filipino missionary, Rev. Fr."
                  ),
              const SizedBox(height: 10),
              const Text("Photos:"),
              const SizedBox(height: 5),
              Image.network(
                  "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.tripadvisor.com%2FAttraction_Review-g1202766-d10197884-Reviews-Fuller_Falls-Kintampo_Brong_Ahafo_Region.html&psig=AOvVaw3U5RaWKeJcc_57wrlqMtIt&ust=1692041483985000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMCGt6Gu2oADFQAAAAAdAAAAABAE"),
              const SizedBox(height: 5),
              Image.network(
                  "hhttps://upload.wikimedia.org/wikipedia/commons/thumb/4/40/FullerFall.jpg/220px-FullerFall.jpg"),
              const SizedBox(height: 5),
              Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvD3fvV9rmgt1Guik6ZIpJXQv0M86Y6OCYmg&usqp=CAU"),
              const SizedBox(height: 5),
              Image.network(
                  "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.hikingnb.ca%2FTrails%2FFundyEast%2FFundyTrailParkway%2FFullerFalls.html&psig=AOvVaw3U5RaWKeJcc_57wrlqMtIt&ust=1692041483985000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMCGt6Gu2oADFQAAAAAdAAAAABAa"),
              const SizedBox(height: 5),
              Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvD3fvV9rmgt1Guik6ZIpJXQv0M86Y6OCYmg&usqp=CAU"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );

}

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('MapMe'),
              titleTextStyle: const TextStyle(color: Colors.white),
              backgroundColor: Colors.lightGreen,
            ),
            body: OSMFlutter(
              controller:  mapController,
              enableRotationByGesture: true,
              initZoom: 13,
              maxZoomLevel: 17.5,
              minZoomLevel: 10,
              stepZoom: 1.0,
              userLocationMarker: UserLocationMaker(
                personMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.person_pin_circle,
                    color: Colors.black,
                    size: 80,
                  ),
                ),
                directionArrowMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.person_pin_circle,
                    color: Colors.black,
                    size: 80,
                  ),
                ),
              ),
            ),

            drawer:  SideBarMenu(user: widget.user,touristSites: [],),
            bottomNavigationBar: ButtonNav(
              user: widget.user,
              onTabSelected: (index) {
                initialIndex :
                0;
              },
              // )
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              GeoPoint userPosition = await mapController.myLocation();
              if (userPosition != null) {
                mapController.goToLocation(userPosition);
              }
            },
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
            ),
          ),
        ),
    );
  }
}