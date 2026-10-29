MAD LAB - DART FILES FOR PRACTICALS 1 TO 10

Contents:
- practical_01_flutter_environment_setup.dart
- practical_02_hello_world.dart
- practical_03_common_widgets.dart
- practical_04_registration_form.dart
- practical_05_layout_widgets.dart
- practical_06_icons_images_charts.dart
- practical_07_navigation_and_gestures.dart
- practical_08_file_handling.dart
- practical_09_firebase_firestore.dart
- practical_10_testing_and_deployment.dart
- test/widget_test.dart (sample test for Practical 10)

IMPORTANT:
These are individual practical source files. Most are separate Flutter app entry points;
copy the chosen file's contents into lib/main.dart in a Flutter project to run it.

Extra dependencies:
Practical 6:
  flutter pub add fl_chart
Practical 8:
  flutter pub add path_provider intl
Practical 9:
  flutter pub add firebase_core cloud_firestore
  flutterfire configure
  Ensure lib/firebase_options.dart is generated.

Practical 1 is an environment setup practical and does not have a UI application
in the source document, so its Dart file documents the relevant setup commands.

The uploaded Word document's Experiment 10 sample app is included, with a
sample widget test under test/widget_test.dart. If using the test file in a
project, update the import to match that project's package name in pubspec.yaml.
