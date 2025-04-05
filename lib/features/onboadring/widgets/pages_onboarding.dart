import 'dart:ui';

import 'package:docpoint/features/onboadring/onboarding_screen.dart';

final List<OnboardingPage> pages = [
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
