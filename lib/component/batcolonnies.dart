import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:latlong2/latlong.dart';

import '../custom_widgets/button_navigation.dart';
import '../custom_widgets/drawer.dart';
import '../model/user.dart';
import 'aStar.dart';

class CocoaHouse extends StatefulWidget {
  final User user;
  const CocoaHouse({Key? key, required this.user}) : super(key: key);

  @override
  State<CocoaHouse> createState() => _CocoaHouseState();
}

class _CocoaHouseState extends State<CocoaHouse> with OSMMixinObserver {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  final MapController mapController = MapController.withPosition(
    initPosition:
        GeoPoint(latitude:7.671981402814556, longitude:  -1.9604018868164614),
    areaLimit: BoundingBox(
      east: 1.199041,
      north: 11.118361,
      south: 4.737284,
      west: -3.255425,
    ),
  );

  GeoPoint? destinationPoint1 = GeoPoint(latitude:7.671981402814556, longitude:  -1.9604018868164614);

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
        roadOption: RoadOption(
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
          duration: Duration(seconds: 70), // Set a long duration for the SnackBar
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
  void addStaticMarkers() async {
    List<GeoPoint> staticMarkers = [
      GeoPoint(latitude:7.671981402814556, longitude:  -1.9604018868164614),
    ];

    for (GeoPoint markerLocation in staticMarkers) {
      await mapController.addMarker(
        markerLocation,
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.place,
            color: Colors.blue,
            size: 80,
          ),
        ),
      );
    }
  }
  void onMapTapped() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Details"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Location Name: Boabeng Fiema"),
                Text("Description:The grove contains a diverse fauna including a large colony of fruit bats where over 20,000 roost in a series of underground caves. "
                    "Rodent and avifauna are high in numbers and typical of such transitional vegetation that offers varied habitats for both forest and grassland species."
                    "The grove dates back to the 14th century when it was established initially to protect the bats, which were food for the traditional authorities (stool)."
                    "The grove still serves this purpose today and so the forest has been preserved though not in its original condition. "),
                SizedBox(height: 10),
                Text("Photos:"),
                SizedBox(height: 5),
                Image.network("https://www.theghanahit.com/wp-content/uploads/2021/11/abb1cb293f3b3dff67442aefc432458b.jpg"),
                SizedBox(height: 5),
                Image.network("https://scontent.facc5-1.fna.fbcdn.net/v/t1.18169-9/14449988_310939679274862_2399671696422038871_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=730e14&_nc_ohc=YTFrgwNRxuoAX-U_Fad&_nc_ht=scontent.facc5-1.fna&oh=00_AfCV-M6bEGT4uL8tCvWfOe-jPrx-el4jyEsrAn-7r5NQKA&oe=64FB88C0"),
                SizedBox(height: 5),
                Image.network("https://visitghana.com/wp-content/uploads/2019/02/3908_Stephenson_Buoyem_IMG_9506.jpg"),
                SizedBox(height: 5),
                Image.network("https://ghanaportals.com/wp-content/uploads/2021/07/70257f1fce634e763e5e32edfaca199d-225x300.jpg"),
                SizedBox(height: 5),
                Image.network("https://scontent.facc5-1.fna.fbcdn.net/v/t1.18169-9/14485146_310939669274863_89713090261499656_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=730e14&_nc_ohc=5DkVCVLDljEAX9F3U4f&_nc_ht=scontent.facc5-1.fna&oh=00_AfDXf3PIwtunqL9PLcRmVPwHICm1UH7n5bQGo3MVfuqZFA&oe=64FBA8B5"),
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
              controller: mapController,
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
                    size: 100,
                  ),
                ),
                directionArrowMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.person_pin_circle,
                    color: Colors.black,
                    size: 100,
                  ),
                ),
              ),
            ),
            drawer:  SideBarMenu(user: widget.user, touristSites: [],),
            bottomNavigationBar: ButtonNav(
              user: widget.user,
              onTabSelected: (index) {
                initialIndex:
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