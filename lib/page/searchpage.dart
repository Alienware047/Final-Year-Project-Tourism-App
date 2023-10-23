import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with OSMMixinObserver {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  late MapController mapController;

  final TextEditingController searchController = TextEditingController();

  // void searchAndPickLocation() async {
  //   final pickedLocation = await showOpenStreetMapSearchAndPick(
  //     context,
  //     apiKey: "YOUR_OPEN_STREET_MAP_API_KEY", // Replace with your API key
  //   );
  //
  //   if (pickedLocation != null) {
  //     // Set the picked location as the destination
  //     mapController.goToLocation(pickedLocation.geoPoint);
  //   }
  // }
  @override
  void initState() {
    super.initState();
    mapController = MapController(
      initPosition: GeoPoint(latitude: 7.3349, longitude: -2.3123),
      areaLimit: BoundingBox(
        east: 1.199041,
        north: 11.118361,
        south: 4.737284,
        west: -3.255425,
      ),
    );
    initializeMap();
  }

  void initializeMap() async {
    mapController.addObserver(this); // Add this state as the observer

  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      // Add tap listener to the map
      // mapController.listenerMapSingleTapping.addListener(onMapTapped);
      mapController.listenerMapLongTapping.addListener(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    // Implement your search functionality here
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          body: OSMFlutter(
            controller: mapController,
            userTrackingOption: const UserTrackingOption(
              enableTracking: true,
              unFollowUser: true,
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              GeoPoint userPosition = await mapController.myLocation();
              if (userPosition != null) {
                mapController.goToLocation(userPosition);
              }
            },
            backgroundColor: Colors.black, // Set the background color to black.
            child: const Icon(
              Icons.my_location,
              color: Colors.white, // Set the icon color to white.
            ),
          ),
        )
    );
  }


}
