import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';

class PostCard extends StatefulWidget {
  PostCard({
    required this.snapshot,
    super.key,
  });
  final snapshot;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  TextEditingController commentController = TextEditingController();

  UserModel? userDetail;

  fetchUserDetail() async {
    userDetail = await FireStoreMethods().getUserByUid(widget.snapshot['uid']);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 4, right: 4),
      child: Column(
        children: [
          ListTile(
              leading: userDetail == null
                  ? CircleAvatar(
                      backgroundColor: Colors.cyan,
                    )
                  : CircleAvatar(
                      backgroundImage:
                          NetworkImage(userDetail!.imageUrl.toString()),
                    ),
              title: Text(
                widget.snapshot['username'],
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: Icon(Icons.more_horiz_outlined))),
          Image.network(widget.snapshot['imageUrl']),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () {
                    showCommentsSheet(context);
                  },
                  icon: Icon(
                    Icons.comment_outlined,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border,
                      )),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              showCommentsSheet(context);
            },
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("12 likes"),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Username ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "Nice pic Geralt")
                      ]),
                    ),
                    Text(
                      "View all 20 comments",
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String> currentUserImg() async {
    UserModel userDetail = await FireStoreMethods()
        .getUserByUid(FirebaseAuth.instance.currentUser!.uid);
    return userDetail.imageUrl!;
  }

  showCommentsSheet(BuildContext context) async {
    String imageUrl = await currentUserImg();
    showBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.sizeOf(context).height * 0.6,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(
              "Comments",
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(
              child: SizedBox(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Expanded(
                  child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
                title: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                      hintText: "Write anything ",
                      border: InputBorder.none,
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.send))),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
