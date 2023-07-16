import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  PostCard({
    super.key,
  });
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 4, right: 4),
      child: Column(
        children: [
          ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.cyan,
              ),
              title: Text(
                "abhishek_bagdiya",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: Icon(Icons.more_horiz_outlined))),
          Image.network(
              "https://firebasestorage.googleapis.com/v0/b/instagram-1cbd5.appspot.com/o/posts%2FQ9uFTxXf08MtRDLM4bfXxW632cB2%2F50689600-1e5c-11ee-8335-5fa1485974b5?alt=media&token=d033653c-b4f4-47b8-9764-6bea113b6a39"),
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
                        Icons.bookmark,
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

  showCommentsSheet(BuildContext context) {
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
                  backgroundColor: Colors.cyan,
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
