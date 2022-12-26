import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';

import '../../../core/custom_exception.dart';
import '../../data/models/login_response.dart';
import '../../data/routes/hive_storage_name.dart';

class AppConstants {
  static const appName = "Shop App ";
  static const emailRegex =
      "^[a-zA-Z0-9]+(?:\\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\\.[a-zA-Z0-9]+)*\$";
  static const kEmailError = "Invalid email. please enter a valid email";
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

UserDataShort getUserData() {
  GetStorage storage = GetStorage();
  Map<String, dynamic>? userData = storage.read(LocalStorageNames.userData);
  if (userData == null) {
    throw UnauthorisedException();
  }

  return UserDataShort.fromJson(userData);
}
