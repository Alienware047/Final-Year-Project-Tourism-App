// import 'package:flutter/material.dart';
// // import 'package:mapme2/page/distance.dart';
// // import 'package:mapme2/page/profile.dart';
//
// class SettingsMain extends StatefulWidget {
//   const SettingsMain({Key? key}) : super(key: key);
//
//   @override
//   State<SettingsMain> createState() => _SettingsMainState();
// }
//
// class _SettingsMainState extends State<SettingsMain> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Settings',
//           ),
//           titleTextStyle: TextStyle(
//               color: Colors.white
//           ),
//           backgroundColor: Colors.black,
//
//         ),
//         body: SafeArea(
//             child: InkWell(
//               child: Container(
//                 decoration: const BoxDecoration(color: Colors.white60,),
//                 child: ListView(
//
//                   itemExtent: 50,
//                   reverse: false,
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   children: [
//                     ListTile(
//                       leading: const Icon(Icons.person),
//                       title: const Text(' Profile'),
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context)=>ProfilePage()
//                         ));
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.map_rounded),
//                       title: const Text('Distance Units'),
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context)=>Distance()
//                             ));
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.spatial_tracking),
//                       title: const Text('Location Tracking'),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.gpp_maybe_sharp),
//                       title: const Text('Geolocation Permission'),
//                       onTap: () {},
//                     ),
//
//                   ]
//                   ,
//                 ),
//
//
//               ),
//             )
//
//         )
//
//     );
//   }
//
//
// }
//
