import 'dart:io';

import 'package:init_folder_architecture/files.dart';

void generateFolder(String name) {
  Directory root = Directory(name);

  if (!root.existsSync()) {
    root.createSync();
    print('Folder $root created successfully');
  } else {
    print('Folder $root already exits');
  }

  Directory themes = Directory('themes');

  if (!themes.existsSync()) {
    themes.createSync();
    generateFile(themes.path);
    print('Folder $themes created successfully');
  } else {
    print('Folder $themes already exits');
  }

  Directory core = Directory('core');

  if (!core.existsSync()) {
    core.createSync();
    generateFile(core.path);
    print('Folder $core created successfully');
  } else {
    print('Folder $core already exits');
  }

  Directory utils = Directory('utils');

  if (!utils.existsSync()) {
    utils.createSync();
    generateFile(utils.path);
    print('Folder $utils created successfully');
  } else {
    print('Folder $utils already exits');
  }

  subFolder(name);
}

void subFolder(String name) {
  Directory repository = Directory('$name/repository');

  if (!repository.existsSync()) {
    repository.createSync();
    print('Sub Folder $repository created successfully');
  } else {
    print('Sub Folder $repository already exits');
  }

  Directory modules = Directory('$name/modules');

  if (!modules.existsSync()) {
    modules.createSync();
    print('Sub Folder $modules created successfully');
  } else {
    print('Sub Folder $modules already exits');
  }

  Directory data = Directory('$name/data');

  if (!data.existsSync()) {
    data.createSync();
    print('Sub Folder $data created successfully');
  } else {
    print('Sub Folder $data already exits');
  }
}
