import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot_priceitem.dart';

import 'parkinginfo_repository.dart';

class LocalParkingInfoRepository implements ParkingInfoRepository {
  @override
  Future<List<ParkingLot>> getAllParkingLots() async {
    final parkings = [
      ParkingLot(
          id: 1,
          carParkNo: 1,
          title: 'Parkhaus Mitte',
          subtitle: 'Beschäftigte',
          categories: [ParkingLotCategory.staff],
          city: '74076 Heilbronn',
          street: 'Weipertstraße 49',
          openingHours: 'Rund um die Uhr geöffnet',
          usedCapacity: 102,
          totalCapacity: 150,
          priceHeader: 'Tarif',
          priceItems: [
            ParkingLotPriceItem(title: 'Jede Stunde', description: '1,50 Euro'),
            ParkingLotPriceItem(title: 'Abendtarif', description: '3,00 Euro'),
            ParkingLotPriceItem(
                title: 'Tageshöchstsatz', description: '12,00 Euro'),
          ]),
      ParkingLot(
          id: 2,
          carParkNo: 2,
          title: 'Parkhaus Ost',
          subtitle: 'Studierende',
          categories: [ParkingLotCategory.students],
          city: '74076 Heilbronn',
          street: 'Dammstraße 1',
          openingHours: 'Rund um die Uhr geöffnet',
          usedCapacity: 39,
          totalCapacity: 50,
          priceHeader: 'Tarif',
          priceItems: [
            ParkingLotPriceItem(title: 'Jede Stunde', description: '1,50 Euro'),
            ParkingLotPriceItem(title: 'Abendtarif', description: '3,00 Euro'),
            ParkingLotPriceItem(
                title: 'Tageshöchstsatz', description: '12,00 Euro'),
          ]),
      ParkingLot(
          id: 3,
          carParkNo: 3,
          title: 'Parkplatz Ost',
          subtitle: 'Studierende',
          categories: [ParkingLotCategory.students],
          city: '74076 Heilbronn',
          street: 'Dammstraße 1',
          openingHours: 'Rund um die Uhr geöffnet',
          usedCapacity: 6,
          totalCapacity: 20,
          priceHeader: 'Tarif',
          priceItems: [
            ParkingLotPriceItem(title: 'Jede Stunde', description: '1,50 Euro'),
            ParkingLotPriceItem(title: 'Abendtarif', description: '3,00 Euro'),
            ParkingLotPriceItem(
                title: 'Tageshöchstsatz', description: '12,00 Euro'),
          ]),
      ParkingLot(
          id: 4,
          carParkNo: 4,
          title: 'Parkhaus Experimenta',
          subtitle: 'Besucher',
          categories: [ParkingLotCategory.guests],
          city: '74076 Heilbronn',
          street: 'Bahnhofstraße 6/1',
          openingHours: 'Rund um die Uhr geöffnet',
          usedCapacity: 0,
          totalCapacity: 0,
          priceHeader: 'Tarif',
          priceItems: [
            ParkingLotPriceItem(title: 'Jede Stunde', description: '1,50 Euro'),
            ParkingLotPriceItem(title: 'Abendtarif', description: '3,00 Euro'),
            ParkingLotPriceItem(
                title: 'Tageshöchstsatz', description: '12,00 Euro'),
          ]),
    ];

    return Future.value(parkings);
  }
}
