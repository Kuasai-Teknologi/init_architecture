import 'dart:io';

import 'package:init_architecture/runner_helper.dart';

/// Asynchronously generates a new package repository in the 'packages' directory.
Future<void> generateRepository(String name, ProcessRunner runner) async {
  // Initialize the directory object pointing to 'packages'.
  Directory packages = Directory('packages');

  // Determine the command based on the operating system.
  String command = Platform.isWindows ? 'where' : 'which';

  // Execute the command to find the 'flutter' executable path.
  var path = await runner.run(command, ['flutter']);

  // If the command fails (non-zero exit code), exit the function.
  if (path.exitCode != 0) return;

  // Create the 'packages' directory if it doesn't exist, then create the package.
  packages.create(recursive: true).then((value) {
    // Run the flutter create command synchronously using the found path,
    // specifying the package template and the target directory with the new package name.
    return Process.runSync(path.stdout.trim(),
        ['create', '--template=package', 'packages/${name}_respository']);
  });
}
