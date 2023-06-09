// To parse this JSON data, do
//
//     final vmVenueDataModel = vmVenueDataModelFromJson(jsonString);

import 'dart:convert';

List<VmVenueDataModel> vmVenueDataModelFromJson(List<dynamic> str) =>
    List<VmVenueDataModel>.from(
        str.map((x) => VmVenueDataModel.fromJson(x)));

String vmVenueDataModelToJson(List<VmVenueDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VmVenueDataModel {
  VmVenueDataModel({
    this.id,
    this.vmId,
    this.venueName,
    this.mobile,
    this.district,
    this.place,
    this.actualPrice,
    this.discountPercentage,
    this.description,
    this.image,
    this.document,
    this.slots,
    this.sportFacility,
    this.lat,
    this.lng,
    this.isBlocked,
    this.vmIsBlocked,
    this.approved,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? vmId;
  String? venueName;
  int? mobile;
  String? district;
  String? place;
  int? actualPrice;
  int? discountPercentage;
  String? description;
  String? image;
  String? document;
  List<Slot>? slots;
  List<VmSportFacility>? sportFacility;
  double? lat;
  double? lng;
  bool? isBlocked;
  bool? vmIsBlocked;
  bool? approved;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory VmVenueDataModel.fromJson(Map<String, dynamic> json) =>
      VmVenueDataModel(
        id: json["_id"],
        vmId: json["vmId"],
        venueName: json["venueName"],
        mobile: json["mobile"],
        district: json["district"],
        place: json["place"],
        actualPrice: json["actualPrice"],
        discountPercentage: json["discountPercentage"],
        description: json["description"],
        image: json["image"],
        document: json["document"],
        slots: json["slots"] == null
            ? []
            : List<Slot>.from(json["slots"]!.map((x) => Slot.fromJson(x))),
        sportFacility: json["sportFacility"] == null
            ? []
            : List<VmSportFacility>.from(
                json["sportFacility"]!.map((x) => VmSportFacility.fromJson(x))),
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        isBlocked: json["isBlocked"],
        vmIsBlocked: json["vmIsBlocked"],
        approved: json["approved"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vmId": vmId,
        "venueName": venueName,
        "mobile": mobile,
        "district": district,
        "place": place,
        "actualPrice": actualPrice,
        "discountPercentage": discountPercentage,
        "description": description,
        "image": image,
        "document": document,
        "slots": slots == null
            ? []
            : List<dynamic>.from(slots!.map((x) => x.toJson())),
        "sportFacility": sportFacility == null
            ? []
            : List<dynamic>.from(sportFacility!.map((x) => x.toJson())),
        "lat": lat,
        "lng": lng,
        "isBlocked": isBlocked,
        "vmIsBlocked": vmIsBlocked,
        "approved": approved,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Slot {
  Slot({
    this.day,
    this.slots,
  });

  String? day;
  List<String>? slots;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        day: json["day"],
        slots: json["slots"] == null
            ? []
            : List<String>.from(json["slots"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "slots": slots == null ? [] : List<dynamic>.from(slots!.map((x) => x)),
      };
}

class VmSportFacility {
  VmSportFacility({
    this.sportId,
    this.sport,
    this.facility,
    this.id,
  });

  String? sportId;
  String? sport;
  String? facility;
  String? id;

  factory VmSportFacility.fromJson(Map<String, dynamic> json) => VmSportFacility(
        sportId: json["sportId"],
        sport: json["sport"],
        facility: json["facility"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "sportId": sportId,
        "sport": sport,
        "facility": facility,
        "_id": id,
      };
}
