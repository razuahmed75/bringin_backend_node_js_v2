
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../res/app_font.dart';

class ImageAndText extends StatelessWidget {
  final String imagePath, text;
  final AlignmentGeometry alignment;
  final bool isSeeker;
  final Widget botton;

  const ImageAndText({
    super.key,
    required this.imagePath,
    required this.text,
    required this.alignment,
    required this.isSeeker,
    required this.botton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(12),
            CircleAvatar(
                radius: 90.r,
                backgroundColor: Color(0xFFD9D9D9),
                backgroundImage: AssetImage(imagePath),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                     isSeeker
            ? Positioned(
                top: -10.h,
                left: -30.w,
                child: Container(   
                  height: 72.h,
                  width: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/loginimg5.png",
                        ),
                        fit: BoxFit.fitHeight
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Styles.bodySmall1
                    ),
                  ),
                      
                ))
            : Positioned(
                top: -30.h,
                right: -30.w,
                child: Container(
                    height: 67.h,
                    width: 127.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/loginomg4.png",
                          ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.w,top: 6.h),
                      child: Text(text,
                          style: Styles.bodySmall1),
                    ),
                        )),
                  ],
                ),
              ),
        SizedBox(height: 15.h),
        botton,
      ],
    );
  }
}
