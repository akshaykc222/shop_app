import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';

import '../../data/routes/hive_storage_name.dart';
import '../themes/app_assets.dart';

class AppConstants {
  static const appName = "Shop App ";
  static const mapKey = "AIzaSyDaGKjCFg-uQoU1p9OA0vUVdUczni4f0qA";
  static const phoneRegex =
      "^(?:\\+971|00971|0)?(?:50|51|52|55|56|2|3|4|6|7|9)\\d{7}\$";
  // static const passportRegex ="^(?!^0+\$)[a-zA-Z0-9]{3,20}\$";
  // static const
  static const emailRegex =
      "^[a-zA-Z0-9]+(?:\\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\\.[a-zA-Z0-9]+)*\$";
  static const kMobileError =
      "Invalid Phone number. please enter a valid number";
  static const kPasswordError = "Enter password";
  static const kProductNameError = "Enter Product Name";
  static const kSelectImageError = "choose a image";
  static const kSelectCategory = "choose a category";
  static const kSelectSubCategory = "choose a sub category";
  static const kEnterPrice = "Enter price";
  static const kEnterDiscountPrice = "Enter price";
  static const kEnterValidDiscount =
      "Discount price must be less than actual price";
  static const kProductValidNameError = "Enter a valid Product Name";
  static const kSelectUnitType = "Choose unit type";
  static const kSelectUnit = "Enter unit";

  static const kPasswordInvalidError =
      "Enter password greater than 6 characters";
  static const kErrorConflictMessage =
      "Category can not be deleted!.This category contain subcategories .Remove related Sub categories in order to delete this category";
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

handleUnAuthorizedError(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Session Expired!",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    "Your Session has expired. Please login again.",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      GoRouter.of(context).goNamed(AppPages.login);
                    },
                    child: const Text("Login"),
                  ),
                )
              ],
            ),
          ));
}

handleError(BuildContext context, String error, Function action) {
  showModalBottomSheet(
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    "Something went wrong!",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  child: Text(
                    error,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      action();
                    },
                    child: const Text("Close"),
                  ),
                )
              ],
            ),
          ));
}

DateTime formatTimeOfDay(TimeOfDay tod) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  // final format = DateFormat.jm();
  // return format.format(dt);
}

commonErrorDialog(
    {required BuildContext context,
    required String message,
    Function? action}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: AppColors.white,
      ),
    ),
    backgroundColor: AppColors.red,
  ));
}

// Future<UserDataShort> getUserData() async {
//   GetStorage storage = GetStorage();
//   var sh = await SharedPreferences.getInstance();
//
//   String? userData = sh.getString(LocalStorageNames.userData);
//   if (userData == null) {
//     throw UnauthorisedException();
//   }
//
//   return UserDataShort.fromJson(jsonDecode(userData ?? ""));
// }

Future<String> getPositionedPrice(String price) async {
  // UserDataShort userDataShort = await getUserData();
  prettyPrint(price);
  // if (userDataShort.currency.position.toString().toLowerCase() == "left") {
  //   return " ${userDataShort.currency.symbol} $price";
  // } else {
  //   return " $price ${userDataShort.currency.symbol} ";
  // }
  return price;
}

Future<int?> getType() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt(LocalStorageNames.type);
}

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              AppStrings.areYouSure,
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w600),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.close))
          ],
        ),
        spacer20,
      ],
    );
  }
}

String getFormatedDate(DateTime date) {
  final now = DateTime.now();

  if (now.day == date.day && date.month == now.month && date.year == now.year) {
    return "Today , ${DateFormat.EEEE().format(date)}";
  } else if (now.day + 1 == date.day &&
      date.month == now.month &&
      date.year == now.year) {
    return "Tomorrow , ${DateFormat.EEEE().format(date)}";
  } else if (now.day - 1 == date.day &&
      date.month == now.month &&
      date.year == now.year) {
    return "Yesterday , ${DateFormat.EEEE().format(date)}";
  } else {
    return "${date.day.toString().padLeft(2, "0")}-${DateFormat.MMM().format(date)}-${date.year.toString().padLeft(2, "0")}, ${DateFormat.jm().format(date)}";
  }
}

deleteDialog(
    {required String title,
    required String message,
    required Function delete,
    required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (context) => Container(
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    spacer10,
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        AppAssets.deleteGif,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    spacer10,
                    const Text(
                      "Close Your Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      "Please note that account closure is a permanent action, and once your account is closed, it will no longer be available to you and cannot be restored.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    spacer10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.red)),
                                foregroundColor: Colors.black),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(AppStrings.cancel),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {},
                            child: const Text(AppStrings.confirm),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
                // Positioned(
                //     top: 10,
                //     right: 10,
                //     child: InkWell(
                //       onTap: () {
                //         Navigator.pop(context);
                //       },
                //       child: Container(
                //         width: 30,
                //         height: 30,
                //         // padding: const EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //           color: Colors.grey.shade400,
                //           shape: BoxShape.circle,
                //         ),
                //         child: const Center(
                //           child: Icon(
                //             Icons.close,
                //             size: 20,
                //             color: Colors.black,
                //           ),
                //         ),
                //       ),
                //     ))
              ],
            ),
          ));
}

enum HomeTypes { day, month, year }

Future<bool> isFilePath(String path) async {
  try {
    if (await File(path).exists()) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}
