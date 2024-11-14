import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/data/provider/appwritePost.dart';
import 'package:project_domestic_violence/app/data/repository/postRepository.dart';
import 'package:project_domestic_violence/app/models/post.dart';
import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/modules/Post/post_controller.dart';
import 'package:project_domestic_violence/app/modules/Post/post_detail_view.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:project_domestic_violence/app/utils/text.dart';
import 'package:project_domestic_violence/app/utils/user_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetailView extends StatefulWidget {
  const ProfileDetailView({super.key});

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  String name =
      'Guest'; // Default value for name to avoid LateInitializationError
  late PostController postController;
  final RxList<Post> posts = <Post>[].obs;

  @override
  void initState() {
    super.initState();
    postController = PostController(PostRepository(AppWritePostProvider()));
    _loadUserData();
  }

  Future<void> fetchBlogsByUserId(String id) async {
    try {
      List<Map<String, dynamic>> rawPosts =
          await postController.fetchPostsByUserId(id);
      posts.value = rawPosts.map((post) => Post.fromJson(post)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch posts: $e");
    }
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString(Constant.USER) ?? '';
    if (userJson.isNotEmpty) {
      UserModel user = UserModel.fromJson(jsonDecode(userJson));
      setState(() {
        name = user.userName ?? 'Guest';
      });
      await fetchBlogsByUserId(user.accountId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: (MediaQuery.of(context).size.width / 2) - 60,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/lion.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: ColorData.colorText,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Your bio goes here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonComponent(
                  text: "Edit profile",
                  onPress: () {
                    Get.toNamed(Routes.profileEdit);
                  },
                  backgroundColor: Color.fromARGB(255, 228, 228, 228),
                  textColor: Colors.black,
                ),
                SizedBox(width: 10),
                ButtonComponent(
                  text: "Share profile",
                  onPress: () {},
                  backgroundColor: Color.fromARGB(255, 228, 228, 228),
                  textColor: Colors.black,
                ),
              ],
            ),
            SizedBox(height: 10),
            TabSection(posts: posts),
          ],
        ),
      ),
    );
  }
}

class TabSection extends StatefulWidget {
  final RxList<Post> posts;

  TabSection({required this.posts});

  @override
  _TabSectionState createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: ColorData.colorMain,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          indicatorColor: ColorData.colorMain,
          unselectedLabelColor: ColorData.colorIcon,
          tabs: [
            Tab(text: 'Favourite'),
            Tab(text: 'Post'),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8),
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 19,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/fav.png',
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 8,
                            left: 8,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              color: Colors.black54,
                              child: Text(
                                'Item ${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Obx(() {
                if (widget.posts.isEmpty) {
                  return Center(
                    child: Text(
                      'No Posts Available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: widget.posts.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final post = widget.posts[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the detail page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDetail(
                                nameStory: post.title,
                                descStory: post.content,
                                imageUrls: post.image,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Placeholder widget
                                post.image != null && post.image.isNotEmpty
                                    ? FutureBuilder(
                                        future: precacheImage(
                                            NetworkImage(post.image[0]),
                                            context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Image.network(
                                              post.image[0],
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                      'assets/images/placeholder.png'),
                                            );
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.grey,
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    : Image.asset(
                                        'assets/images/placeholder.png',
                                        fit: BoxFit.cover,
                                      ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      child: Text(
                                        _getTypeText(post.type),
                                        style: TextStyle(
                                          color: ColorData.colorMain,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  width: 100,
                                  bottom: 8,
                                  left: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          UtilText.truncateString(
                                              post.title, 7),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}

String _getTypeText(int type) {
  switch (type) {
    case 1:
      return 'Stories';
    case 2:
      return 'Support';
    case 3:
      return 'Legal';
    case 4:
      return 'Solutions';
    default:
      return 'Not Found';
  }
}
