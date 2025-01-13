import 'dart:io';

/// Finds the installation path of Flutter on the operating system being used.
///
/// This function uses the `where` command on Windows or `which` on Unix-like systems
/// to locate the Flutter executable. The function will return the path as a string
/// if found, or `null` if not found or an error occurs.
///
/// Returns:
///   String? - The installation path of Flutter or `null` if not found or an error occurs.
///
/// Throws:
///   - Will print an error message if an exception occurs during the path search.
Future<String?> findFlutterPath() async {
  try {
    String command = Platform.isWindows ? 'where' : 'which';
    var path = await Process.run(command, ['flutter']);
    if (path.exitCode == 0) {
      return path.stdout.trim();
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}
