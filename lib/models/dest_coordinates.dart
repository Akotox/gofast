// To parse this JSON data, do
//
//     final destinationCoord = destinationCoordFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

DestinationCoord destinationCoordFromJson(String str) => DestinationCoord.fromJson(json.decode(str));

String destinationCoordToJson(DestinationCoord data) => json.encode(data.toJson());

class DestinationCoord {
    DestinationCoord({
        required this.results,
    });

    final List<Result> results;

    factory DestinationCoord.fromJson(Map<String, dynamic> json) => DestinationCoord(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.geometry,
    });

    final Geometry geometry;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        geometry: Geometry.fromJson(json["geometry"]),
    );

    Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
    };
}

class Geometry {
    Geometry({
        required this.location,
    });

    final Location location;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
    };
}

class Location {
    Location({
        required this.lat,
        required this.lng,
    });

    final double lat;
    final double lng;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}
