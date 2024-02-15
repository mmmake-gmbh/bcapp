import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/models/info/campus_info.dart';
import 'package:bildungscampus_app/core/models/info/contact_info.dart';
import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot.dart';
import 'package:bildungscampus_app/core/models/startscreen/tile.dart';

class AppContentV2 {
  AppContentV2({
    required this.tiles,
    required this.parkingLots,
    required this.campusInfo,
    required this.contactInfo,
    required this.externalLinks,
    required this.featureInfo,
    required this.downloadTimeStamp,
  });

  List<TileV2> tiles;
  List<ParkingLot> parkingLots;
  CampusInfoV2 campusInfo;
  ContactInfoV2 contactInfo;
  List<ExternalLink> externalLinks;
  FeatureInfo featureInfo;
  DateTime downloadTimeStamp;

  factory AppContentV2.fromJson(Map<String, dynamic> json) => AppContentV2(
        tiles: List<TileV2>.from(json["tiles"].map((x) => TileV2.fromJson(x))),
        parkingLots: List<ParkingLot>.from(
            json["parkingLots"].map((x) => ParkingLot.fromJson(x))),
        campusInfo: CampusInfoV2.fromJson(json["campusInfos"]),
        contactInfo: ContactInfoV2.fromJson(json["contactInfos"]),
        externalLinks: List<ExternalLink>.from(
            json["externalLinks"].map((x) => ExternalLink.fromJson(x))),
        featureInfo: FeatureInfo.fromJson(json["newFlag"]),
        downloadTimeStamp: DateTime.parse(json["downloadTimeStamp"]),
      );

  Map<String, dynamic> toJson() => {
        "tiles": List<dynamic>.from(tiles.map((x) => x.toJson())),
        "parkingLots": List<dynamic>.from(parkingLots.map((x) => x.toJson())),
        "campusInfos": campusInfo.toJson(),
        "contactInfos": contactInfo.toJson(),
        "externalLinks":
            List<dynamic>.from(externalLinks.map((x) => x.toJson())),
        "newFlag": featureInfo.toJson(),
        "downloadTimeStamp": downloadTimeStamp.toIso8601String(),
      };
}
