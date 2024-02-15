import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/ui/shared/app_images.dart';
import 'package:bildungscampus_app/ui/widgets/navigation/reusable_appbars.dart';
import 'package:flutter/material.dart';

class MensaInfoDialogContent extends StatelessWidget {
  final double appBarHeight;

  const MensaInfoDialogContent({super.key, required this.appBarHeight});

  static const leftTextStyle = TextStyle(
    color: Color(0xFF9D9D9D),
    fontSize: 16,
    fontFamily: 'DIN OT',
    fontWeight: FontWeight.w500,
  );

  static final rightTextStyle = TextStyle(
    color: Colors.black.withOpacity(0.5400000214576721),
    fontSize: 12,
    fontFamily: 'DIN OT',
    fontWeight: FontWeight.w500,
    letterSpacing: 0.30,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: appBarHeight,
          color: const Color(0xFF2B78A7),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(
                  width: 10,
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  S.of(context).mensa_view_info_dialog_title,
                  textAlign: TextAlign.center,
                  style: ReusableAppBars.standardTextStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          AppImages.mensa,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mensa Bildungscampus",
                    style: TextStyle(
                      color: Color(0xFF193E69),
                      fontSize: 20,
                      fontFamily: 'DIN OT',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SelectableText(
                    "Bildungscampus 8,\n74076 Heilbronn",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5400000214576721),
                      fontSize: 14,
                      fontFamily: 'DIN OT',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.10,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: const Color.fromRGBO(242, 242, 243, 1),
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).mensa_view_info_dialog_details,
                    style: const TextStyle(
                      color: Color(0xFF193E69),
                      fontSize: 16,
                      fontFamily: 'DIN OT',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).mensa_view_info_content_opening_hours,
                          style: leftTextStyle,
                        ),
                      ),
                      Text(
                        S
                            .of(context)
                            .mensa_view_info_content_opening_hours_value,
                        textAlign: TextAlign.right,
                        style: rightTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).mensa_view_info_content_vegan_label,
                          style: leftTextStyle,
                        ),
                      ),
                      Text(
                        S.of(context).mensa_view_info_content_vegan_value,
                        textAlign: TextAlign.right,
                        style: rightTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S
                              .of(context)
                              .mensa_view_info_content_campuscard_label,
                          style: leftTextStyle,
                        ),
                      ),
                      Text(
                        S.of(context).mensa_view_info_content_campuscard_value,
                        textAlign: TextAlign.right,
                        style: rightTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).mensa_view_info_content_payment_label,
                          style: leftTextStyle,
                        ),
                      ),
                      Text.rich(
                        textAlign: TextAlign.right,
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'CampusCard\n', style: rightTextStyle),
                            TextSpan(
                              text: S
                                  .of(context)
                                  .mensa_view_info_content_payment_value,
                              style: const TextStyle(
                                color: Color(0xFF2B78A7),
                                fontSize: 12,
                                fontFamily: 'DIN OT',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF2B78A7),
                                letterSpacing: 0.30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: const Color.fromRGBO(242, 242, 243, 1),
            ),
          ],
        ),
      ],
    );
  }
}
