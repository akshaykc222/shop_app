import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/utils/app_constants.dart';
import 'package:shop_app/shop/presentation/widgets/mandatory_text.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  final bool? required;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? widgetLabel;
  final TextInputType? textInputType;
  final bool? enable;
  final bool? showSuffixIcon;
  final Function(String)? validator;
  final bool? passwordField;
  // final FocusNode focusNode;
  const CommonTextField(
      {Key? key,
      required this.title,
      this.prefix,
      this.required,
      this.suffix,
      this.widgetLabel,
      this.enable,
      this.showSuffixIcon,
      this.controller,
      this.validator,
      this.textInputType,
      this.passwordField})
      : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool showPrefixIcon;
  bool showPassword = false;
  @override
  void initState() {
    showPrefixIcon = widget.showSuffixIcon ?? false;
    super.initState();
  }

  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: MandatoryText(title: widget.title),
          ),
        ),
        spacer10,
        TextFormField(
          onTap: () {
            setState(() {
              if (!_focusNode.hasFocus) {
                showPrefixIcon = true;
              } else {
                showPrefixIcon = true;
              }
            });
          },
          controller: widget.controller,
          validator: widget.validator == null
              ? null
              : (val) => widget.validator!(val ?? ""),
          focusNode: _focusNode,
          obscureText: showPassword,
          keyboardType: widget.textInputType ?? TextInputType.text,
          decoration: InputDecoration(
              prefixIcon: showPrefixIcon ? widget.prefix : null,
              suffixIcon: widget.passwordField == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: showPassword
                          ? const Icon(Icons.abc_sharp)
                          : const Icon(Icons.remove_red_eye))
                  : widget.suffix,
              label: widget.widgetLabel ?? Text(widget.title),
              enabled: widget.enable ?? true),
        ),
      ],
    );
  }
}
