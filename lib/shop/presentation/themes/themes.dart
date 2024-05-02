import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: false,
        // bottomSheetTheme: BottomSheetThemeData(
        //   elevation: 0,Ra
        // ),
        radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.resolveWith((Set states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.primaryColor.withOpacity(.32);
          }
          return AppColors.primaryColor;
        })),
        scaffoldBackgroundColor: AppColors.offWhite1,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.primaryColor),
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
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: const TextStyle(
              color: AppColors.black, fontWeight: FontWeight.bold),
          hintStyle: const TextStyle(
              color: AppColors.black, fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.lightGrey),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.lightGrey),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.lightGrey),
              borderRadius: BorderRadius.circular(10)),
        ),
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.black),
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
