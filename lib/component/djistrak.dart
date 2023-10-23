import 'dart:math';
import 'package:latlong2/latlong.dart';

import 'aStar.dart';

class Node {
  final LatLng position;
  List<Node> neighbors;
  double gScore;
  double hScore;
  double fScore;
  Node? parent;

  Node({required this.position})
      : neighbors = [],
        gScore = double.infinity,
        hScore = 0.0,
        fScore = double.infinity,
        parent = null;

  double calculateHScore1(LatLng end) {
    const int earthRadius = 6371; // Radius of the Earth in kilometers
    double lat1 = radians(position.latitude);
    double lon1 = radians(position.longitude);
    double lat2 = radians(end.latitude);
    double lon2 = radians(end.longitude);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }
}

double radians(double degrees) {
  return degrees * pi / 180;
}

List<LatLng> calculateShortestPath(LatLng start, LatLng end) {
  Node startNode = Node(position: start);
  Node endNode = Node(position: end);
  Set<Node> openSet = {startNode};
  Set<Node> closedSet = {};

  startNode.gScore = 0.0;

  while (openSet.isNotEmpty) {
    Node current = openSet.reduce((a, b) => a.fScore < b.fScore ? a : b);

    if (current == endNode) {
      return reconstructPath(current);
    }

    openSet.remove(current);
    closedSet.add(current);

    for (Node neighbor in current.neighbors) {
      if (closedSet.contains(neighbor)) {
        continue;
      }

      double tentativeGScore = current.gScore +
          calculateHScore(current.position, neighbor.position);

      if (!openSet.contains(neighbor)) {
        openSet.add(neighbor);
      } else if (tentativeGScore >= neighbor.gScore) {
        continue;
      }

      neighbor.gScore = tentativeGScore;
      neighbor.hScore = calculateHScore(neighbor.position, endNode.position);
      neighbor.fScore = neighbor.gScore + neighbor.hScore;
      neighbor.parent = current;
    }
  }

  return [];
}

List<LatLng> reconstructPath(Node endNode) {
  List<LatLng> path = [];
  Node? current = endNode;

  while (current != null) {
    path.insert(0, current.position);
    current = current.parent;
  }

  return path;
}
