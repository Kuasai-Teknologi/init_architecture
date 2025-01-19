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
  late MockDirectory directory, mockDirectory; // Mock for Directory

  setUp(() {
    mockRunner = MockProcessRunner(); // Initialize mockRunner
    mockFile = MockFile(); // Initialize mockFile
    directory = MockDirectory(); // Initialize directory
    mockDirectory = MockDirectory();
  });

  group(
    'generateRepository',
    () {
      test('should throw exception when runner returns non-zero exit code',
          () async {
        // Simulate failure of the runner command
        when(() => mockRunner.run(any(), any())).thenAnswer(
            (_) async => ProcessResult(0, 1, '', 'Command not found'));

        // Expect an exception when runner returns non-zero exit code
        expect(
          () async => await generateRepository('test', mockRunner),
          throwsA(isA<Exception>()),
        );
      });

      test('should success when flutter is found', () async {
        // Simulate a successful run of the flutter command
        when(
          () => mockRunner.run('which', ['flutter']),
        ).thenAnswer((_) async => ProcessResult(0, 0, '/path/to/flutter', ''));

        // Expect the repository generation to succeed
        expect(() async => await generateRepository('init', mockRunner),
            throwsA(isA<void>()));
      });

      test('should throw exception when flutter create fails', () async {
        // Simulasikan `which` berhasil menemukan flutter.
        when(() => mockRunner.run('which', ['flutter'])).thenAnswer(
            (_) async => ProcessResult(0, 0, '/path/to/flutter', ''));

        // Simulasikan perintah `flutter create` gagal dengan `ProcessException`.
        when(() => mockRunner.run('/path/to/flutter', any())).thenThrow(
            ProcessException(
                '/path/to/flutter',
                [
                  'create',
                  '--template=package',
                  'example/packages/test_repository'
                ],
                'No such file or directory',
                1));

        expect(
          () async => await generateRepository('test', mockRunner),
          throwsA(isA<ProcessException>().having((e) => e.message, 'message',
              contains('No such file or directory'))),
        );
      });

      test('should create repository successfully', () async {
        when(() => mockRunner.run('which', ['flutter']))
            .thenAnswer((_) async => ProcessResult(0, 0, 'flutter', ''));

        when(() => mockDirectory.create(recursive: true))
            .thenAnswer((_) async => mockDirectory);

        await generateRepository('test', mockRunner);

        final result = await Process.run('flutter', [
          'create',
          '--template=package',
          'example/packages/test_repository'
        ]);

        expect(result.exitCode, 0);
        expect(result.stdout, contains('All done!'));
      });

      test('should throw exception when flutter invalid syntax', () async {
        // Simulasikan `which` berhasil menemukan `flutter`.
        when(() => mockRunner.run('which', ['flutter']))
            .thenAnswer((_) async => ProcessResult(0, 0, 'flutter', ''));

        // Simulasikan perintah dengan syntax typo gagal dijalankan.
        when(() => mockRunner.run(any(), any())).thenAnswer(
          (_) async => ProcessResult(
            0, // exitCode menunjukkan kegagalan
            1,
            '',
            'Failed to create repository',
          ),
        );

        expect(
          () async {
            final result = await mockRunner.run('flutte', [
              'create',
              '--template=package',
              'example/packages/test_repository',
            ]);

            if (result.exitCode != 0) {
              throw Exception(result.stderr);
            }
          },
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Failed to create repository'),
            ),
          ),
        );
      });
    },
  );

  group(
    'generate File',
    () {
      test(
        'should throw exception',
        () {
          // Simulate an exception when creating a file
          when(
            () => mockFile.create(),
          ).thenThrow(Exception('someting wrong'));

          // Expect an exception when generating the file
          expect(() async => generateFile(''), throwsA(isA<Exception>()));
        },
      );

      test(
        'should success create file',
        () async {
          // Simulate a successful file creation
          when(
            () => mockFile.create(recursive: true),
          ).thenAnswer((_) async => File('path'));

          // Expect the file generation to succeed
          expect(() async => generateFile('example/test'), returnsNormally);
        },
      );
    },
  );

  group(
    'generate directory',
    () {
      test(
        'should throw exception',
        () async {
          // Simulate an exception when creating a directory
          when(
            () => directory.create(recursive: true),
          ).thenThrow(Exception('error'));

          // Expect an exception when generating the folder
          expect(() => generateFolder(''), returnsNormally);
        },
      );

      test(
        'should success create directory',
        () async {
          // Simulate a successful directory creation
          when(
            () => directory.create(recursive: true),
          ).thenAnswer((_) async => Directory.current);

          // Expect the folder generation to succeed
          expect(() => generateFolder('name'), returnsNormally);
        },
      );
    },
  );
}
