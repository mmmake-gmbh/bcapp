import 'package:bildungscampus_app/core/models/parking/parkinglot.dart';
import 'package:bildungscampus_app/core/repositories/parking/parkinginfo_repository.dart';
import 'package:bildungscampus_app/core/repositories/base_repository.dart';

class ApiParkingInfoRepository extends BaseRepository<ParkingLot>
    implements ParkingInfoRepository {
  @override
  Future<List<ParkingLot>> getAllParkingLots() async {
    final List<ParkingLot> item = await getItems("/parking");
    return item;
  }

  @override
  ParkingLot mapFromJson(jsonResponse) {
    return ParkingLot.fromJson(jsonResponse);
  }
}
