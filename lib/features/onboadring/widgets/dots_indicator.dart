import 'package:docpoint/features/onboadring/widgets/pages_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80.h,
      left: 0,
      right: 0,
      child: Center(
        child: SmoothPageIndicator(
          controller: _pageController,
          count: pages.length,
          effect: ExpandingDotsEffect(
            activeDotColor: const Color(0xFF2A7DBC),
            dotColor: Colors.grey,
            dotHeight: 8.h,
            dotWidth: 8.w,
            spacing: 8.w,
          ),
        ),
      ),
    );
  }
}
