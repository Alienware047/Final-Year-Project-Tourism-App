import 'package:flutter/material.dart';
import '../component/mymapwiget2.dart';
import '../model/user.dart';
import '/page/tourist_page.dart';
import '/page/homepage.dart';

class ButtonNav extends StatefulWidget {
  final User user;
  const ButtonNav({Key? key,required this.user,required Null Function(dynamic index) onTabSelected}) : super(key: key);

  @override
  State<ButtonNav> createState() => _ButtonNavState();
}

class _ButtonNavState extends State<ButtonNav> {
  @override
  Widget build(BuildContext context) {
    return
         BottomAppBar(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context)=> MyMapWidget2(user: widget.user, touristSites: [],)


                          )
                      );

                    },
                    icon: const Icon(Icons.home),
                    style: const ButtonStyle(
                    ),

                  ),
                ),
              ),

              
              Expanded(
                child: Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context)=> Tourist(user: widget.user,)
                      //
                      //     )
                      // );

                    },
                    icon: const Icon(Icons.location_on_rounded, ),

                  ),
                ),
              )
            ],
          ),
        );

  }
}
