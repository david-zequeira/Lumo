import 'package:flutter/material.dart';
import 'package:lumo/app/app.dart';
import 'package:lumo/home/home.dart';
import 'package:lumo/onboarding/onboarding.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  return switch (state) {
    AppStatus.onboardingRequired => [OnboardingPage.page()],
    AppStatus.unauthenticated => [HomePage.page()],
    AppStatus.authenticated => [HomePage.page()],
  };
}
