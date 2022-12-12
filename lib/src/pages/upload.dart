import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_100/src/components/image_data.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

  Widget _imagePreview() {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.grey,
      child: ImageData(IconPath.NFC_img),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconPath.closeImage),
          ),
        ),
        title: const Text(
          'Tag NFC',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            //_header(),
            //_imageSelectList(),
          ],
        ),
      ),
    );
  }
}
