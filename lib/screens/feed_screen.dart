import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/assets.dart';
import 'package:instagram_clone/utils/colors.dart';

import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: mobileBackgroundColor,
          title: SvgPicture.asset(
            igText,
            height: 40,
            color: primaryColor,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.messenger_outline,
                color: primaryColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("post").snapshots(),
          builder: (context,  snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(snapshot: snapshot.data!.docs[index].data()),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
