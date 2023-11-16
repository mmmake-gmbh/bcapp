import 'package:bildungscampus_app/core/enums/feature_type.dart';
import 'package:bildungscampus_app/core/models/common/feature_info.dart';
import 'package:bildungscampus_app/core/viewmodels/app_viewmodel.dart';
import 'package:bildungscampus_app/ui/widgets/common/new_flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeatureView extends StatelessWidget {
  const FeatureView(
      {required this.featureType, required this.children, super.key});

  final List<Widget> children;
  final FeatureType? featureType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...children,
        if (featureType != null)
          Selector<AppViewModel, FeatureInfo>(
            builder: (context, featureInfo, _) => NewFlag(
              featureInfo: featureInfo,
              featureType: featureType!,
            ),
            selector: (context, model) => model.tiles!
                .firstWhere((tile) => tile.featureType == featureType)
                .featureInfo,
          ),
      ],
    );
  }
}
