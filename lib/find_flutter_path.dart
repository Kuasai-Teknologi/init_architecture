import 'dart:io';

Future<String?> findFlutterPath() async {
  try {
    String command = Platform.isWindows ? 'where' : 'which';
    var path = await Process.run(command, ['flutter']);
    if (path.exitCode == 0) {
      return path.stdout.trim();
    }
  } catch (e) {
    print('error nih $e');
  }
  return null;
}
