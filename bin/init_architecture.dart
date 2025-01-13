#!/usr/bin/env dart

import 'package:args/args.dart';
import 'package:init_architecture/init_architecture.dart';

// Main function: Entry point of the Dart script.
void main(List<String> arguments) {
  // Creating an instance of ArgParser to define and parse command-line options.
  final parser = ArgParser()..addOption('init', abbr: 'i', mandatory: true);

  // Parsing the command-line arguments.
  ArgResults result = parser.parse(arguments);

  // Extracting the directory name from the parsed command-line arguments.
  String dirName = result['init'];

  // Calling the generateFolder function to create the directory structure.
  generateFolder(dirName);
}
