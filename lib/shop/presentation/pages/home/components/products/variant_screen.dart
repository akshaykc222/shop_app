import 'package:color_parser/color_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shop_app/core/pretty_printer.dart';
import 'package:shop_app/shop/presentation/manager/bloc/variant_bloc/variant_bloc.dart';
import 'package:shop_app/shop/presentation/themes/app_colors.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/common_text_field.dart';

import '../../../../themes/app_strings.dart';

class VariantScreen extends StatelessWidget {
  const VariantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = VariantBloc.get(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.addVariant),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.size,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                  )
                                ],
                              ),
                              Wrap(
                                children: [
                                  BlocConsumer<VariantBloc, VariantState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: state.count,
                                          itemBuilder: (context, index) =>
                                              SizeProduct(index: index));
                                    },
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () => controller.add(VariantAdd()),
                                child: Container(
                                  width: 150,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColors.lightGrey)),
                                  child: const Center(
                                    child: Text(AppStrings.addAnotherSize),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    spacer30,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.color,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                  )
                                ],
                              ),
                              Wrap(
                                children: [
                                  BlocConsumer<VariantBloc, VariantState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              controller.colorsList.length,
                                          itemBuilder: (context, index) =>
                                              ColorProduct(
                                                index: index,
                                                color: controller
                                                    .colorsList[index],
                                                delete: () {
                                                  try {
                                                    controller.removeColor(
                                                        controller
                                                            .colorsList[index]);
                                                    controller
                                                        .add(DeleteColor());
                                                  } catch (e) {
                                                    prettyPrint(e.toString());
                                                  }
                                                },
                                              ));
                                    },
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      // child: ColorPicker(
                                      //
                                      // ),
                                      // Use Material color picker:
                                      //
                                      // child: MaterialPicker(
                                      //   pickerColor: controller.pickerColor,
                                      //   onColorChanged: controller.changeColor,
                                      // ),
                                      //
                                      // Use Block color picker:
                                      //
                                      child: BlockPicker(
                                        pickerColor: controller.pickerColor,
                                        onColorChanged: controller.changeColor,
                                      ),
                                      //
                                      // child: MultipleChoiceBlockPicker(
                                      //   pickerColors: currentColors,
                                      //   onColorsChanged: changeColors,
                                      // ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Select'),
                                        onPressed: () {
                                          controller.addColor(
                                              controller.currentColor);
                                          controller
                                              .add(VariantColorSelected());
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  width: 150,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColors.lightGrey)),
                                  child: const Center(
                                    child: Text(AppStrings.addColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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

class SizeProduct extends StatelessWidget {
  final int index;

  const SizeProduct({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = VariantBloc.get(context);
    return Column(
      children: [
        CommonTextField(
          title: "${AppStrings.size} ${index + 1}",
          required: true,
        ),
        Row(
          children: const [
            Expanded(
                child: CommonTextField(
              title: AppStrings.price,
              required: true,
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: CommonTextField(
              title: AppStrings.sellingPrice,
              required: false,
            )),
          ],
        ),
        spacer5,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => controller.add(VariantDecrement()),
              child: Text(
                AppStrings.delete,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
          ],
        )
      ],
    );
  }
}
