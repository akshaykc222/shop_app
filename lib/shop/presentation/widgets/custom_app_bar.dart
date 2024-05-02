import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

PreferredSize getAppBar(BuildContext context, Widget child, {double? height}) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, height ?? 70),
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2, right: 2),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.offWhite1,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0.0, 1.0), //(x,y)
                blurRadius: 4.0,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            child,
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ),
  );
}
