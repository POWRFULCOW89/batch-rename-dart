import 'dart:io' show Directory, Platform;

Future rename(String path, String substring, String newString, bool recursive,
    bool numbered) async {
  int count = 0;
  final dir = Directory(path);
  var dirExists = await dir.exists();

  if (dirExists) {
    await for (var file in dir.list(recursive: recursive, followLinks: false)) {
      String filename = file.uri.pathSegments.last;
      // List<String> filename = file.uri.pathSegments.last.split('.');

      // if (filename.length < 2 && !recursive) continue;
      // print(filename);

      // String name = filename[0];
      // String ext = filename[1];
      RegExp regex = RegExp(substring);

      if (regex.hasMatch(filename)) {
        String finalString = numbered ? '$newString$count' : newString;

        List<String> path = file.uri.pathSegments;
        String newPath = path.sublist(0, path.length - 1).join('/');

        // print(
        //     'Path: ${path.join('/')} | NewPath: $newPath | name: $name');

        await file.rename(newPath +
            Platform.pathSeparator +
            filename.replaceAll(regex, finalString));

        count++;
      }
    }
  }

  return count;
}
