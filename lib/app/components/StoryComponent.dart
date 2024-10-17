import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/text.dart';

class StoryComponent extends StatefulWidget {
  final String nameStory;
  final String descStory;
  final VoidCallback onPresseDetail;
  final VoidCallback onPresseFav;
  final List<String> imageUrls;
  const StoryComponent({
    Key? key,
    required this.nameStory,
    required this.descStory,
    required this.onPresseDetail,
    required this.imageUrls,
    required this.onPresseFav,
  }) : super(key: key);

  @override
  State<StoryComponent> createState() => _StoryComponentState();
}

class _StoryComponentState extends State<StoryComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorData.colorNavBar,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.imageUrls.isNotEmpty
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  child: Container(
                    height: 200,
                    child: Stack(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.imageUrls.length,
                          itemBuilder: (context, imageIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(0),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(
                                  widget.imageUrls[imageIndex],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Text('Error loading image'),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: widget.onPresseFav,
                            icon: Icon(
                              Icons.favorite_border,
                              color: ColorData.colorIcon,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text('No images available'),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      UtilText.truncateString(widget.nameStory, 18),
                      style: const TextStyle(
                        fontSize: 20,
                        color: ColorData.colorIcon,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Detail',
                          style: TextStyle(
                            color: ColorData.colorIcon,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: widget.onPresseDetail,
                          icon: Icon(
                            Icons.navigate_next,
                            size: 32,
                            color: ColorData.colorIcon,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  UtilText.truncateString(widget.descStory, 90),
                  style: TextStyle(
                    fontSize: 15,
                    color: ColorData.colorText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
