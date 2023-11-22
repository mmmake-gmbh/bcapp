import 'package:bildungscampus_app/core/l10n/generated/l10n.dart';
import 'package:bildungscampus_app/core/viewmodels/user_viewmodel.dart';
import 'package:bildungscampus_app/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeTile extends StatefulWidget {
  const WelcomeTile({super.key, required this.firstLogin});

  final bool firstLogin;

  @override
  State<WelcomeTile> createState() => _WelcomeTileState();
}

class _WelcomeTileState extends State<WelcomeTile>
    with TickerProviderStateMixin {
  bool _visible = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    if (widget.firstLogin) {
      _visible = true;
      _controller.repeat(reverse: true);

      Future.delayed(const Duration(milliseconds: 4500), () {
        if (mounted) {
          setState(() {
            _visible = false;
            _controller.stop();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.select<UserViewModel, String?>(
      (value) => value.userName,
    );

    if (userName != null && userName.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).welcome_tile_hello,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontFamily: 'DINOT Bold',
                        color: Colors.white,
                        backgroundColor: AppColors.welcomeTileTextBgColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      userName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontFamily: 'DINOT Bold',
                              color: Colors.white,
                              backgroundColor:
                                  AppColors.welcomeTileTextBgColor),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: RotationTransition(
                turns: Tween(begin: -0.1, end: 0.1).animate(_controller),
                child: const Text(
                  '👋',
                  style: TextStyle(fontSize: 70),
                ),
              ),
            )
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    _visible = true;
    _controller.dispose();
    super.dispose();
  }
}
