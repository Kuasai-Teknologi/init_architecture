import 'dart:io';

/// A class to run system processes.
class ProcessRunner {
  /// Runs a command with the specified arguments.
  ///
  /// [command] is the command to be executed.
  /// [arguments] is a list of arguments to pass to the command.
  ///
  /// Returns a [Future<ProcessResult>] that completes with the result of the command execution.
  Future<ProcessResult> run(String command, List<String> arguments) async {
    return await Process.run(command, arguments);
  }
}
