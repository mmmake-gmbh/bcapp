import 'package:bildungscampus_app/core/models/info/campus_info.dart';
import 'package:bildungscampus_app/core/models/info/contact_info.dart';
import 'package:bildungscampus_app/core/models/info/external_link.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot.dart';
import 'package:bildungscampus_app/core/models/startscreen/tile.dart';

class AppContent {
  AppContent({
    required this.tiles,
    required this.parkingLots,
    required this.campusInfo,
    required this.contactInfo,
    required this.externalLinks,
    required this.downloadTimeStamp,
  });

  List<Tile> tiles;
  List<ParkingLot> parkingLots;
  CampusInfo campusInfo;
  ContactInfo contactInfo;
  List<ExternalLink> externalLinks;
  DateTime downloadTimeStamp;

  factory AppContent.fromJson(Map<String, dynamic> json) => AppContent(
        tiles: List<Tile>.from(json["tiles"].map((x) => Tile.fromJson(x))),
        parkingLots: List<ParkingLot>.from(
            json["parkingLots"].map((x) => ParkingLot.fromJson(x))),
        campusInfo: CampusInfo.fromJson(json["campusInfos"]),
        contactInfo: ContactInfo.fromJson(json["contactInfos"]),
        externalLinks: List<ExternalLink>.from(
            json["externalLinks"].map((x) => ExternalLink.fromJson(x))),
        downloadTimeStamp: DateTime.parse(json["downloadTimeStamp"]),
      );

  Map<String, dynamic> toJson() => {
        "tiles": List<dynamic>.from(tiles.map((x) => x.toJson())),
        "parkingLots": List<dynamic>.from(parkingLots.map((x) => x.toJson())),
        "campusInfos": campusInfo.toJson(),
        "contactInfos": contactInfo.toJson(),
        "externalLinks":
            List<dynamic>.from(externalLinks.map((x) => x.toJson())),
        "downloadTimeStamp": downloadTimeStamp.toIso8601String(),
      };
}
