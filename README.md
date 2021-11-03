# batch_rename

A CLI tool to enable batch renaming of files.

## Installation

1. Clone the repo and add `bin/batch_rename.exe` to PATH:

    ```batch
    gh repo clone POWRFULCOW89/batch_rename
    ```

    or

2. Get the pub package:

    ``` batch
    dart pub add batch_rename
    ```

    and build from source:

    ```batch
    dart compile exe .\bin\batch_rename.dart
    ```

    or

3. Grab a prebuilt [binary](https://github.com/POWRFULCOW89/batch-rename-dart).

## Usage

```batch
batch-rename.exe substring [new_string] [-h] [-n] [-r]

positional arguments:
   substring   Substring to strip or replace out of every file in path.
   new_string  String to replace for every matching substring. Defaults to an empty string.

optional arguments:
   -h, --help  show this help message and exit.
   -n          Rename all files to substring and number them accordingly.
   -r          Batch rename recursively in subdirectories.

```

### Examples

1. Output a standard set from `favicon.png`:

    ```batch
    batch_rename favicon.png 
    ```

2. Output the standard, Apple and Windows 10 sets from `logo.jpg`:

    ```batch
    batch_rename logo.jpg -a -w
    ```

3. Strip all brackets and their content:

    ```batch
    batch_rename "\[.+\]" 
    ```