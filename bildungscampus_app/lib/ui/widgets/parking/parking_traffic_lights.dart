import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:bildungscampus_app/core/enums/parkinglot_light.dart';
import 'package:bildungscampus_app/core/models/parking/parkinglot.dart';

class ParkingTrafficLights extends StatelessWidget {
  final ParkingLot? parkingModel;
  final Color textColor;

  const ParkingTrafficLights({
    Key? key,
    required this.parkingModel,
    required this.textColor,
  }) : super(key: key);

  Color _getCircleColor(ParkingLotLight light) {
    switch (light) {
      case ParkingLotLight.green:
        return AppColors.parkingLightGreen;
      case ParkingLotLight.yellow:
        return AppColors.parkingLightYellow;
      case ParkingLotLight.red:
        return AppColors.parkingLightRed;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (parkingModel!.currentLight == ParkingLotLight.none) {
      return const SizedBox(height: 18);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.fromLTRB(6, 0, 6, 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getCircleColor(parkingModel!.currentLight),
          ),
        ),
        Text(
          '${parkingModel!.availableCapacity} ${S.of(context).parkinglot_view_traffic_lights_free_slots_text}',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: textColor,
                height: 1.19,
                letterSpacing: 0.09,
              ),
        ),
      ],
    );
  }
}
