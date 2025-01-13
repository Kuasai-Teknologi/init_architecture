import 'dart:io';

class ProcessRunner {
  Future<ProcessResult> run(String command, List<String> arguments) async {
    return await Process.run(command, arguments);
  }
}
