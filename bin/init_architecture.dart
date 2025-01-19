#!/usr/bin/env dart

import 'package:args/args.dart';
import 'package:init_architecture/init_architecture.dart';

/// The main entry point of the Dart script.
/// Provides a CLI for generating folder architectures or package repositories.
///
/// Parameters:
/// - `arguments`: Command-line arguments passed to the script.
///
/// Commands:
/// - `--init <project_name>`: Initializes a complete project folder architecture.
/// - `--packages <package_name>`: Creates a template package repository.
///
/// Example Usage:
/// ```bash
/// dart script.dart --init my_project
/// dart script.dart --packages my_package
/// ```
void main(List<String> arguments) {
  // Creating an instance of ArgParser to define and parse command-line options.
  final parser = ArgParser()
    ..addOption(arguments.first.replaceFirst('--', ''),
        abbr: 'i', mandatory: true);

  // Parsing the command-line arguments.
  ArgResults result = parser.parse(arguments);

  switch (arguments.first) {
    case '--init':
      // Generate architecture folder including template package
      String dirName = result['init'];

      generateFolder(dirName);
      break;
    case '--packages':
      // Generate template packages repository only
      final runner = ProcessRunner();
      String packageName = result['packages'];
      generateRepository(packageName, runner);
      break;
    default:
      print('Invalid command. Available commands are: --init, --packages');
  }
}
