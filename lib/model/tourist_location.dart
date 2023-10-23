import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:string_similarity/string_similarity.dart';

class TouristSite {
  String? id;
  LatLng? latLngLocation;
  String? name;
  String? location;
  String? description;
  List? pictures;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String api = "VBH1QHiceRJpUTQhPJsXoBAiNRnmR4Gc";


  TouristSite({
        this.id,
        this.latLngLocation,
        this.name,
        this.location,
        this.description,
        this.pictures
      });


  static Future getLocations() async {

    FirebaseFirestore db = FirebaseFirestore.instance;
    var locationsQuery = await db.collection("locations").get();


    var docs = locationsQuery.docs;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );


    List<TouristSite> touristSites = [

      // TouristSite(
      //     id: "Self",
      //     name: "Your Location",
      //     latLngLocation: LatLng(position.latitude, position.longitude)
      // )

    ];

    // String api = "VBH1QHiceRJpUTQhPJsXoBAiNRnmR4Gc";
    //
    // String url = "https://www.mapquestapi.com/directions/v2/route?key=$api&from=7.671981402814556,-1.9604018868164614&to=7.554635444565181,-0.21712626880529598&routeType=shortest";
    //
    // var response = await http.get(Uri.parse(url));
    // var data = jsonDecode(response.body);
    //
    // var men = data["route"]['legs'][0]['maneuvers'];

    // List<GeoPoint> points = [];
    // //
    // for (var i = 0; i <men.length; i++){
    //   var man = men[i]['startPoint'];
    //   print(man);
    //   var lat = man["lat"];
    //   var long = man["lng"];
    // //
    // //
    // //   print("${lat}, ${long}");
    //
    //   points.add(GeoPoint(lat, long));
    // //
    // }

    // print(points);





    for (int i = 0; i < docs.length; i++) {


      var long = double.parse(docs[i].data()["longitude"].toString());
      var lat = double.parse(docs[i].data()["latitude"].toString());
      // print(docs[i].data()["pictures"].runtimeType);


      TouristSite touristSite = TouristSite(
          id: docs[i].id,
          name: docs[i].data()["name"] ?? "",
          description: docs[i].data()["description"]?? "",
          pictures: docs[i].data()["pictures"],
          location: docs[i].data()["location"]?? "",
          latLngLocation: LatLng(lat, long)
      );

      // print(long);
      // print("hello");


      touristSites.add(touristSite);
    }
    print("locations: $touristSites");

    print("getteri");


    return touristSites;




  }








// Function to perform a fuzzy search for TouristSites by name
  static fuzzySearchTouristSitesByName(List<TouristSite> sites, String query) {
  // Create a list of TouristSite names
    List<String> siteNames = sites.map((site) => site.name ?? '').toList();
    print(siteNames);

    // Perform the fuzzy search using string_similarity
    // List<String> matchingNames = stringSimilarity.findBestMatch(query, siteNames).bestMatch.map((match) => match.target).toList();
    var matchingNames = query.bestMatch(siteNames).bestMatchIndex;
    print(matchingNames);

    // Extract the matching TouristSite objects based on the names
    List<TouristSite> results = [];
    results.add(sites[matchingNames]);

    return results;
  }




  static Future getRoute({required LatLng? origin, required LatLng? destination}) async {

    String api = "VBH1QHiceRJpUTQhPJsXoBAiNRnmR4Gc";

    String url = "https://www.mapquestapi.com/directions/v2/route?key=$api&from=7.671981402814556,-1.9604018868164614&to=7.554635444565181,-0.21712626880529598&routeType=fastest";

    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);

    var man = data["route"]['legs'][0]['maneuvers'][0]['startPoint'];

    // print("jaij: $man");



  }


}