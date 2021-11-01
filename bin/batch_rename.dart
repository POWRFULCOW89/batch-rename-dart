import 'package:batch_rename/batch_rename.dart' as batch_rename;
import 'package:args/args.dart' show ArgParser, ArgResults;

// usage: batch-rename.exe substring [new_string] [-h] [-n] [-r] [-p]

/// Batch rename files, stripping a given substring

/// positional arguments:
//   path        Path to directory with files to rename. Defaults to current working directory.
///   substring   Substring to strip or replace out of every file in path.
///   new_string  String to replace for every matching substring. Defaults to an empty string.
/// optional arguments:
///   -h, --help  show this help message and exit.
///   -n          Rename all files to substring and number them accordingly.
///   -r          Batch rename recursively in subdirectories.

void usage() {
  print("""

usage: batch-rename.exe substring [new_string] [-h] [-n] [-r]

Batch rename files, stripping a given substring

positional arguments:
path        Path to directory with files to rename. Defaults to current working directory.
substring   Substring to strip or replace out of every file in path.
new_string  String to replace for every matching substring. Defaults to an empty string.
  """);
}

void main(List<String> arguments) async {
  ArgParser parser = ArgParser(allowTrailingOptions: true);

  parser.addFlag('numbered',
      abbr: 'n',
      help: 'Rename all files to substring and number them accordingly.',
      negatable: false);
  parser.addFlag('help',
      abbr: 'h', help: 'Shows the CLI usage.', negatable: false);
  parser.addFlag('recursive',
      abbr: 'r',
      help: 'Recursively rename files in subdirectories.',
      negatable: false);

  ArgResults args = parser.parse(arguments);

  // print(args.arguments);
  // print(args.rest);

  if (args.rest.length > 2) {
    print('Too many arguments.');
    usage();
    print(parser.usage);
  } else if (args.rest.isEmpty) {
    print('No arguments provided.');
    usage();
    print(parser.usage);
  } else {
    String substring = args.rest[0];
    String newString = args.rest.length == 2 ? args.rest[1] : '';
    bool numbered = args['numbered'];
    bool recursive = args['recursive'];
    bool help = args['help'];
    String path = '';
    // String path = './';

    if (help) {
      print(parser.usage);
    } else {
      int count = await batch_rename.rename(
          path, substring, newString, recursive, numbered);

      if (count > 1) {
        print('Successfully renamed $count files.');
      } else {
        print('No files renamed.');
      }
    }
  }
}
