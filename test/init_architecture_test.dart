import 'dart:io';

import 'package:init_architecture/files.dart';
import 'package:init_architecture/generate_repository.dart';
import 'package:init_architecture/runner_helper.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockProcessRunner extends Mock implements ProcessRunner {}

class MockDirectory extends Mock implements Directory {}

void main() {
  // Group of unit tests for generating a file

  group('generate Repository', () {
    late MockProcessRunner mockRunner;

    setUp(() {
      mockRunner = MockProcessRunner();
    });
    test('should not proceed if flutter executable is not found', () async {
      // Setel mockRunner.run agar menghasilkan output Future<ProcessResult>
      when(mockRunner.run('/path/to/flutter', ['arg1', 'arg2'])).thenReturn(
          Future.value(ProcessResult(0, 1, '', 'No flutter found')));

      // Jalankan fungsi yang memanggil mockRunner.run
      await mockRunner.run('/path/to/flutter', ['arg1', 'arg2']);

      // Verifikasi bahwa mockRunner.run dipanggil
      verify(mockRunner.run('/path/to/flutter', ['arg1', 'arg2'])).called(1);
    });

    test('should create package if flutter executable is found', () async {
      // Set up mock to return a valid flutter path.
      when(mockRunner.run(
        Platform.isWindows ? 'where' : 'which',
        ['flutter'],
      )).thenAnswer((_) async => ProcessResult(0, 0, '/path/to/flutter', ''));

      // Mock the directory creation process.
      final mockDirectory = MockDirectory();
      when(mockDirectory.create(recursive: true))
          .thenAnswer((_) async => mockDirectory);

      // Call the function.
      await generateRepository('test', mockRunner);

      // Verify flutter create is called with the correct arguments.
      verify(mockRunner.run('/path/to/flutter', [
        'create',
        '--template=package',
        'packages/test_respository'
      ])).called(1);
    });
  });
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
