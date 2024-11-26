import 'dart:html';
import 'dart:typed_data';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ImageModel{
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final File? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  /// Constructor for ImageModel.
  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    required this.filename,
    this.sizeBytes,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
    this.mediaCategory = '',
  });
}