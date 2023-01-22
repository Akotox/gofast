import 'dart:math';
import 'package:gofast/exports/export_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class Logix {
  getPickup(String location) async {
    final pickupCods = GetStorage();
    var url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$location&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data);
      var latitude = data["results"][0]["geometry"]["location"]["lat"];
      var longitude = data["results"][0]["geometry"]["location"]["lng"];

      pickupCods.write('lat1', latitude);
      pickupCods.write('lon1', longitude);

      print("latitude is  ${pickupCods.read("lat1") ?? "N/A"}");
      print("longitude is  ${pickupCods.read("lon1") ?? "N/A"}");
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  getDestination(String location) async {
    final destinationCods = GetStorage();

    var url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$location&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data);
      var latitude = data["results"][0]["geometry"]["location"]["lat"];
      var longitude = data["results"][0]["geometry"]["location"]["lng"];
      destinationCods.write('lat2', latitude);
      destinationCods.write('lon2', longitude);

      print("latitude is  ${destinationCods.read("lat2") ?? "N/A"}");
      print("longitude is  ${destinationCods.read("lon2") ?? "N/A"}");
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  double getDistance(double lat1, double lon1, double lat2, double lon2) {
    final distance = GetStorage();

    const double earthRadius = 6371; // in kilometers

    var dLat = (lat2 - lat1) * pi / 180;
    var dLon = (lon2 - lon1) * pi / 180;
    lat1 = lat1 * pi / 180;
    lat2 = lat2 * pi / 180;

    var a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = earthRadius * c;

    distance.write('distance', d);
    print("Your distance is ${distance.read("distance")}");

    return d;
  }

  double rate = 0.5;

  double calculatePrice(double distance, double rate) {
    return distance * rate;
  }

  clearData() {
    final data = GetStorage();
    data.erase();
  }
}
