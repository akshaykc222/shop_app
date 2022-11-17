import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
        // bottomSheetTheme: BottomSheetThemeData(
        //   elevation: 0,
        // ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                )),
                backgroundColor:
                    MaterialStatePropertyAll(AppColors.primaryColor))),
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.white),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGrey)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGrey)),
        ),
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          // headline5: const TextStyle(
          //     color: AppColors.black,
          //     fontWeight: FontWeight.w600,
          //     fontSize: 25),
          bodyMedium: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: 15),
          bodySmall: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 15),
        ));
  }
}
