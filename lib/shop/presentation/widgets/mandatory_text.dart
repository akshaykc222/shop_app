import 'package:flutter/material.dart';

class MandatoryText extends StatelessWidget {
  final String title;

  const MandatoryText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        Column(
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
