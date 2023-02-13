import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';

class DeleteAlert extends StatelessWidget {
  final String title;
  final String? desc;
  final Color? titleColor;
  final Color? descColor;
  final Color? cancelButtonColor;
  final Color? submitButtonColor;
  final String? cancelText;
  final String? submitTxt;

  final Function onDelete;
  final Function onCancel;

  const DeleteAlert(
      {Key? key,
      required this.title,
      this.desc,
      required this.onDelete,
      required this.onCancel,
      this.titleColor,
      this.cancelButtonColor,
      this.submitButtonColor,
      this.descColor,
      this.cancelText,
      this.submitTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: TextStyle(color: titleColor ?? Colors.black),
              ),
            ),
            GestureDetector(
                child: Container(
                    decoration: const BoxDecoration(color: AppColors.offWhite1),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.black,
                    )))
          ],
        ),
        spacer10,
        desc == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  desc ?? "",
                  style: const TextStyle(color: AppColors.offWhite1),
                ),
              ),
        spacer10,
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: cancelButtonColor),
              onPressed: () {},
              child: Text(cancelText ?? "Cancel"),
            )),
            Expanded(
                child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: submitButtonColor),
              onPressed: () {},
              child: Text(submitTxt ?? "Submit"),
            )),
          ],
        )
      ],
    );
  }
}

showDeleteAlert(
    {required BuildContext context,
    required String title,
    String? desc,
    DialogType? dialogType,
    required Function onDelete,
    required Function onCancel,
    String? titleColor,
    String? cancelButtonColor,
    String? submitButtonColor,
    String? descColor,
    String? cancelText,
    String? submitTxt}) {
  if (dialogType == null || dialogType == DialogType.bottomSheet) {
    showModalBottomSheet(
        context: context,
        builder: (context) =>
            DeleteAlert(title: title, onDelete: onDelete, onCancel: onCancel));
  } else {
    showDialog(
        context: context,
        builder: (context) =>
            DeleteAlert(title: title, onDelete: onDelete, onCancel: onCancel));
  }
}

enum DialogType { bottomSheet, dialog }
