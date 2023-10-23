import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapme2/custom_widgets/drawer.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../custom_widgets/button_navigation.dart';
import '../model/tourist_location.dart';
import '../model/user.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'aStar.dart';








class MyMapWidget2 extends StatefulWidget {
  final User user;

  final List<TouristSite> touristSites;
  final TouristSite? selectedLocation;
  const MyMapWidget2({super.key, required this.touristSites, required this.user, this.selectedLocation});

  @override
  _MyMapWidget2State createState() => _MyMapWidget2State();
}

class _MyMapWidget2State extends State<MyMapWidget2> with OSMMixinObserver {
  final MapController mapController = MapController(
    initPosition: GeoPoint(latitude: 7.3349, longitude: -2.3123),

  );

  double distanceCar = 0;
  // double distanceBike = 0;
  GeoPoint? userPosition;


  // final mapController = MapController.withUserPosition(
  //     trackUserLocation: const UserTrackingOption(
  //       enableTracking: true,
  //       unFollowUser: false,
  //     )
  // );

  GeoPoint? tappedLocation; // Store the tapped location here
  GeoPoint? selectedPlace;


  @override
  void initState() {
    super.initState();
    mapController.addObserver(this);
    // Add this state as the observer
  }
  @override
  void dispose (){
    super.dispose();
    mapController.dispose();


  }

  void zoomIn() async {
    double currentZoom = await mapController.getZoom();
    await mapController.setZoom(zoomLevel: currentZoom + 1);
  }

  void zoomOut() async {
    double currentZoom = await mapController.getZoom();
    await mapController.setZoom(zoomLevel: currentZoom - 1);
  }

  drawPolylines() async {
    userPosition = await mapController.myLocation();
    if (userPosition != null) {
      print(selectedPlace?.latitude);
      print(selectedPlace?.longitude);

      RoadInfo roadInfo1 = await mapController.drawRoad(
        userPosition ?? GeoPoint(latitude: 0, longitude: 0),
        selectedPlace!,
        roadType: RoadType.car,
        roadOption: const RoadOption(
          roadColor: Colors.black,
          roadWidth: 15.0,
        ),
      );

      RoadInfo roadInfo2 = await mapController.drawRoad(
        userPosition ?? GeoPoint(latitude: 0, longitude: 0),
        selectedPlace!,
        roadType: RoadType.bike,
        roadOption: const RoadOption(
          roadColor: Colors.red,
          roadWidth: 15.0,
        ),
      );




      //  distanceBike = calculateHScore(
      //     LatLng(userPosition.latitude, userPosition.longitude),
      //     LatLng(selectedPlace!.latitude, selectedPlace!.longitude)
      // );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text('Distance to AStar Destination: ${distanceCar.toStringAsFixed(2)} km'),
      //         Text('Distance to Djistrak Destination: ${distanceBike.toStringAsFixed(2)} km'),
      //       ],
      //     ),
      //   ),
      // );
    }
  }


  void addStaticMarkers() async {

    List<GeoPoint> staticMarkers = [

    ];

    for (int i = 0; i < widget.touristSites.length; i++) {
      await mapController.addMarker(

        GeoPoint(
            latitude: widget.touristSites[i].latLngLocation!.latitude,
            longitude: widget.touristSites[i].latLngLocation!.longitude
        ),
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.place,
            color: Colors.blue,
            size: 80,
          ),
        ),
      );
    }
  }


  @override


  void onTappLong(GeoPoint tappedLocation) async {
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;

    // Get the tap position
    final tapPosition = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        const Offset(0, 0) & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'item1',
          child: Text('Set Destination'), // You can use a unique value to identify the selected item
        ),
        const PopupMenuItem(
          value: 'item2',
          child: Text('Add Location point of intrest'),
        ),
        const PopupMenuItem(
          value: 'item3',
          child: Text(''),
        ),
      ],
    );

    // Handle the selected item
    if (tapPosition != null) {
      if (tapPosition == 'item1') {
        // Handle item 1
      } else if (tapPosition == 'item2') {
        // Handle item 2
      } else if (tapPosition == 'item3') {
        // Handle item 3
      }
    }
  }


  void onMapTapped() async {
    tappedLocation = mapController.listenerMapSingleTapping.value;
    // print(tappedLocation?.latitude);
    // if (tappedLocation != null) {
    //   // Add a marker at the tapped location
    //   await mapController.addMarker(
    //     tappedLocation!,
    //     markerIcon: const MarkerIcon(
    //       icon: Icon(
    //         Icons.place,
    //         color: Colors.red,
    //         size: 80,
    //       ),
    //     ),
    //   );
    //
    //
    //
    //
    //     destinationPoint1 = tappedLocation;
    //     destinationPoint2 = tappedLocation;
    //
    //
    //
    //   drawPolylines();
    // }
    print("jieiafjiejfjjawijfije");
    _showSearchDialog();
  }


  Future<void> _showSearchDialog() async {
    print("ehill");
    OpenStreetMapSearchAndPick(
      buttonTextStyle:
      const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
      center: const LatLong(23, 89),
      buttonColor: Colors.blue,
      buttonText: 'Set Current Location',
      onPicked: (pickedData) {
        print(pickedData.latLong.latitude);
        print(pickedData.latLong.longitude);
        print(pickedData.address);
        print(pickedData.addressName);
      },
      // onGetCurrentLocationPressed: locationService.getPosition,
    );
  }

  Future<void> load() async {
    print("ehill");

  }




  @override
  Future<void> mapIsReady(bool isReady) async {
    // TODO: implement mapIsReady
    // throw UnimplementedError();


  }



  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: AppBar(


      ),
      drawer: SideBarMenu(user: widget.user, touristSites: widget.touristSites,),



      body: SlidingUpPanel(


        renderPanelSheet: widget.selectedLocation == null ? false: true,

        panel: widget.selectedLocation != null ? Container(

          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.selectedLocation?.name ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 20),

                    FutureBuilder(
                        future: loadDistance(),
                        builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return Text(
                            "${distanceCar.toStringAsFixed(2)}Km",

                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        return const Center(child: CircularProgressIndicator(),);
                      }
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      widget.selectedLocation?.location ?? 'Location not available',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),


                    ),

                  ],
                ),
                const SizedBox(height: 16.0),

                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,  // Adjust the number of columns as needed
                    ),
                    itemCount: widget.selectedLocation?.pictures?.length ?? 0,
                    itemBuilder: (context, index) {
                      final pictureUrl = widget.selectedLocation?.pictures?[index];
                      return GestureDetector(
                        onTap: () {
                          // Handle tapping on a picture, e.g., show it in a larger view
                        },
                        child: Image.network(
                          pictureUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16.0),
                Text(
                  widget.selectedLocation?.description ?? 'Description not available',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black
                  ),
                ),
                const SizedBox(height: 16.0),
                // You can add more widgets to display other information here
              ],
            ),
          ),
        ): Container(),






        body: OSMFlutter(
          androidHotReloadSupport: true,
          mapIsLoading: const Center(child: CircularProgressIndicator(color: Colors.green,)),
          onMapIsReady: (isReady) async {

            print("ready");


            if (isReady) {
              await mapController.enableTracking();
              // Add tap listener to the map
              mapController.listenerMapSingleTapping.addListener(onMapTapped);
              mapController.listenerMapLongTapping.addListener(() {

              });

              addStaticMarkers();
              // _showSearchDialog();

              if(widget.selectedLocation != null){

                selectedPlace = GeoPoint(
                    latitude: widget.selectedLocation!.latLngLocation!.latitude,
                    longitude: widget.selectedLocation!.latLngLocation!.longitude
                );


                await drawPolylines();


              }


            }

          },

          onGeoPointClicked: (geoPoint) async {
            // selectedPlace = GeoPoint(latitude: geoPoint.latitude, longitude: geoPoint.longitude);
            // await drawPolylines();
            // setState(() {
            //
            // });

          },
          onLocationChanged: (location){
            print("hello");
            print("eieii: ${location.latitude}");
            print(location.longitude);
          },
          controller: mapController,
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: true,

          ),

          enableRotationByGesture: true,
          initZoom: 9,
          // maxZoomLevel: 17,
          // minZoomLevel: 7,

          staticPoints: const [

          ],



          // Leave this empty since we add static markers in mapIsReady

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
          roadConfiguration: const RoadOption(roadColor: Colors.yellow),

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
      // bottomNavigationBar: ButtonNav(user: widget.user, onTabSelected: (index) { 0; },),
    );
  }

  Future loadDistance() async{


    // await Future.delayed(const Duration(seconds: 10), () async {
    //
    // });

    userPosition = await mapController.myLocation();

    print("foihaiheifiaewhfihah: $userPosition");

    userPosition = await mapController.myLocation();
    print("foihaiheifiaewhfihah: $userPosition");

    distanceCar = calculateHScore(
        LatLng(userPosition!.latitude, userPosition!.longitude),
        LatLng(selectedPlace!.latitude, selectedPlace!.longitude)
    );



    // return distanceCar;



  }








}