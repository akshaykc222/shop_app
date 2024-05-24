import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/connection_checker.dart';
import '../../../injector.dart';
import '../themes/app_colors.dart';
import '../themes/app_strings.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget>
    with SingleTickerProviderStateMixin {
  final ConnectionChecker connectionChecker = sl();

  late AnimationController animationController;
  late Animation fadeAnimation;
  String showString = AppStrings.noInternetConnection;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    fadeAnimation = Tween<double>(begin: 0, end: 70).animate(CurvedAnimation(
        parent: animationController, curve: Curves.bounceInOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? const SizedBox()
        : StreamBuilder<InternetConnectionStatus>(
            stream: connectionChecker.getConnectionInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == InternetConnectionStatus.connected) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
                return AnimatedBuilder(
                  animation: fadeAnimation,
                  builder: (BuildContext context, Widget? child) {
                    return fadeAnimation.value == 0
                        ? const SizedBox()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                color: animationController.status ==
                                        AnimationStatus.reverse
                                    ? AppColors.green
                                    : AppColors.red),
                            child: Center(
                              child: Text(
                                animationController.status ==
                                        AnimationStatus.reverse
                                    ? AppStrings.backOnline
                                    : AppStrings.noInternetConnection,
                                style: const TextStyle(
                                    color: AppColors.white, fontSize: 14),
                              ),
                            ),
                          );
                  },
                );
              } else {
                return const SizedBox();
              }
            });
  }
}
