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
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.lightGrey, shape: BoxShape.circle),
                    child: const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Icon(
                        Icons.close,
                        color: AppColors.black,
                        size: 20,
                      ),
                    )))
          ],
        ),
        spacer10,
        desc == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    desc ?? "",
                    style: const TextStyle(color: AppColors.black),
                  ),
                ),
              ),
        spacer10,
        Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: cancelButtonColor),
                onPressed: () => onCancel(),
                child: Text(cancelText ?? "Cancel"),
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: submitButtonColor ?? Colors.red),
                onPressed: () {
                  onDelete();
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(submitTxt ?? "Delete"),
                  ],
                ),
              ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        builder: (context) => Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DeleteAlert(
                    title: title,
                    onDelete: onDelete,
                    onCancel: onCancel,
                    desc: desc,
                    cancelText: cancelText,
                    submitTxt: submitTxt,
                  ),
                ),
              ],
            ));
  } else {
    showDialog(
        context: context,
        builder: (context) =>
            DeleteAlert(title: title, onDelete: onDelete, onCancel: onCancel));
  }
}

enum DialogType { bottomSheet, dialog }
