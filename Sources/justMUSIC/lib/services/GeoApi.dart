import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tuple/tuple.dart';

class GeoApi {
  final String apiKey = "85a2724ad38b3994c2b7ebe1d239bbff";
  Future<List<Tuple2<String, String>>?> getNearbyCities() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      bool serviceEnabled;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String apiUrl =
          'http://api.openweathermap.org/data/2.5/find?lat=${position.latitude}&lon=${position.longitude}&cnt=10&appid=$apiKey';
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> cities = data['list'];
        List<Tuple2<String, String>> cityInfo = cities.map((city) {
          String cityName = city['name'] as String;
          String countryName = city['sys']['country'] as String;
          return Tuple2(cityName, countryName);
        }).toList();
        return cityInfo;
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}

class Tuple {}
