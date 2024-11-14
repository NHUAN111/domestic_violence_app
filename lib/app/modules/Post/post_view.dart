import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/components/story_component.dart';
import 'package:project_domestic_violence/app/data/provider/appwritePost.dart';
import 'package:project_domestic_violence/app/data/repository/postRepository.dart';
import 'package:project_domestic_violence/app/models/post.dart';
import 'package:project_domestic_violence/app/modules/Post/post_controller.dart';
import 'package:project_domestic_violence/app/modules/Post/post_detail_view.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';

class PostView extends StatefulWidget {
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late PostController postController;
  final List<XFile> _selectedImages = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  int? _selectedCategory;
  late AppWritePostProvider appWritePostProvider;

  // Test realtime
  late Future<List<Map<String, dynamic>>> _items;
  List<Post> posts = <Post>[].obs;
  late Stream<List<Post>> _realtimeStream;

  @override
  void initState() {
    super.initState();
    appWritePostProvider = AppWritePostProvider();
    postController = PostController(PostRepository(AppWritePostProvider()));

    // Test realtime
    _items = appWritePostProvider.fetchPosts();
    _realtimeStream = appWritePostProvider.subscribeToRealtimePost();

    _items.then((value) {
      setState(() {
        posts.assignAll(value.map((data) => Post.fromJson(data)).toList());
      });
    });

    // Lắng nghe sự kiện realtime và gán dữ liệu vào `posts`
    _realtimeStream.listen((data) {
      setState(() {
        posts.assignAll(data);
      });
      print("Updated posts: ${posts.length}");
    }, onError: (error) {
      print("Error in real-time stream: $error");
    });
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
      BaseToast.showErrorToast("Error", "Topic and content cannot be empty.");
      return;
    }

    if (_selectedImages.isEmpty) {
      BaseToast.showErrorToast("Error", "Please select at least one image.");
      return;
    }

    for (var image in _selectedImages) {
      if (!isValidFileType(image.path)) {
        BaseToast.showErrorToast(
            "Error", "Unsupported file format. Please upload an image.");
        return;
      }
    }

    Map<String, dynamic> blogData = {
      'title': titleController.text,
      'content': contentController.text,
      'type': _selectedCategory,
    };

    List<String> imagePaths =
        _selectedImages.map((image) => image.path).toList();

    postController.createPost(blogData, imagePaths).then((_) {
      // fetchBlogs();
      titleController.clear();
      contentController.clear();
      _selectedImages.clear();
      BaseToast.showSuccessToast("Success", "Blog post created successfully!");
      Navigator.of(context).pop();
    }).catchError((error) {
      BaseToast.showErrorToast("Error", "Failed to create post: $error");
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
              child: Icon(
                Icons.explore,
                size: 30,
                color: ColorData.colorIcon,
              )),
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
            buildBlogList(1, posts),
            buildBlogList(2, posts),
            buildBlogList(3, posts),
            buildBlogList(4, posts),
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

  Widget buildBlogList(int type, List<Post> posts) {
    // Filter the posts based on the provided type
    final filteredPosts = posts.where((blog) => blog.type == type).toList();

    return ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final blog = filteredPosts[index];
        return StoryComponent(
          nameStory: blog.title,
          descStory: blog.content,
          onPresseDetail: () {
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
                // Dropdown value selected by the user (int type)
                // int? _selectedCategory;

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

                      // Dropdown button for category selection
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          labelText: 'Choose category',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedCategory, // Value of dropdown
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: Text('Stories'),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text('Support'),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text('Legal'),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Text('Solutions'),
                          ),
                        ],
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
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
                                    SizedBox(width: 20),
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
                                        borderRadius: BorderRadius.circular(50),
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
                          }),
                        ),
                      SizedBox(height: 10),
                      ButtonComponent(
                        text: 'Post',
                        onPress: () {
                          _savePost(context);
                          print("Post");
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
