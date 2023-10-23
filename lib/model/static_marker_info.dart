import 'package:flutter/Material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:mapme2/model/user.dart';

class StaticMarkerInfo {
  final User user;
  final GeoPoint location;
  final Icon icon;
  final String title;
  final String description;

  StaticMarkerInfo({
    required this.user,
    required this.location,
    required this.icon,
    required this.title,
    required this.description,
  });
}