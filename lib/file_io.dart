import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileIO {
  var fileName = "temp.txt";

  FileIO(String s) {
    fileName = s;
  }
  // The path locally is below:
  // /Users/zjendex/Library/Developer/CoreSimulator/Devices/1B97F6D9-1648-498A-B6D9-1E119D7392E0/data/Containers/Data/Application/A6B2AF56-3206-4A10-B775-04D07E6F8783/Documents
  Future<String> get _localPath async {
    // Documents directory
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> localPath() async {
    // Documents directory
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> clear() async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString("");
  }

  Future<File> write(String s) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(s);
  }

  Future<File> append(String s) async {
    final file = await _localFile;
    // Write the file
    file.writeAsStringSync(s, mode: FileMode.append);
    return file;
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<List<String>> readByLines() async {
    try {
      final file = await _localFile;

      // Read the file
      List<String> contents = await file.readAsLines();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return List.empty();
    }
  }
}
