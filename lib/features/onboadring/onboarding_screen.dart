import 'package:docpoint/features/onboadring/widgets/dots_indicator.dart';
import 'package:docpoint/features/onboadring/widgets/get_started_button.dart';
import 'package:docpoint/features/onboadring/widgets/onboarding_page_widget.dart';
import 'package:docpoint/features/onboadring/widgets/pages_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPageWidget(page: pages[index]);
            },
          ),

          if (_currentPage != pages.length - 1)
            DotsIndicator(pageController: _pageController),

          // Get Started Button (only on last page)
          if (_currentPage == pages.length - 1) const GetStartedButton(),

          // Skip Button
          Positioned(
            top: 60.h,
            right: 24.w,
            child: TextButton(
              onPressed: () {
                _pageController.jumpToPage(pages.length - 1);
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: _currentPage == pages.length - 1
                      ? Colors.transparent
                      : const Color(0xFF2A7DBC),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });
}
