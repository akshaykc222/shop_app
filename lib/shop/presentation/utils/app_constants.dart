import 'package:flutter/material.dart';

class AppConstants {
  static const appName = "Shop App ";
  static const emailRegex =
      "^[a-zA-Z0-9]+(?:\\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\\.[a-zA-Z0-9]+)*\$";
  static const kEmailError = "Invalid email. please enter a valid email";
  static const kPasswordError = "Enter password";
  static const kPasswordInvalidError =
      "Enter password greater than 6 characters";
}

Widget spacer5 = const SizedBox(
  height: 5,
);
Widget spacer9 = const SizedBox(
  height: 9,
);
Widget spacer10 = const SizedBox(
  height: 10,
);
Widget spacer14 = const SizedBox(
  height: 14,
);
Widget spacer18 = const SizedBox(
  height: 18,
);
Widget spacer17 = const SizedBox(
  height: 17,
);
Widget spacer20 = const SizedBox(
  height: 20,
);
Widget spacer22 = const SizedBox(
  height: 22,
);
Widget spacer37 = const SizedBox(
  height: 37,
);
Widget spacer30 = const SizedBox(
  height: 30,
);

Widget spacer26 = const SizedBox(
  height: 26,
);

Widget spacer24 = const SizedBox(
  height: 24,
);

enum WeekDays { sunday, monday, tuesday, wednesday, thursday, friday, saturday }
