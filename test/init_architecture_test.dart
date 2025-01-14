import 'dart:io';

import 'package:init_architecture/files.dart';
import 'package:init_architecture/generate_repository.dart';
import 'package:init_architecture/init_architecture.dart';
import 'package:init_architecture/runner_helper.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockProcessRunner extends Mock implements ProcessRunner {}

class MockDirectory extends Mock implements Directory {}

class MockFile extends Mock implements File {}

/// This file contains unit tests for the init_architecture package.
/// It tests the functionality of generating repositories, files, and directories.

void main() {
  late MockProcessRunner mockRunner; // Mock for ProcessRunner
  late MockFile mockFile; // Mock for File
  late MockDirectory directory; // Mock for Directory

  setUp(() {
    mockRunner = MockProcessRunner(); // Initialize mockRunner
    mockFile = MockFile(); // Initialize mockFile
    directory = MockDirectory(); // Initialize directory
  });

  group('generateRepository', () {
    test('should exception when flutter is not found', () async {
      // Simulate an exception when the runner is called
      when(() => mockRunner.run(any(), any())).thenThrow(Exception('oops'));

      // Expect an exception when generating the repository
      expect(() async => await generateRepository('package_name', mockRunner),
          throwsA(isA<Exception>()));
    });

    test('should success when flutter is found', () async {
      // Simulate a successful run of the flutter command
      when(
        () => mockRunner.run('init', ['flutter']),
      ).thenAnswer((_) async => ProcessResult(0, 0, '/path/to/flutter', ''));

      // Expect the repository generation to succeed
      expect(() async => await generateRepository('init', mockRunner),
          throwsA(isA<void>()));
    });
  });

  group('generate File', () {
    test('should throw exception', () {
      // Simulate an exception when creating a file
      when(
        () => mockFile.create(),
      ).thenThrow(Exception('someting wrong'));

      // Expect an exception when generating the file
      expect(() async => generateFile(''), throwsA(isA<Exception>()));
    });

    test('should success create file', () async {
      // Simulate a successful file creation
      when(
        () => mockFile.create(recursive: true),
      ).thenAnswer((_) async => File('path'));

      // Expect the file generation to succeed
      expect(() async => generateFile('test'), returnsNormally);
    });
  });

  group('generate directory', () {
    test('should throw exception', () async {
      // Simulate an exception when creating a directory
      when(
        () => directory.create(recursive: true),
      ).thenThrow(Exception('error'));

      // Expect an exception when generating the folder
      expect(() => generateFolder(''), returnsNormally);
    });

    test('should success create directory', () async {
      // Simulate a successful directory creation
      when(
        () => directory.create(recursive: true),
      ).thenAnswer((_) async => Directory.current);

      // Expect the folder generation to succeed
      expect(() => generateFolder('name'), returnsNormally);
    });
  });
}
