import 'dart:convert';
import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

/// A service for handling the Task 1 diagram image file.
class WritingDiagramService {
  /// Writes and saves the diagram image file.
  Future<String> writeTempImage(String diagramData, {String? uuid}) async {
    uuid ??= Uuid().v4();
    final bytes = base64Decode(diagramData);
    final file = File(await getTempFilePath(uuid));
    await file.writeAsBytes(bytes);
    return uuid;
  }

  /// Returns the diagram file path.
  Future<String> getFilePath(String uuid) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, '$uuid.jpg');
  }

  /// Returns the temporary diagram file path.
  Future<String> getTempFilePath(String uuid) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, 'tmp_$uuid.jpg');
  }

  /// Saves the temprary diagram file as the file for persisting.
  Future<void> persistTmpFile(String uuid) async {
    final dirPath = await getApplicationDocumentsDirectory();

    // Rename
    final tmpFile = File(await getTempFilePath(uuid));
    final newPath = p.join(dirPath.path, '$uuid.jpg');
    await tmpFile.rename(newPath);

    // Deletes old temporary files that no longer needed.
    await removeTmpFiles();
  }

  /// Deltes the temporary file.
  Future<void> removeTmpFiles() async {
    final dirPath = await getApplicationDocumentsDirectory();
    final gp = Glob(p.join(dirPath.path, 'tmp_*.jpg'));
    for (final item in gp.listSync()) {
      if (item is File) {
        await item.delete();
      }
    }
  }

  /// Returns true if the persisted diagram file based on uuid, otherwise, false.
  Future<bool> existsFile(String uuid) async {
    final dirPath = await getApplicationDocumentsDirectory();
    final path = p.join(dirPath.path, '$uuid.jpg');
    final file = File(path);
    return await file.exists();
  }
}
