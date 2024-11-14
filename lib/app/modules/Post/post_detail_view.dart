import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/components/detail_story_omponent.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/text.dart'; // Giả sử bạn có tiện ích cho văn bản

class BlogDetail extends StatelessWidget {
  final String nameStory;
  final String descStory;
  final List<String> imageUrls;

  const BlogDetail({
    Key? key,
    required this.nameStory,
    required this.descStory,
    required this.imageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details Information",
          style: TextStyle(
            color: ColorData.colorIcon,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorData.colorNavBar,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DetailComponent(
            nameStory: nameStory,
            descStory: descStory,
            imageUrls: imageUrls,
            onPress: () {
              print('Favorited: $nameStory');
            },
          ),
        ),
      ),
    );
  }
}
