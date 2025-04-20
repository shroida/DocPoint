import 'dart:ui';

import 'package:docpoint/features/onboadring/onboarding_screen.dart';

final List<OnboardingPage> pages = [
  OnboardingPage(
    title: "Connect with Trusted Doctors",
    description:
        "Easily find and connect with verified healthcare professionals tailored to your needs.",
    image: "assets/doctor-search.jpg",
    color: const Color(0xFF2A7DBC),
  ),
  OnboardingPage(
    title: "Schedule Appointments Instantly",
    description:
        "Book same-day or future appointments anytime without the hassle of phone calls.",
    image: "assets/calendar.jpg",
    color: const Color(0xFF4CAF50),
  ),
  OnboardingPage(
    title: "Your Health Records Accessible Anytime",
    description:
        "Securely access your medical records, prescriptions, and test results from your device.",
    image: "assets/health_records.jpg",
    color: const Color(0xFF9C27B0),
  ),
];
