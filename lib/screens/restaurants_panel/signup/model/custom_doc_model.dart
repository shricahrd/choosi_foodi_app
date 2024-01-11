import 'dart:io';

class ImageUpload {
  File localImageFile;
  String? imageName;
  bool isUploaded = false;
  String? fileSize;

  ImageUpload(this.localImageFile, this.imageName,
      this.isUploaded, this.fileSize);


  Map<String, dynamic> toMap() {
    return {
      'localImageFile': this.localImageFile,
      'imageName': this.imageName,
      'isUploaded': this.isUploaded,
      'fileSize': this.fileSize,
    };
  }
}
