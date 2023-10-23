import 'package:flutter/material.dart';
class DeveloperInfo extends StatefulWidget {
  const DeveloperInfo({Key? key}) : super(key: key);

  @override
  State<DeveloperInfo> createState() => _DeveloperInfoState();
}

class _DeveloperInfoState extends State<DeveloperInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Developer info',
            ),
          ),
          body: Container(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                itemExtent: 100,
                reverse: false,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: const [
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Bono, Bono East and Ahafo Region'),
                    subtitle: Text('Navigate and find routes between three regions  in Ghana.'),
                ),
                  ListTile(
                    leading: Icon(Icons.map),
                    title: Text('Interactive Map'),
                    subtitle: Text('Explore the various regions, towns, and points of interest in the Sunyani Region.'),
                 ),
                  ListTile(
                    leading: Icon(Icons.directions),
                    title: Text('AStar and Dijkstra Algorithms'),
                    subtitle: Text('Utilize AStar and Dijkstra algorithms to find efficient and optimal routes to tourist sites within the region'),
                  ),
                  ListTile(
                    leading: Icon(Icons.navigation),
                    title: Text('Turn-by-Turn Navigation'),
                    subtitle: Text('Get real-time turn-by-turn instructions during your journey.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('User Preferences'),
                    subtitle: Text('Customize and addd usr location to display as a static marker'),
                    ),
                 ],
            ),
          )
        )
    );
  }
}

