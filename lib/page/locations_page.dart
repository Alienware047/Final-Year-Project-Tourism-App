
import 'package:flutter/Material.dart';

import '../component/mymapwiget2.dart';
import '../model/tourist_location.dart';
import '../model/user.dart';

class TouristSiteListPage extends StatefulWidget {

  final List<TouristSite> touristSites;
  final User user;


  TouristSiteListPage({super.key, required this.touristSites, required this.user});

  @override
  State<TouristSiteListPage> createState() => _TouristSiteListPageState();
}

class _TouristSiteListPageState extends State<TouristSiteListPage> {
  TouristSite? selectedLocation;
  List<TouristSite> searchedTouristSites = [];
  List<TouristSite> touristSitesTobeDisplayed = [];


  bool isSearching = false;
  String query = "";



  @override
  Widget build(BuildContext context) {

    if(query.isEmpty) {
      touristSitesTobeDisplayed = widget.touristSites;
    }else{
      touristSitesTobeDisplayed = searchedTouristSites;

    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        actions: [
          IconButton(
              onPressed: (){
                isSearching = true;
                setState((){

                });
              }, icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          isSearching?  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(


              onChanged: (value){

                query = value;

                searchedTouristSites = TouristSite.fuzzySearchTouristSitesByName(widget.touristSites, query);
                setState(() {

                });

              },
              decoration: const InputDecoration(
                  hintText: "search"
              ),

            ),
          ): Container(),
          Expanded(
            child: ListView.builder(
              itemCount: touristSitesTobeDisplayed.length,
              itemBuilder: (context, index) {
                final site = touristSitesTobeDisplayed[index];
                print("ifhuheua: ${site.pictures?[0]}");
                return InkWell(

                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    // child: ListTile(
                    //   leading: Image.network(
                    //     site.pictures?[0].isEmpty || site.pictures?[0] == null
                    //         ? 'https://w7.pngwing.com/pngs/563/542/png-transparent-arecaceae-silhouette-travel-tourist-attractions-set-isolated-illustration-icon-leaf-branch-world-thumbnail.png'
                    //         : site.pictures?[0],
                    //     errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    //       return const Text('😢');
                    //     },
                    //   ),
                    //   title: Text(site.name ?? ''),
                    //   subtitle: Text(site.location ?? ''),
                    //   trailing: const Icon(Icons.arrow_forward),
                    // ),

                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            site.pictures?[0].isEmpty || site.pictures?[0] == null
                                ? 'https://w7.pngwing.com/pngs/563/542/png-transparent-arecaceae-silhouette-travel-tourist-attractions-set-isolated-illustration-icon-leaf-branch-world-thumbnail.png'
                                : site.pictures?[0],
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return const Text('😢');
                            },
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          site.name ?? '',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 4.0),
                            Text(
                              site.location ?? '',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              site.description ?? '',
                              style: const TextStyle(
                                fontSize: 14.0,
                                // color: Colors.grey[800],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          selectedLocation = touristSitesTobeDisplayed[index];
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>  MyMapWidget2(touristSites: widget.touristSites, user: widget.user, selectedLocation: selectedLocation,)),
                          );
                          // Handle tapping on a tourist site, e.g., navigate to site details page.
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
