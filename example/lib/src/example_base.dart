import 'package:init_architecture/generate_repository.dart';
import 'package:init_architecture/init_architecture.dart';
import 'package:init_architecture/runner_helper.dart';

void main() {
  /// Example usage of the generateRepository and generateFolder
  /// or you can just hit init --init name_directory or init --packages name_repository, more details on readme.md
  const repositoryName = 'my_app_repository';
  const directoryName = 'App';

  final runner = ProcessRunner();

  generateFolder(directoryName);

  generateRepository(repositoryName, runner);
}
