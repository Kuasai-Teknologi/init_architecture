import 'dart:io';

void generateFile(String name) {
  File fileName = File('$name/$name.dart');
  if (!fileName.existsSync()) {
    var content = "// export '${fileName.path}' ";
    fileName.createSync();
    fileName.writeAsStringSync(content);
    print('File $fileName created successfully');
  } else {
    print('File $fileName already exits');
  }
}
