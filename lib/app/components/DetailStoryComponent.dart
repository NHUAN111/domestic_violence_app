import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class DetailComponent extends StatefulWidget {
  final String nameStory;
  final String descStory;
  final VoidCallback onPress;
  final List<String> imageUrls;

  const DetailComponent({
    Key? key,
    required this.nameStory,
    required this.descStory,
    required this.imageUrls,
    required this.onPress,
  }) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailComponent> {
  int _selectedImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              print('Selected image: ${widget.imageUrls[_selectedImageIndex]}');
            },
            child: Container(
              height: 250,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.imageUrls[_selectedImageIndex],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text('Error loading image'),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      onPressed: widget.onPress,
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
          ),
          SizedBox(height: 12),
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, imageIndex) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex = imageIndex;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.imageUrls[imageIndex],
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text('Error loading image'),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            widget.nameStory,
            style: TextStyle(
              fontSize: 20,
              color: ColorData.colorIcon,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget.descStory),
        ],
      ),
    );
  }
}
