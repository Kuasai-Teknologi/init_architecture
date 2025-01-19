import 'dart:io';

import 'package:init_architecture/runner_helper.dart';

/// Asynchronously generates a new package repository in the 'packages' directory.
///
/// This function uses the Flutter CLI to create a new package repository. It first
/// locates the Flutter executable, ensures the 'packages' directory exists, and then
/// runs the 'flutter create' command to generate the repository.
///
/// Throws:
/// - [Exception] if the Flutter executable cannot be found.
/// - [Exception] if the 'flutter create' command fails.
///
/// Example:
/// ```dart
/// final runner = ProcessRunner();
/// try {
///   await generateRepository('example', runner);
///   print('Repository created successfully!');
/// } catch (e) {
///   print('Failed to create repository: $e');
/// }
/// ```
///
/// Parameters:
/// - `name`: The name of the package repository to create.
/// - `runner`: The process runner used to execute system commands.
Future<void> generateRepository(String name, ProcessRunner runner) async {
  try {
    // Locate the Flutter executable.
    var flutterPath = await runner.run(
      Platform.isWindows ? 'where' : 'which',
      ['flutter'],
    );

    // If the Flutter executable is not found, throw an exception.
    if (flutterPath.exitCode != 0) throw Exception(flutterPath.stderr);

    // Ensure the 'packages' directory exists.
    Directory packages = Directory('packages');
    await packages.create(recursive: true);

    // Run the 'flutter create' command to generate the repository.
    final result = await Process.run(
      flutterPath.stdout.trim(),
      ['create', '--template=package', 'packages/${name}_repository'],
    );

    // If the command fails, throw an exception with the error message.
    if (result.exitCode != 0) throw Exception(result.stderr);
  } catch (e) {
    rethrow;
  }
}
