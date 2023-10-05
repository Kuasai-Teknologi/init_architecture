import 'package:args/args.dart';
import 'package:init_folder_architecture/init_folder_architecture.dart';

void main(List<String> arguments) {
  final parser = ArgParser()..addOption('init', abbr: 'i', mandatory: true);

  ArgResults result = parser.parse(arguments);

  String dirName = result['init'];

  generateFolder(dirName);
}
