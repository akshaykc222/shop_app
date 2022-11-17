import 'package:flutter/material.dart';
import 'package:shop_app/shop/presentation/widgets/mandatory_text.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  final bool? required;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? widgetLabel;
  final bool? enable;
  final bool? showSuffixIcon;
  final Function(String)? validator;
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
        this.validator
      })
      : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool showSuffixIcon;
  @override
  void initState() {
    showSuffixIcon = widget.showSuffixIcon ?? false;
    super.initState();
  }

  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        setState(() {
          if (!_focusNode.hasFocus) {
            showSuffixIcon = true;
          } else {
            showSuffixIcon = true;
          }
        });
      },
      controller: widget.controller,
      validator:widget.validator==null?null: (val)=>widget.validator!(val??""),
      focusNode: _focusNode,
      decoration: InputDecoration(
          prefix: showSuffixIcon ? widget.prefix : null,
          suffix: widget.suffix,
          label: widget.widgetLabel ??
              (widget.required == true
                  ? MandatoryText(title: widget.title)
                  : Text(widget.title)),
          enabled: widget.enable ?? true),
    );
  }
}
