import 'package:flutter/material.dart';
import 'package:mapme2/model/tourist_location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/mymapwiget2.dart';
import '../model/user.dart';
import '../page/deveploperinfo.dart';
import '../page/locations_page.dart';
import '../page/changepassword.dart';
import '/page/about.dart';
import '/page/homepage.dart';
import '/page/settingsmain.dart';
import '/page/login_.dart';

class SideBarMenu extends StatefulWidget {
  final User user;
  final List<TouristSite> touristSites;
  const SideBarMenu({Key? key, required this.user, required this.touristSites}) : super(key: key);

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  bool _loggingOut = false;



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
           UserAccountsDrawerHeader(
            accountName: Text(widget.user.name,
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail:  Text(widget.user.email, style: const TextStyle(color: Colors.white)),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person_3_rounded),
            ),
           decoration: const BoxDecoration(
             image: DecorationImage(
                image: NetworkImage(
                  "https://absurd-hump.000webhostapp.com/picforproject/drawer/Eco-Link%20Over%20The%20Bukit%20Timah%20Expressway%20In%20Singapore.jfif",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  MyMapWidget2(user: widget.user, touristSites: widget.touristSites,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on_sharp),
            title: const Text('Locations'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  TouristSiteListPage(touristSites: widget.touristSites, user: widget.user,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResetPassword(user: widget.user))
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Map'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const AboutMain()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Developer Info'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  const DeveloperInfo()));
            },
          ),
          const SizedBox(
            height: 150,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Log Out'),
            onTap: () async {
              _loggingOut = false;
              setState(() {

              });
              await widget.user.logout();



              Navigator.push(
                context, MaterialPageRoute(builder: (context) =>  Login(user: widget.user,)));


            },
          ),
          // Full-screen overlay when logging out
          if (_loggingOut)
            Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.macro_off_outlined,
                      color: Colors.black,
                      size: 48,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Logging Out...',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
