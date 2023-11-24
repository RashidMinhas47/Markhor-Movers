import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionRepos {
  static const String googleAPIKEY = 'AIzaSyD7rFVdAMLtTs7r6RAc6n3m1KpDoh9cxzw';
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  final Dio _dio;
  DirectionRepos({Dio dio}) : _dio = dio ?? Dio();
  Future<Diretions> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': googleAPIKEY,
    });
    if (response.statusCode == 200) {
      return Direction.fromMap(response.data);
    }
    return null;
  }
}
