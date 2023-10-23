import 'package:flutter/material.dart';

import '../component/constants.dart';
import '../component/mymapwiget2.dart';
import '../custom_widgets/mymapwiget.dart';
import '../custom_widgets/button_navigation.dart';
import '../custom_widgets/drawer.dart';
import '../custom_widgets/mymapwiget.dart';
import '../model/user.dart';


// import '../component/mymapwiget.dart';


class HomePag extends StatefulWidget {
  final User user;
  const HomePag({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePag> createState() => _HomePagState();
}

class _HomePagState extends State<HomePag> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('MapMe'),
              titleTextStyle: const TextStyle(color: Colors.white),
              backgroundColor:Colors.lightGreen,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Perform search functionality here
                  },
                ),
              ],
            ),
            // body:  MyMapWidget(user: widget.user,),
            drawer:  SideBarMenu(user: widget.user, touristSites: [],),
            bottomNavigationBar: ButtonNav(
                user: widget.user,
              onTabSelected: (index) {
                initialIndex :
                0;
              },
              // )
            )
        )
    );
  }
}
