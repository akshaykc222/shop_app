import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/routes/app_pages.dart';
import 'package:shop_app/shop/presentation/themes/app_assets.dart';
import 'package:shop_app/shop/presentation/themes/app_strings.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';
import 'package:shop_app/shop/presentation/widgets/custom_switch.dart';

import '../../../../themes/app_colors.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ProductBloc.get(context);
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
                                        controller.addFiles(photo);
                                        controller.add(ImageFilesAddedEvent());
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
                                          controller.addFiles(file);
                                          controller
                                              .add(ImageFilesAddedEvent());
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

    buildTextFieldName() {
      return const CommonTextField(
        title: AppStrings.productName,
        required: true,
      );
    }

    buildTextFieldCategory(BuildContext context) {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              context: context,
              builder: (context) => Wrap(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  AppStrings.addNewCategory,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close)),
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: CommonTextField(
                              title: AppStrings.categoryName,
                            ),
                          ),
                          spacer20,
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  AppStrings.save,
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                          spacer30
                        ],
                      ),
                    ],
                  ));
        },
        child: const CommonTextField(
          title: AppStrings.productCategory,
          required: true,
        ),
      );
    }

    List<String> units = [
      "cm",
      "cms",
      "m",
      "dc",
      "cd",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
      "cm",
    ];
    buildTypeBottomSheet(BuildContext context) {
      return showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppStrings.chooseProductUnit,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                    Padding(
                      //outer spacing
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8, // space between items
                        children: units
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: AppColors.lightGrey,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(e),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ));
    }

    buildTextPriceAndDiscountField() {
      return Row(
        children: const [
          Expanded(
              child: CommonTextField(
            required: true,
            title: AppStrings.price,
            textInputType: TextInputType.numberWithOptions(decimal: true),
            prefix: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 4),
              child: Text(
                "AED",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: CommonTextField(
            required: true,
            title: AppStrings.discountPrice,
            textInputType: TextInputType.numberWithOptions(decimal: true),
            prefix: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 4),
              child: Text(
                "AED",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ))
        ],
      );
    }

    return Scaffold(
      appBar: getAppBar(
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                    size: 25,
                  )),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppStrings.editOrder,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Text(""))
            ],
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildImageWidget(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Product Status : ',
                            style: TextStyle(
                                color: AppColors.greyText,
                                fontWeight: FontWeight.w600),
                          ),
                          CustomSwitch(
                            value: true,
                            onChanged: (val) {},
                            enableColor: AppColors.green,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'In Stock : ',
                            style: TextStyle(
                                color: AppColors.greyText,
                                fontWeight: FontWeight.w600),
                          ),
                          CustomSwitch(
                            value: true,
                            onChanged: (val) {},
                            enableColor: AppColors.green,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                spacer30,
                buildTextFieldName(),
                spacer10,
                TextField(
                  controller: controller.productTagController,
                  onSubmitted: (val) {
                    controller.addTags(val);
                    controller.add(AddTagsFilterEvent());
                    controller.productTagController.clear();
                  },
                  decoration: const InputDecoration(
                      // hintText: AppStrings.addTags,
                      label: Text(AppStrings.addTags)),
                ),
                spacer10,
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    prettyPrint("list length ${controller.tagList.length}");
                    return controller.tagList.isEmpty
                        ? Container()
                        : SizedBox(
                            height: 30,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.tagList.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.tagList.isNotEmpty) {
                                          controller.removeTag(
                                              controller.tagList[index]);
                                          controller
                                              .add(DeleteTagsFilterEvent());
                                          // state.tags?.clear();
                                          // controller.addTags("val");
                                          // controller.add(
                                          //     AddTagsFilterEvent());
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Row(
                                          children: [
                                            Text(controller.tagList[index]),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Icon(Icons.close)
                                          ],
                                        ),
                                      ),
                                    )),
                          );
                  },
                ),
                spacer10,
                Builder(builder: (context) {
                  return buildTextFieldCategory(context);
                }),
                spacer10,
                buildTextPriceAndDiscountField(),
                spacer10,
                Row(
                  children: [
                    const Expanded(
                        child: CommonTextField(
                      title: AppStrings.productUnit,
                      required: true,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () => buildTypeBottomSheet(context),
                        child: CommonTextField(
                          enable: false,
                          title: AppStrings.productUnit,
                          // suffix: Icon(Icons.keyboard_arrow_down_sharp),
                          widgetLabel: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                AppStrings.piece,
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                        ),
                      );
                    })),
                  ],
                ),
                spacer10,
                const CommonTextField(title: AppStrings.productDetails),
                spacer20,
                GestureDetector(
                  onTap: () =>
                      GoRouter.of(context).pushNamed(AppPages.addVariant),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppAssets.add,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        AppStrings.addVariant,
                        style: TextStyle(
                            fontSize: 15,
                            color: AppColors.skyBlue,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                // const Divider(
                //   color: Colors.grey,
                // ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   height: 50,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //       child: const Text(AppStrings.addCategory)),
                // ),
                // const SizedBox(
                //   height: 10,
                // )
                spacer30,
                spacer30
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            AppStrings.addNewProduct,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
