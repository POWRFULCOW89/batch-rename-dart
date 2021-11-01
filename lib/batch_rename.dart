/// Batch rename files in the current working directory.
library batch_rename;

import 'dart:io' show Directory, Platform;

/// Rename all files that match the [substring] to [newString] in a given [path].
///
/// - If [recursive] is true, then all subdirectories will be searched.
/// - If [numbered] is true, then the files will be renamed to [newString] followed by a number.
Future<int> rename(String path, String substring, String newString,
    bool recursive, bool numbered) async {
  int count = 0;
  final dir = Directory(path);
  var dirExists = await dir.exists();

  if (dirExists) {
    await for (var file in dir.list(recursive: recursive, followLinks: false)) {
      String filename = file.uri.pathSegments.last;
      RegExp regex = RegExp(substring);

      if (regex.hasMatch(filename)) {
        String finalString = numbered ? '$newString${count + 1}' : newString;

        List<String> path = file.uri.pathSegments;
        String newPath = path.sublist(0, path.length - 1).join('/');

        await file.rename(newPath +
            Platform.pathSeparator +
            filename.replaceAll(regex, finalString));

        count++;
      }
    }
  }

  return count;
}
