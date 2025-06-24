import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../navigation/custom_navigation.dart';
import '../../extensions/extensions.dart';

abstract class ImagePickerHelper {
  static showOption({ValueChanged<File?>? onGet}) {
    showDialog(
      context: CustomNavigator.context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Center(child: Text('Select Image Source'.tr)),
          actions: [
            CupertinoDialogAction(
                child: Text('Gallery'.tr),
                onPressed: () => openGallery(onGet: onGet)),
            CupertinoDialogAction(
                child: Text('Camera'.tr),
                onPressed: () => openCamera(onGet: onGet)),
          ],
        );
      },
    );
  }

  static openGallery({ValueChanged<File>? onGet}) async {
    CustomNavigator.pop();
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    onGet!(File(image!.path));
  }

  static openCamera({ValueChanged<File>? onGet}) async {
    CustomNavigator.pop();
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    onGet!(File(image!.path));
  }
}
