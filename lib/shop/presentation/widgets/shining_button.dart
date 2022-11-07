import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/app_strings.dart';

class ShiningButton extends StatelessWidget {
  final String title;
  final  Function onTap;
  const ShiningButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.deepOrange.shade600,
            highlightColor: Colors.white.withOpacity(0.4),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.deepOrange.shade600,
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      AppStrings.addNewProduct,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              // left: (MediaQuery.of(context).size.width * 0.6) / 5,
              left: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.center,
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18)),
              ))
        ],
      ),
    );
  }
}
