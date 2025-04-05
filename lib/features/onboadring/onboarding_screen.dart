import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Find Trusted Doctors",
      description:
          "Connect with verified healthcare professionals near you with just a few taps.",
      image: "assets/doctor-search.jpg",
      color: const Color(0xFF2A7DBC),
    ),
    OnboardingPage(
      title: "Instant Appointments",
      description:
          "Book same-day or future appointments 24/7 without the phone calls.",
      image: "assets/calendar.jpg",
      color: const Color(0xFF4CAF50),
    ),
    OnboardingPage(
      title: "Health at Your Fingertips",
      description:
          "Access your medical records, prescriptions, and test results all in one place.",
      image: "assets/health_records.jpg",
      color: const Color(0xFF9C27B0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize screenutil
    ScreenUtil.init(
      context,
      designSize: const Size(
          360, 690), // Standard design size (e.g., based on Figma design)
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPageWidget(page: _pages[index]);
            },
          ),

          // Page Indicator
          Positioned(
            bottom: 80.h,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: const Color(0xFF2A7DBC),
                  dotColor: Colors.grey,
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  spacing: 8.w,
                ),
              ),
            ),
          ),

          // Get Started Button (only on last page)
          if (_currentPage == _pages.length - 1)
            Positioned(
              bottom: 30.h,
              left: 24.w,
              right: 24.w,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to main app
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A7DBC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  minimumSize: Size(double.infinity, 56.h),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          // Skip Button
          Positioned(
            top: 60.h,
            right: 24.w,
            child: TextButton(
              onPressed: () {
                _pageController.jumpToPage(_pages.length - 1);
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: _currentPage == _pages.length - 1
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

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h), // Top padding

          // Image
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(page.image),
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 40.h),

          // Title
          Text(
            page.title,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: page.color,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16.h),

          // Description
          Text(
            page.description,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black54,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(), // Pushes content up
        ],
      ),
    );
  }
}
