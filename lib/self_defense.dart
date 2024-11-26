import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelfDefensePage extends StatelessWidget {
  final List<Map<String, String>> popularArticles = [
    {
      'title': 'Self-Defense for Women: Translating Theory into Practice',
      'url': 'https://www.jstor.org/stable/3346096',
    },
    {
      'title': 'Women’s Safety: Self-Defense Tips and Why Is It Important',
      'url':
          'https://seniority.in/blog/womens-safety-self-defense-tips-and-why-is-it-important',
    },
    {
      'title': '10 Self-Defense Strategies Every Woman Needs to Know',
      'url':
          'https://blackbeltmag.com/top-10-self-defense-techniques-for-women',
    },
  ];

  final List<Map<String, String>> videoLectures = [
    {
      'title': '5 Self-Defense Moves Every Woman Should Know',
      'url': 'https://youtu.be/KVpxP3ZZtAc',
    },
    {
      'title': '5 Choke Hold Defenses Women MUST Know',
      'url': 'https://www.youtube.com/watch?v=-V4vEyhWDZ0',
    },
    {
      'title': 'Self Defence for girls',
      'url': 'https://youtu.be/V_MNHrqj-wQ',
    },
  ];
  void launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 229, 234),
      body: Column(
        children: [
          Container(
            width: w,
            height: h * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/SignIn_backgrd.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 239, 221, 233),
                radius: 55,
                backgroundImage: AssetImage("img/s_logo.png"),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  Text(
                    "Popular articles",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 139, 18, 148),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: popularArticles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: TextButton(
                          onPressed: () =>
                              launchURL(popularArticles[index]['url']!),
                          child: Text(popularArticles[index]['title']!),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Video lectures",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 139, 18, 148),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: videoLectures.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: TextButton(
                          onPressed: () =>
                              launchURL(videoLectures[index]['url']!),
                          child: Text(videoLectures[index]['title']!),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_right, size: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                    text: TextSpan(
                      text: " Back",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 62, 62, 62),
                      ),
                    ),
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