import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/core/utils/print_utils.dart';

enum TYPE { CAMERA, VIDEO, MULTI_IMAGE, PICK_FILE, PICK_FILES }

class FilePickerUtils {
  static List<String> IMAGE = ["jpg", "png", "jpeg"];
  static List<String> PDF = ["pdf"];
  static List<String> AUDIO = ["mp3"];
  static List<String> VIDEO = ["mp4", "mpeg"];

  static void pickFiles(
      {TYPE type = TYPE.PICK_FILE,
      bool allowCompression = false,
      FileType fileType = FileType.any,
      List<String> customExtensions = const [],
      CameraDevice preferredCameraDevice = CameraDevice.rear,
      double? maxWidth,
      double? maxHeight,
      Duration? maxDuration,
      int imageQuality = 100,
      required Function(List<File>) onSelectedFiles}) async {
    //

    List<File> files = [];
    if (type == TYPE.PICK_FILE || type == TYPE.PICK_FILES) {
      bool allowMultiple = type == TYPE.PICK_FILES ? true : false;
      FilePickerResult? result;
      if (fileType == FileType.custom && customExtensions.isNotEmpty) {
        result = await FilePicker.platform
            .pickFiles(type: fileType, allowCompression: allowCompression, allowMultiple: allowMultiple, allowedExtensions: customExtensions);
      } else {
        result = await FilePicker.platform.pickFiles(type: fileType, allowCompression: allowCompression, allowMultiple: allowMultiple);
      }

      if (result != null && result.files.isNotEmpty) {
        if (allowMultiple) {
          //List<File> _files = result.paths.map((path) => File(path!)).toList();
          List<PlatformFile> _listPlatformFiles = result.files;
          List<File> _files = [];
          for (int i = 0; i < _listPlatformFiles.length; i++) {
            _files.add(File(_listPlatformFiles[i].path!));
          }
          //
          files = [];
          files.addAll(_files);
          //
        } else {
          PlatformFile _platformFile = result.files.first;
          File _file = File(_platformFile.path!);
          //
          files = [];
          files.add(_file);
          //

          Print.Reference(_platformFile.name);
          Print.Reference(_platformFile.bytes);
          Print.Reference(_platformFile.size);
          Print.Reference(_platformFile.extension);
          Print.Reference(_platformFile.path);
        }
      }
    } else {
      final ImagePicker imagePicker = ImagePicker();
      List<XFile>? xFiles = [];

      if (type == TYPE.CAMERA) {
        if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
          XFile? xFile = await imagePicker.pickImage(
              source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, imageQuality: imageQuality, maxHeight: maxHeight, maxWidth: maxWidth);

          if (xFile != null) {
            xFiles = [];
            xFiles.add(xFile);
          }
        } else {
          XFile? xFile =
              await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, imageQuality: imageQuality);
          if (xFile != null) {
            xFiles = [];
            xFiles.add(xFile);
          }
        }
      } else if (type == TYPE.VIDEO) {
        if (maxDuration != null && maxDuration.inSeconds > 0) {
          XFile? xFile =
              await imagePicker.pickVideo(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice, maxDuration: maxDuration);
          if (xFile != null) {
            xFiles = [];
            xFiles.add(xFile);
          }
        } else {
          XFile? xFile = await imagePicker.pickVideo(source: ImageSource.camera, preferredCameraDevice: preferredCameraDevice);
          if (xFile != null) {
            xFiles = [];
            xFiles.add(xFile);
          }
        }
      } else if (type == TYPE.MULTI_IMAGE) {
        if (maxWidth != null && maxHeight != null && maxWidth > 100 && maxHeight > 100) {
          xFiles = await imagePicker.pickMultiImage(maxWidth: maxWidth, maxHeight: maxHeight, imageQuality: imageQuality);
        } else {
          xFiles = await imagePicker.pickMultiImage(imageQuality: imageQuality);
        }
      }

      if (xFiles != null && xFiles.isNotEmpty) {
        files = [];
        for (int i = 0; i < xFiles.length; i++) {
          File cacheFile = File(xFiles[i].path);
          File? file = await saveFile(DateTime.now().toString() + (type == TYPE.VIDEO ? ".mp4" : ".jpg"), await cacheFile.readAsBytes());
          if (file != null) {
            deleteFile(cacheFile.path);
            files.add(file);
          }
        }
      }
    }

    onSelectedFiles(files);
  }

  static Future<String> getFileSizeUsingPath({required String filePath, int decimals = 0}) async {
    if (filePath.isNotEmpty && filePath.trim().length > 0) {
      File file = File(filePath);
      int bytes = await file.length();
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1000)).floor();
      return ((bytes / pow(1000, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
    } else {
      return "0 B";
    }
  }

  static Future<String> getFileSizeUsingFile({required File file, int decimals = 0}) async {
    if (file.path.isNotEmpty && file.path.trim().length > 0) {
      int bytes = await file.length();
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1000)).floor();
      return ((bytes / pow(1000, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
    } else {
      return "0 B";
    }
  }

  static Future<String> getFileSizeFromBytes({required int bytes, int decimals = 0}) async {
    if (bytes >= 0) {
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1000)).floor();
      return ((bytes / pow(1000, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
    } else {
      return "0 B";
    }
  }

  static int getDownloadUploadPercentage({int count = 0, int total = 0}) {
    return (100 * count) ~/ total;
  }

  static Future<File?> saveFile(String fileName, List<int> bytes) async {
    /*
    getApplicationDocumentsDirectory():
    Gives path to the directory where Application can place it’s private files, Files only get wiped out when application itself removed.
    iOS – NSDocumentsDirectory API.
    Android – returns AppData directory.

    final directory = await getApplicationDocumentsDirectory();
    */

    Directory? appDocumentsDirectory = await getExternalStorageDirectory(); // 1
    try {
      if (appDocumentsDirectory != null) {
        String appDocumentsPath = appDocumentsDirectory.path; // 2
        String filePath = '$appDocumentsPath/$fileName'; // 3

        Print.Reference("File path $filePath");

        if (await File(filePath).exists()) {
          await deleteFile(filePath);
        }

        File file = File(filePath); // 1
        file.writeAsBytesSync(bytes); // 2
        Print.Reference("saved file path: ${file.path}");
        return file;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<int?> deleteFile(String path) async {
    try {
      File file = File(path);

      await file.delete();
      Print.Reference("Deleted file path: ${file.path}");
    } catch (e) {
      return 0;
    }
  }
}
