import 'dart:convert';

LariDetailModel lariDetailModelFromJson(String str) =>
    LariDetailModel.fromJson(json.decode(str));

String lariDetailModelToJson(LariDetailModel data) =>
    json.encode(data.toJson());

class LariDetailModel {
  int id;
  int lariId;
  double latitude;
  double longitude;
  String waktu;

  LariDetailModel({
    required this.id,
    required this.lariId,
    required this.latitude,
    required this.longitude,
    required this.waktu,
  });

  factory LariDetailModel.fromJson(Map<String, dynamic> json) =>
      LariDetailModel(
        id: json["id"],
        lariId: json["lari_id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        waktu: json["waktu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lari_id": lariId,
        "latitude": latitude,
        "longitude": longitude,
        "waktu": waktu,
      };
}
