import 'package:bildungscampus_app/core/enums/parkinglot_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bildungscampus_app/core/viewmodels/tiles/parking_tile_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/tiles/carousel_tile_content.dart';

class ParkingTileContent extends StatelessWidget {
  final List<MapEntry<ParkingLotCategory, String>> parkingCategories;
  final Color contentColor;
  final String? buttonText;
  final Color buttonTextColor;
  final Function? onTap;

  const ParkingTileContent({
    Key? key,
    required this.parkingCategories,
    required this.contentColor,
    required this.buttonText,
    required this.buttonTextColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselTileContent<MapEntry<ParkingLotCategory, String>>(
        items: parkingCategories,
        contentColor: Colors.white,
        builder: (ctx, model) {
          return Center(
            child: Text(
              model.value,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        onSlideTap: (ctx, model) {
          if (onTap != null) {
            onTap!();
          }
        },
        onSlideChange: (newIndex) =>
            Provider.of<ParkingTileViewModel>(context, listen: false)
                .updateSelectedParkinglot(newIndex),
      ),
      Align(
        alignment: Alignment.topRight,
        child: ButtonTheme(
          minWidth: 0,
          height: 0,
          child: TextButton(
            onPressed: onTap as void Function()?,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.only(top: 10, left: 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              buttonText!,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: buttonTextColor,
                    height: 1.2,
                    letterSpacing: 0.1,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    ]);
  }
}
