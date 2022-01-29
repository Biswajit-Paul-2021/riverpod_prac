// To parse this JSON data, do
//
//     final planeDetails = planeDetailsFromJson(jsonString);

import 'dart:convert';

PlaneDetails planeDetailsFromJson(String str) =>
    PlaneDetails.fromJson(json.decode(str));

String planeDetailsToJson(PlaneDetails data) => json.encode(data.toJson());

class PlaneDetails {
  PlaneDetails({
    required this.totalPassengers,
    required this.totalPages,
    required this.data,
  });

  final int totalPassengers;
  final int totalPages;
  final List<Datum>? data;

  factory PlaneDetails.fromJson(Map<String, dynamic> json) => PlaneDetails(
        totalPassengers: json["totalPassengers"],
        totalPages: json["totalPages"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalPassengers": totalPassengers,
        "totalPages": totalPages,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.trips,
    this.airline,
    this.v,
  });

  final String? id;
  final String? name;
  final int? trips;
  final List<Airline>? airline;
  final int? v;
  bool isFav = false;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        trips: json["trips"] ?? 0,
        airline: json["airline"] == null
            ? null
            : List<Airline>.from(
                json["airline"].map((x) => Airline.fromJson(x))),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "trips": trips,
        "airline": airline == null
            ? null
            : List<dynamic>.from(airline!.map((x) => x.toJson())),
        "__v": v,
      };
}

class Airline {
  Airline({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.slogan,
    this.headQuaters,
    this.website,
    this.established,
  });

  final int? id;
  final String? name;
  final String? country;
  final String? logo;
  final String? slogan;
  final String? headQuaters;
  final String? website;
  final String? established;

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        logo: json["logo"],
        slogan: json["slogan"],
        headQuaters: json["head_quaters"],
        website: json["website"],
        established: json["established"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "logo": logo,
        "slogan": slogan,
        "head_quaters": headQuaters,
        "website": website,
        "established": established,
      };
}
