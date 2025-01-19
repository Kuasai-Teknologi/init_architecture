import 'dart:io';

/// Generates a Dart file with the specified name.
///
/// This function creates a file named `index.dart` inside a folder with the provided
/// `name` and writes predefined content based on the `name` value. If the file already
/// exists, no new content is written, and a message is logged instead.
///
/// - For `name` set to `'app'`, the file contains sample exports for repository, modules,
///   and data files.
/// - For other names, the file contains a generic export statement.
///
/// Example:
/// ```dart
/// generateFile('app');
/// ```
///
/// Parameters:
/// - `name`: The name of the folder where the file will be created.
void generateFile(String name) {
  // Create a File object with the given name and path
  File fileName = File('$name/index.dart');

  // Initialize a variable to store the content of the file
  String content = "";

  // Check the value of the name parameter using a switch statement
  switch (name) {
    // If name is 'app', set the content variable with specific comments
    case 'app':
      content =
          "// export 'repository/name_file.dart';\n// export 'modules/name_file.dart';\n// export 'data/name_file.dart';";
      break;

    // For any other name, set the content variable with a generic comment
    default:
      content = "// export 'file_name.dart';";
  }

  // Check if the file already exists
  if (!fileName.existsSync()) {
    // If the file doesn't exist, create it and its parent directories
    fileName.createSync(recursive: true);

    // Write the content to the file
    fileName.writeAsStringSync(content);

    // Print a success message
    print('File $fileName created successfully');
  } else {
    // If the file already exists, print a message
    print('File $fileName already exists');
  }
}
