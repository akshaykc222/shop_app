import 'package:flutter/material.dart';

class MandatoryText extends StatelessWidget {
  final String title;
  final bool? requiredTxt;
  const MandatoryText({Key? key, required this.title, this.requiredTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              //
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        requiredTxt == false
            ? const SizedBox()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    height: 2,
                  )
                ],
              )
      ],
    );
  }
}
