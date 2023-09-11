import 'package:bildungscampus_app/core/models/parking/parkinglot.dart';

abstract class ParkingInfoRepository {
  Future<List<ParkingLot>> getAllParkingLots();
}
