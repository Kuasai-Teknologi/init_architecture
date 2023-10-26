import 'dart:io';

import 'package:init_architecture/files.dart';
import 'package:test/test.dart';

void main() {
  // Group of unit tests for generating a file
  group('unit test generate file', () {
    // Test case: create a new file successfully
    test('generateFile create a new file successfully', () {
      // Create a test directory
      final directoryName = 'test_directory';

      // Create a file path within the test directory
      final fileName = '$directoryName/$directoryName.dart';

      // Create the file
      File(fileName).createSync(recursive: true);

      // Insert file content
      File(fileName).writeAsStringSync("// export '$fileName' ");

      // Create the test directory
      Directory(directoryName).createSync(recursive: true);

      // Call the generateFile function
      generateFile(directoryName);

      // Assert that the file exists
      expect(File(fileName).existsSync(), isTrue);
    });

// Test case: prints a message if the file already exists
    test('generateFile prints a message if the file already exists', () async {
      // Set up test data
      final directoryName = 'test_directory';
      final fileName = '$directoryName/$directoryName.dart';

      // Create the file and directory
      File(fileName).createSync(recursive: true);

      // Call the method being tested
      generateFile(directoryName);

      // Check if the file contains the expected message
      expect(await File(fileName).readAsString(),
          contains("// export '$fileName' "));
    });
  });
}
