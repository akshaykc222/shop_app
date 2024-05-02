import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_parser/color_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shop_app/shop/domain/entities/ProductEntity.dart';
import 'package:shop_app/shop/presentation/manager/bloc/product_bloc/product_bloc.dart';
import 'package:shop_app/shop/presentation/manager/bloc/variant_bloc/variant_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/utils/select_image_and_crop.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';
import 'package:shop_app/shop/presentation/widgets/custom_app_bar.dart';

import '../../../../themes/app_assets.dart';
import '../../../../themes/app_strings.dart';

class VariantScreen extends StatelessWidget {
  const VariantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = VariantBloc.get(context);
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
                  AppStrings.addVariant,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Text(""))
            ],
          )),
      bottomNavigationBar: SizedBox(
        height: 55,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            var productBloc = ProductBloc.get(context);
            productBloc.add(ChangeVariantEvent(controller.state.variants));
            GoRouter.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)))),
          child: const Text(
            AppStrings.saveAndContinue,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    // margin: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.size,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.lightGrey),
                              ),
                              const Icon(Icons.keyboard_arrow_down,
                                  size: 30, color: AppColors.lightGrey)
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: AppColors.offWhite1,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              AppStrings.lowestPriceDesc,
                              style: TextStyle(
                                  fontSize: 15, color: AppColors.greyText),
                            ),
                          ),
                          spacer9,
                          Wrap(
                            children: [
                              BlocConsumer<VariantBloc, VariantState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.variants.length,
                                      itemBuilder: (context, index) =>
                                          SizeProduct(
                                            index: index,
                                            variant: state.variants[index],
                                          ));
                                },
                              )
                            ],
                          ),
                          spacer22,
                          GestureDetector(
                            onTap: () => controller.add(VariantAdd()),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.skyBlue)),
                              child: const Center(
                                child: Text(
                                  AppStrings.addAnotherSize,
                                  style: TextStyle(color: AppColors.skyBlue),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                spacer22,
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Card(
                //     // margin: const EdgeInsets.all(8),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8)),
                //     elevation: 0,
                //     child: Padding(
                //       padding: const EdgeInsets.all(12.0),
                //       child: Column(
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 AppStrings.color,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .titleLarge
                //                     ?.copyWith(
                //                         fontWeight: FontWeight.bold,
                //                         color: AppColors.greyText),
                //               ),
                //               const Icon(Icons.keyboard_arrow_down,
                //                   size: 30, color: AppColors.greyText)
                //             ],
                //           ),
                //           // spacer14,
                //           // Wrap(
                //           //   children: [
                //           //     BlocConsumer<VariantBloc, VariantState>(
                //           //       listener: (context, state) {},
                //           //       builder: (context, state) {
                //           //         return ListView.builder(
                //           //             shrinkWrap: true,
                //           //             physics:
                //           //                 const NeverScrollableScrollPhysics(),
                //           //             itemCount: controller.colorsList.length,
                //           //             itemBuilder: (context, index) =>
                //           //                 ColorProduct(
                //           //                   index: index,
                //           //                   color: controller.colorsList[index],
                //           //                   delete: () {
                //           //                     try {
                //           //                       controller.removeColor(
                //           //                           controller
                //           //                               .colorsList[index]);
                //           //                       controller.add(DeleteColor());
                //           //                     } catch (e) {
                //           //                       prettyPrint(e.toString());
                //           //                     }
                //           //                   },
                //           //                 ));
                //           //       },
                //           //     )
                //           //   ],
                //           // ),
                //           // GestureDetector(
                //           //   onTap: () => showDialog(
                //           //     context: context,
                //           //     builder: (context) => AlertDialog(
                //           //       title: const Text('Pick a color!'),
                //           //       content: SingleChildScrollView(
                //           //         // child: ColorPicker(
                //           //         //
                //           //         // ),
                //           //         // Use Material color picker:
                //           //         //
                //           //         // child: MaterialPicker(
                //           //         //   pickerColor: controller.pickerColor,
                //           //         //   onColorChanged: controller.changeColor,
                //           //         // ),
                //           //         //
                //           //         // Use Block color picker:
                //           //         //
                //           //         child: BlockPicker(
                //           //           pickerColor: controller.pickerColor,
                //           //           onColorChanged: controller.changeColor,
                //           //         ),
                //           //         //
                //           //         // child: MultipleChoiceBlockPicker(
                //           //         //   pickerColors: currentColors,
                //           //         //   onColorsChanged: changeColors,
                //           //         // ),
                //           //       ),
                //           //       actions: <Widget>[
                //           //         ElevatedButton(
                //           //           child: const Text('Select'),
                //           //           onPressed: () {
                //           //             controller
                //           //                 .addColor(controller.currentColor);
                //           //             controller.add(VariantColorSelected());
                //           //             Navigator.of(context).pop();
                //           //           },
                //           //         ),
                //           //       ],
                //           //     ),
                //           //   ),
                //           //   child: Container(
                //           //     width: MediaQuery.of(context).size.width,
                //           //     height: 55,
                //           //     decoration: BoxDecoration(
                //           //         borderRadius: BorderRadius.circular(10),
                //           //         border: Border.all(color: AppColors.skyBlue)),
                //           //     child: const Center(
                //           //       child: Text(
                //           //         AppStrings.addColor,
                //           //         style: TextStyle(color: AppColors.skyBlue),
                //           //       ),
                //           //     ),
                //           //   ),
                //           // )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorProduct extends StatelessWidget {
  final int index;
  final Color color;
  final Function delete;
  const ColorProduct(
      {Key? key,
      required this.index,
      required this.color,
      required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            ColorParser.color(color).toName() ?? "",
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => delete(),
            child: const Text(
              AppStrings.delete,
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeProduct extends StatefulWidget {
  final int index;
  final QuantityVariant variant;

  const SizeProduct({Key? key, required this.index, required this.variant})
      : super(key: key);

  @override
  State<SizeProduct> createState() => _SizeProductState();
}

class _SizeProductState extends State<SizeProduct> {
  late VariantBloc controller;
  ValueNotifier<String> image = ValueNotifier("");
  final nameController = TextEditingController();
  final unit = TextEditingController();
  final price = TextEditingController();
  final sellingPrice = TextEditingController();
  final description = TextEditingController();
  printTest() async {
    print(await widget.variant.toJson());
  }

  @override
  void initState() {
    nameController.text = widget.variant.variantName ?? "";
    unit.text = widget.variant.sizeName ?? "";
    price.text =
        widget.variant.price == null ? "" : widget.variant.price.toString();
    sellingPrice.text = widget.variant.sellingPrice == null
        ? ""
        : widget.variant.sellingPrice.toString();
    image.value = widget.variant.variantImage ?? "";
    description.text = widget.variant.description ?? "";
    printTest();
    controller = VariantBloc.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          title: "Variant Name ${widget.index + 1}",
          controller: nameController,
          required: true,
          onChange: (val) {
            widget.variant.variantName = val;
          },
        ),
        spacer10,
        ValueListenableBuilder(
            valueListenable: image,
            builder: (context, data, child) {
              return GestureDetector(
                onTap: () async {
                  CroppedFile? picked = await selectImageAndCropImage(
                      context: context, title: "Variant Image");
                  if (picked != null) {
                    image.value = picked.path;
                    widget.variant.variantImage = picked.path;
                    image.notifyListeners();
                  }
                },
                child: data != ""
                    ? FutureBuilder(
                        future: isFilePath(data),
                        builder: (context, d) {
                          return d.hasData
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: d.data == true
                                          ? DecorationImage(
                                              image:
                                                  FileImage(File(image.value)))
                                          : DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  data))),
                                )
                              : const SizedBox();
                        })
                    : Row(
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
                            AppStrings.addImage,
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.skyBlue,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
              );
            }),
        spacer10,
        CommonTextField(
          title: "Weight with unit",
          controller: unit,
          required: true,
          onChange: (val) {
            widget.variant.sizeName = val;
          },
        ),
        spacer10,
        CommonTextField(
          title: "Description",
          controller: description,
          required: false,
          onChange: (val) {
            widget.variant.description = val;
          },
        ),
        spacer10,
        Row(
          children: [
            Expanded(
                child: CommonTextField(
              title: AppStrings.price,
              controller: price,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              required: true,
              onChange: (val) {
                if (double.tryParse(val) != null) {
                  widget.variant.price = double.tryParse(val);
                }
              },
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: CommonTextField(
              title: AppStrings.sellingPrice,
              controller: sellingPrice,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              required: false,
              onChange: (val) {
                if (double.tryParse(val) != null) {
                  widget.variant.sellingPrice = double.tryParse(val);
                }
              },
            )),
            GestureDetector(
              onTap: () => controller.add(VariantDecrement()),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 30),
                child: Image.asset(
                  AppAssets.delete,
                  width: 22,
                  height: 25,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        spacer5,
      ],
    );
  }
}
