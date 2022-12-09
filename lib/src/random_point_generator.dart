import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng getRandomLocation(LatLng point, int radius) {
  //This is to generate 10 random points
  double x0 = point.latitude;
  double y0 = point.longitude;

  Random random = Random();

  // Convert radius from meters to degrees
  double radiusInDegrees = radius / 111000;

  double u = random.nextDouble();
  double v = random.nextDouble();
  double w = radiusInDegrees * sqrt(u);
  double t = 2 * pi * v;
  double x = w * cos(t);
  double y = w * sin(t) * 1.75;

  // Adjust the x-coordinate for the shrinking of the east-west distances
  double new_x = x / sin(y0);

  double foundLatitude = new_x + x0;
  double foundLongitude = y + y0;
  LatLng randomLatLng = LatLng(foundLatitude, foundLongitude);

  return randomLatLng;
}