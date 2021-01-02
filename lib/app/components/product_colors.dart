import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductColors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Color(0xFFFFC107),
          Color(0xFF4CAF50),
          Color(0xFF5E35B1),
          Color(0xFFE91E63),
          Color(0xFF3F51B5)
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: e,
                      shape: BoxShape.circle
                    ),

                  ),
                ))
            .toList(),
      ),
    );
  }
}
