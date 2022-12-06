import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../widgets/mandatory_text.dart';

class DeliveryManAdding extends StatelessWidget {
  const DeliveryManAdding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildImageWidget() {
      return GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (context) => Dialog(
                  child: SizedBox(
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(AppStrings.uploadProductImage,
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
                                      final ImagePicker _picker = ImagePicker();
                                      // Pick an image
                                      // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                      // Capture a photo
                                      final XFile? photo =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      if (photo != null) {
                                        // controller.addFiles(photo);
                                        // controller.add(ImageFilesAddedEvent());
                                        Navigator.pop(context);
                                      }
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
                                      final ImagePicker _picker = ImagePicker();
                                      // Pick an image
                                      final List<XFile?> image =
                                          await _picker.pickMultiImage();
                                      for (var file in image) {
                                        if (file != null) {
                                          // controller.addFiles(file);
                                          // controller
                                          //     .add(ImageFilesAddedEvent());
                                        } else {}
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
                        // spacer20,
                      ],
                    ),
                  ),
                )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 38,
            ),
            Container(
              width: 138,
              height: 138,
              decoration: BoxDecoration(
                  // color: AppColors.lightGrey,
                  border: Border.all(color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(19)),
              child: const Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                  color: AppColors.lightGrey,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              AppStrings.addImage,
              style: TextStyle(
                  color: AppColors.skyBlue, fontWeight: FontWeight.w600),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      AppStrings.newDeliveryMan,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              Expanded(flex: 1, child: SizedBox())
            ],
          )),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)))),
          child: const Text(
            AppStrings.save,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildImageWidget(),
              spacer20,
              const CommonTextField(
                title: AppStrings.firstName,
                required: true,
              ),
              const CommonTextField(
                title: AppStrings.secondName,
              ),
              const CommonTextField(
                title: AppStrings.email,
                required: true,
              ),
              CommonTextField(
                title: AppStrings.phoneNumber,
                prefix: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Image.asset(
                          AppAssets.uae,
                          width: 45,
                          height: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 1,
                        decoration:
                            const BoxDecoration(color: AppColors.cardLightGrey),
                      )
                    ],
                  ),
                ),
                showSuffixIcon: true,
              ),
              spacer10,
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MandatoryText(title: AppStrings.idType),
                    ),
                  ),
                  spacer10,
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: DropdownButtonFormField<String>(
                            items: [
                              "Passport",
                            ]
                                .map((e) =>
                                    DropdownMenuItem<String>(child: Text(e)))
                                .toList(),
                            onChanged: (Object? value) {},
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.lightGrey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image_rounded,
                              color: AppColors.lightGrey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const CommonTextField(title: AppStrings.password),
              spacer20
            ],
          ),
        ),
      ),
    );
  }
}
