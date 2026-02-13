import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class WritingDiagramService {
  Future<String> writeTempImage(String diagramData, {String? uuid}) async {
    uuid ??= Uuid().v4();
    final bytes = base64Decode(diagramData);
    final file = File(await getTempFilePath(uuid));
    await file.writeAsBytes(bytes);
    return uuid;
  }

  Future<String> getFilePath(String uuid) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, '$uuid.jpg');
  }

  Future<String> getTempFilePath(String uuid) async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, 'tmp_$uuid.jpg');
  }
}
