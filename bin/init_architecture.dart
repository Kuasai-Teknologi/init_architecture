#!/usr/bin/env dart

import 'package:args/args.dart';
import 'package:init_architecture/generate_repository.dart';
import 'package:init_architecture/init_architecture.dart';
import 'package:init_architecture/runner_helper.dart';

// Main function: Entry point of the Dart script.
void main(List<String> arguments) {
  // Creating an instance of ArgParser to define and parse command-line options.
  final parser = ArgParser()
    ..addOption(arguments.first.replaceFirst('--', ''),
        abbr: 'i', mandatory: true);

  // Parsing the command-line arguments.
  ArgResults result = parser.parse(arguments);

  switch (arguments.first) {
    case '--init':
      // Generate architecture folder include with template package
      String dirName = result['init'];

      generateFolder(dirName);
      break;
    case '--packages':
      // Generate template packages repository only
      final runner = ProcessRunner();
      String packageName = result['packages'];
      generateRepository(packageName, runner);
      break;
  }
}
