import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_domestic_violence/app/components/ButtonComponent.dart';
import 'package:project_domestic_violence/app/components/StoryComponent.dart';
import 'package:project_domestic_violence/app/data/provider/appwritePost.dart';
import 'package:project_domestic_violence/app/data/repository/blogRepository.dart';
import 'package:project_domestic_violence/app/models/blog.dart';
import 'package:project_domestic_violence/app/modules/Blog/blog_controller.dart';
import 'package:project_domestic_violence/app/modules/Blog/blog_detail_view.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class BlogView extends StatefulWidget {
  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  late BlogController blogController;
  final List<XFile> _selectedImages = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final RxList<Blog> posts = <Blog>[].obs;

  @override
  void initState() {
    super.initState();
    blogController = BlogController(BlogRepository(AppWritePostProvider()));
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      List<Map<String, dynamic>> rawPosts = await blogController.fetchPosts();

      posts.value = rawPosts.map((post) => Blog.fromJson(post)).toList();
    } catch (e) {
      print("Error fetching post 222: $e");
    }
  }

  Future<void> _pickImages(StateSetter setState) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      _selectedImages.addAll(images);
      setState(() {});
    }
  }

  void _removeImage(int index, StateSetter setState) {
    _selectedImages.removeAt(index);
    setState(() {});
  }

  bool isValidFileType(String filePath) {
    final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    final extension = filePath.split('.').last.toLowerCase();
    return validExtensions.contains(extension);
  }

  void _savePost(BuildContext context) {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      Get.snackbar("Error", "Title and content cannot be empty.");
      return;
    }

    if (_selectedImages.isEmpty) {
      Get.snackbar("Error", "Please select at least one image.");
      return;
    }

    for (var image in _selectedImages) {
      if (!isValidFileType(image.path)) {
        Get.snackbar(
            "Error", "Unsupported file format. Please upload an image.");
        return;
      }
    }

    Map<String, dynamic> blogData = {
      'title': titleController.text,
      'content': contentController.text,
      'type': 1,
    };

    List<String> imagePaths =
        _selectedImages.map((image) => image.path).toList();

    blogController.createPost(blogData, imagePaths).then((_) {
      fetchBlogs();
      titleController.clear();
      contentController.clear();
      _selectedImages.clear();
      Get.snackbar("Success", "Blog post created successfully!");
      Navigator.of(context).pop();
    }).catchError((error) {
      Get.snackbar("Error", "Failed to create post: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorData.colorNavBar,
          leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/icontym.png',
              width: 150,
              height: 150,
            ),
          ),
          title: Center(
            child: Text(
              "Useful Information",
              style: TextStyle(
                color: ColorData.colorIcon,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                size: 28,
                color: ColorData.colorIcon,
              ),
              onPressed: () {
                // Them bai
                _showAddPostModal(context);
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: Container(
              color: Colors.white,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                indicatorColor: ColorData.colorMain,
                labelColor: ColorData.colorMain,
                unselectedLabelColor: ColorData.colorIcon,
                tabs: [
                  Tab(text: 'Stories'),
                  Tab(text: 'Support'),
                  Tab(text: 'Legal'),
                  Tab(text: 'Solutions'),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            buildBlogList(context),
            Container(),
            Container(),
            Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddPostModal(context);
          },
          child: Icon(Icons.add, color: Colors.white, size: 36),
          backgroundColor: Color.fromARGB(255, 83, 178, 255),
        ),
      ),
    );
  }

  Widget buildBlogList(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final blog = posts[index];
          return StoryComponent(
            nameStory: blog.title,
            descStory: blog.content,
            onPresseDetail: () {
              // detail
              print('detail');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetail(
                    nameStory: blog.title,
                    descStory: blog.content,
                    imageUrls: blog.image,
                  ),
                ),
              );
            },
            imageUrls: blog.image,
            onPresseFav: () {
              print('fav');
            },
          );
        },
      ),
    );
  }

  void _showAddPostModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          maxChildSize: 1,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Text(
                        'Create Post',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorData.colorText,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Topic',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: contentController,
                        decoration: InputDecoration(
                          labelText: 'Write your shares...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      SizedBox(height: 10),
                      Container(
                        color: Color.fromARGB(255, 235, 235, 235),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () async {
                              await _pickImages(setState);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add photos or videos",
                                  style: TextStyle(
                                      color: ColorData.colorText,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.image,
                                      color: ColorData.colorIcon,
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.video_call_rounded,
                                      color: ColorData.colorIcon,
                                      size: 28,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 10),
                      if (_selectedImages.isNotEmpty)
                        Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children:
                                List.generate(_selectedImages.length, (index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.file(
                                      File(_selectedImages[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      icon: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () =>
                                          _removeImage(index, setState),
                                    ),
                                  ),
                                ],
                              );
                            })),
                      SizedBox(height: 10),
                      ButtonComponent(
                        text: 'Post',
                        onPress: () {
                          _savePost(context);
                        },
                        backgroundColor: ColorData.colorMain,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
