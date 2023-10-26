import 'dart:io';

import 'package:init_architecture/files.dart';

// This function generates a folder with the given name if it doesn't already exist.
// It also creates three sub-folders inside the main folder: 'themes', 'core', and 'utils'.
// For each sub-folder, it checks if it already exists, and if not, it creates the sub-folder and generates a file inside it.
// Finally, it calls the 'subFolder' function passing the main folder name as an argument.

/// The [name] parameter is the name of the folder to generate.

void generateFolder(String name) {
  // Create a Directory object with the given name
  Directory root = Directory(name);

  // Check if the directory doesn't exist
  if (!root.existsSync()) {
    // Create the directory recursively
    root.createSync(recursive: true);

    // Generate a file inside the created directory
    generateFile(root.path);

    // Print a success message
    print('Folder $root created successfully');
  } else {
    // If the directory already exists, print a message
    print('Folder $root already exits');
  }

  // Create three additional directories: themes, core, and utils
  Directory themes = Directory('themes');
  Directory core = Directory('core');
  Directory utils = Directory('utils');

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

  // Call the subFolder function with the given name
  subFolder(name);
}

// Define a function named subFolder that takes a string parameter named name
void subFolder(String name) {
  // Create a Directory object named repository with the path '$name/repository'
  Directory repository = Directory('$name/repository');

  // Create a Directory object named modules with the path '$name/modules'
  Directory modules = Directory('$name/modules');

  // Create a Directory object named data with the path '$name/data'
  Directory data = Directory('$name/data');

  // Create the repository directory and its parent directories if they don't exist
  repository
      .create(recursive: true)
      .then((value) => print('Sub Folder $repository created successfully'))
      .catchError((error) => print('Error creating $repository: $error'));

  // Create the modules directory and its parent directories if they don't exist
  modules
      .create(recursive: true)
      .then((value) => print('Sub Folder $modules created successfully'))
      .catchError((error) => print('Error creating $modules: $error'));

  // Create the data directory and its parent directories if they don't exist
  data
      .create(recursive: true)
      .then((value) => print('Sub Folder $data created successfully'))
      .catchError((error) => print('Error creating $data: $error'));
}
