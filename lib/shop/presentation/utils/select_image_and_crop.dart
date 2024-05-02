import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../themes/app_colors.dart';
import '../themes/app_strings.dart';
import 'app_constants.dart';

Future<CroppedFile?> selectImageAndCropImage(
    {required BuildContext context, required String title}) async {
  ValueNotifier<CroppedFile?> croppedImage = ValueNotifier(null);

  await showDialog(
      context: context,
      builder: (context) => Dialog(
            child: SizedBox(
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close,
                            size: 25,
                          ))
                    ],
                  ),
                  spacer20,
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                // Pick an image
                                // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                // Capture a photo
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (photo != null) {
                                  CroppedFile? croppedFile =
                                      await ImageCropper().cropImage(
                                    sourcePath: photo.path,
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.square,
                                      CropAspectRatioPreset.ratio16x9,
                                    ],
                                    uiSettings: [
                                      AndroidUiSettings(
                                          toolbarTitle: 'Crop Image',
                                          toolbarColor: AppColors.primaryColor,
                                          toolbarWidgetColor: Colors.white,
                                          initAspectRatio:
                                              CropAspectRatioPreset.square,
                                          lockAspectRatio: true),
                                    ],
                                  );
                                  croppedImage.value = croppedFile;
                                }
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 50,
                                  ),
                                  spacer5,
                                  const Text(AppStrings.camara)
                                ],
                              ))),
                      Expanded(
                          child: GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                // Pick an image
                                // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                // Capture a photo
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (photo != null) {
                                  CroppedFile? croppedFile =
                                      await ImageCropper().cropImage(
                                    sourcePath: photo.path,
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.ratio4x3,
                                    ],
                                    uiSettings: [
                                      AndroidUiSettings(
                                          toolbarTitle: 'Crop Image',
                                          toolbarColor: AppColors.primaryColor,
                                          toolbarWidgetColor: Colors.white,
                                          initAspectRatio:
                                              CropAspectRatioPreset.original,
                                          lockAspectRatio: true),
                                    ],
                                  );
                                  croppedImage.value = croppedFile;
                                }
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.image_outlined,
                                    size: 50,
                                  ),
                                  spacer5,
                                  const Text(AppStrings.gallery)
                                ],
                              ))),
                    ],
                  ),
                  spacer20,
                ],
              ),
            ),
          ));

  return croppedImage.value;
}
