import 'dart:io';

import 'package:init_architecture/files.dart';
import 'package:init_architecture/generate_repository.dart';
import 'package:init_architecture/runner_helper.dart';

/// Generates a set of directories for a given project structure.
///
/// This function creates the main directories used in a typical Flutter project architecture,
/// including 'themes', 'core', 'utils', and a custom 'packages' directory. Each directory
/// is created recursively, ensuring that all parent directories exist. After creating these
/// directories, it also initializes a new package in the 'packages' directory using Flutter's
/// CLI tools, specifically tailored for repository packages.
///
/// Additionally, this function calls `subFolder` to create more specific subdirectories
/// within the project structure based on the provided [name].
///
/// Errors during directory creation are caught and logged, indicating if a directory
/// already exists.
///
/// Parameters:
///   - [name] : The base name used for creating specific subdirectories and naming the
///              custom package within the 'packages' directory.
///
/// Example usage:
///   generateFolder("my_project");
///
void generateFolder(String name) {
  // Create three additional directories: themes, core, and utils
  Directory themes = Directory('example/lib/themes');
  Directory core = Directory('example/lib/core');
  Directory utils = Directory('example/lib/utils');

  // Create the themes directory and generate a file inside it
  themes
      .create(recursive: true)
      .then((value) => generateFile(value.path))
      .catchError((error) => print('Folder $error already exists'));

  // Create the core directory and generate a file inside it
  core
      .create(recursive: true)
      .then((value) => generateFile(value.path))
      .catchError((error) => print('Folder $error already exists'));

  // Create the utils directory and generate a file inside it
  utils
      .create(recursive: true)
      .then((value) => generateFile(value.path))
      .catchError((error) => print('Folder $error already exists'));

  final runner = ProcessRunner();

  // Create the packages directory and initialize a new package
  generateRepository(name, runner);

  // Call the subFolder function with the given name
  subFolder('lib/$name');
}

/// Creates a set of sub-folders (`repository`, `modules`, and `data`) within the specified main folder.
///
/// The function ensures that the directory structure under `lib/[name]` is created and logs success
/// or error messages for each sub-folder. For example, calling `subFolder('my_app')` will create:
/// - `lib/my_app/repository`
/// - `lib/my_app/modules`
/// - `lib/my_app/data`
///
/// Parameters:
/// - `name`: The name of the main folder where the sub-folders will be created.
void subFolder(String name) {
  // Create a Directory object for the 'repository' sub-folder within the [name] folder.
  Directory repository = Directory('example/$name/repository');

  // Create a Directory object for the 'modules' sub-folder within the [name] folder.
  Directory modules = Directory('example/$name/modules');

  // Create a Directory object for the 'data' sub-folder within the [name] folder.
  Directory data = Directory('example/$name/data');

  // Create the 'repository' directory and its parent directories if they do not exist.
  repository
      .create(recursive: true)
      .then((value) => print('Sub Folder $repository created successfully'))
      .catchError((error) => print('Error creating $repository: $error'));

  // Create the 'modules' directory and its parent directories if they do not exist.
  modules
      .create(recursive: true)
      .then((value) => print('Sub Folder $modules created successfully'))
      .catchError((error) => print('Error creating $modules: $error'));

  // Create the 'data' directory and its parent directories if they do not exist.
  data
      .create(recursive: true)
      .then((value) => print('Sub Folder $data created successfully'))
      .catchError((error) => print('Error creating $data: $error'));
}
