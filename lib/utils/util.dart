import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {

  static void appMarket({required String applicationId, required String iOSBundleId}) async {
    if (Platform.isAndroid) {
      var url = Uri.parse("market://details?id=$applicationId");
      launchUrl(url);
    }
    if (Platform.isIOS) {
      var url = Uri.parse("itms-apps://itunes.apple.com/app/id$iOSBundleId");
      launchUrl(url);
    }
  }

  static String hideMobile(String mobile) {
    if (mobile.length > 4) {
      try {
        return mobile.replaceFirst(RegExp(r'\d{4}'), '****', 3);
      } catch (e) {
        return mobile;
      }
    }
    return mobile;
  }

  ///RepaintBoundary
  static Future<ui.Image> getBoundaryImage({required GlobalKey repaintboundaryKey}) async {
    var context = repaintboundaryKey.currentContext!;
    RenderRepaintBoundary renderObject = context.findRenderObject() as RenderRepaintBoundary;
    return renderObject.toImage(pixelRatio: MediaQuery.of(context).devicePixelRatio);
  }

  static Future<Uint8List> getBoundaryImageBinary({required ui.Image image}) async {
    var byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    return byteData;
  }

  ///RepaintBoundary.key.context
  static saveScreenHost2Gallery(GlobalKey repaintboundaryKey, {Function(bool res)? done, Function()? error}) async {
    var byteData = await getBoundaryImageBinary(image: await getBoundaryImage(repaintboundaryKey: repaintboundaryKey));
    savePic2Gallery(byteData, done: done, error: error);
  }

  static savePic2Gallery(Uint8List byteData, {Function(bool res)? done, Function()? error}) async {
    var permission = await Permission.storage.request();
    if (!permission.isGranted) {
      error?.call();
      return;
    }
    var res = await ImageGallerySaver.saveImage(byteData, quality: 100);
    done?.call(res['isSuccess'] == true);
  }

  ///将本地文件存储到媒体库
  static Future saveFile2Gallery(String filePath, {String? name, bool isReturnPathOfIOS = false}) async {
    await ImageGallerySaver.saveFile(filePath, name: name, isReturnPathOfIOS: isReturnPathOfIOS);
  }
}
