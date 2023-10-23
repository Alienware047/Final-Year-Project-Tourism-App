// import 'package:flutter/material.dart';
// import 'package:mapme2/component/bui.dart';
// import 'package:mapme2/component/batcolonnies.dart';
// import 'package:mapme2/component/digya.dart';
// import 'package:mapme2/component/fuller.dart';
// import 'package:mapme2/component/kintampo.dart';
// import 'package:mapme2/page/pointofintrest.dart';
// import '../component/bonomanso.dart';
// import '../component/fiema.dart';
// import '../model/user.dart';
// import '/custom_widgets/button_navigation.dart';
// import '/custom_widgets/drawer.dart';
//
// class Tourist extends StatefulWidget {
//   final User user;
//   const Tourist({Key? key, required this.user}) : super(key: key);
//
//   @override
//   State<Tourist> createState() => _TouristState();
// }
//
// class _TouristState extends State<Tourist> {
//   List<ListTile> listTiles = [];
//
//   void _addNewLocation(String name, String description, String address) {
//     final newTile = ListTile(
//       leading: const Icon(Icons.location_city),
//       title: Text(name),
//       subtitle: Text(description),
//       trailing: GestureDetector(
//         child: const Icon(Icons.delete),
//
//         onLongPress: () {
//         // You can handle the onTap event for the newly added ListTile here if needed.
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => NewPoint(
//               // Pass the _addNewLocation method as the onSubmit callback
//               onSubmit: (name, description, location) {
//                 _addNewLocation(name, description, location);
//               },
//             ),
//           ),
//         );
//       },
//       ),
//       onTap: (){
//
//       },
//     );
//
//     setState(() {
//       listTiles.insert(7, newTile);
//     });
//   }
//
//   void _deleteLocation(ListTile tile) {
//     setState(() {
//       listTiles.remove(tile);
//     });
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the listTiles with some initial data
//     listTiles = [
//       // ... Add your initial ListTiles here ...
//       const ListTile(
//         title: Text(' Bono, Bono East and Ahafo regions'),
//         subtitle: Text('Tourist Sites In All the Region'),
//       ),
//       ListTile(
//         leading: const Icon(Icons.location_city),
//         title: const Text('Boabeng Fiema Monkey Sanctuary'),
//         subtitle: const Text('Boabeng Fiema'),
//         trailing: const Icon(Icons.location_searching),
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context)=>Fiema(user: widget.user,)));
//         },
//       ),
//       ListTile(
//         leading: const Icon(Icons.location_city),
//         title: const Text('Digya National Park'),
//         subtitle: const Text('Digya'),
//         trailing: const Icon(Icons.location_searching),
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context)=>Digya(user: widget.user)));
//         },
//       ),
//       ListTile(
//         leading: const Icon(Icons.location_city),
//         title: const Text('Fuller Falls'),
//         subtitle: const Text('Yabraso'),
//         trailing: const Icon(Icons.location_searching),
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context)=>Fuller(user: widget.user,)));
//         },
//       ),
//       ListTile(
//         leading: const Icon(Icons.location_city),
//         title: const Text('Kintampo Waterfalls'),
//         subtitle: const Text('Kintampo'),
//         trailing: const Icon(Icons.location_searching),
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context)=>Kintampo(user: widget.user,)));
//         },
//       ),
//       ListTile(
//         leading: const Icon(Icons.location_city),
//         title: const Text('Bui National Park'),
//         subtitle: const Text('Bui '),
//         trailing: const Icon(Icons.location_searching),
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context)=>Bui(user: widget.user,)));
//         },
//       ),
//
//       ListTile(
//         leading: const Icon(Icons.location_city),
//         title: const Text('Buoyem Caves and Bats Colony'),
//         subtitle: const Text('Sunyani '),
//         trailing: const Icon(Icons.location_searching),
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context)=>CocoaHouse(user: widget.user,)));
//         },
//       ),
//       ListTile(
//         leading: const Icon(Icons.location_city),
//         title: const Text('Bono Manso Slave Market'),
//         subtitle: const Text('Bono Manso'),
//         trailing: const Icon(Icons.location_searching),
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context)=>BonoManso(user: widget.user,)));
//         },
//       ),
//       // const ListTile(
//       //   title: Text('Point Of Interest'),
//       //   subtitle: Text('New Or Interesting Place You May Add'),
//       // ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('MapMe'),
//           titleTextStyle: const TextStyle(color: Colors.white),
//           backgroundColor: Colors.lightGreen,
//         ),
//         drawer:  SideBarMenu(user: widget.user,),
//         bottomNavigationBar: ButtonNav(user: widget.user, onTabSelected: (index) {  1;},),
//         body: SafeArea(
//           child: InkWell(
//             onTap: () {},
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white60,
//               ),
//               child: ListView(
//                 itemExtent: 100,
//                 reverse: false,
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 children: [
//                   // ListTile(
//                   //   leading: const Icon(Icons.add_location),
//                   //   title: const Text('Add A New Location'),
//                   //   subtitle: const Text('Add any Tourist Site or Point Of Interest'),
//                   //   trailing: const Icon(Icons.add),
//                   //   onTap: () {
//                   //     // Navigate to the NewPoint screen to add a new location
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (context) => NewPoint(
//                   //           // Pass the _addNewLocation method as the onSubmit callback
//                   //           onSubmit: _addNewLocation,
//                   //         ),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                   // Add the listTiles to the ListView here
//                   ...listTiles,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
