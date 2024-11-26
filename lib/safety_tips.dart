import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SafetyTipsPage extends StatelessWidget {
  final List<Map<String, String>> popularArticles = [
    {
      'title': 'SAFETY TIPS FOR WOMEN',
      'url': 'https://paladinsecurity.com/safety-tips/for-women/',
    },
    {
      'title': 'Psychological safety',
      'url':
          'https://www.safetyandhealthmagazine.com/articles/21201-psychological-safety-hot-concept-workplace-safety',
    },
    {
      'title': 'TOP 10 SAFETY TIPS FOR WOMEN',
      'url': 'https://issuesiface.com/magazine/top-10-safety-tips-for-women',
    },
  ];

  final List<Map<String, String>> videoLectures = [
    {
      'title': 'What Should A Woman Do To Feel Safe?',
      'url': 'https://www.youtube.com/watch?v=6eFeEHi9ODM',
    },
    {
      'title': 'The Concept Of Feeling Safe Changed My Life',
      'url': 'https://www.youtube.com/watch?v=xK7vwnC6EMM',
    },
    {
      'title': 'After watching this, your brain will not be the same',
      'url': 'https://www.youtube.com/watch?v=LNHBMFCzznE',
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 229, 234),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: popularArticles.length,
                      itemBuilder: (context, index) {
                        final article = popularArticles[index];
                        return ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            size: 20,
                            color: Color.fromARGB(255, 139, 18, 148),
                          ),
                          title: Text(
                            article['title']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          onTap: () => launchURL(article['url']!),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Video lectures",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 139, 18, 148),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: videoLectures.length,
                      itemBuilder: (context, index) {
                        final lecture = videoLectures[index];
                        return ListTile(
                          leading: Icon(
                            Icons.arrow_right,
                            size: 20,
                            color: Color.fromARGB(255, 139, 18, 148),
                          ),
                          title: Text(
                            lecture['title']!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          onTap: () => launchURL(lecture['url']!),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(Icons.arrow_right, size: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 62, 62, 62),
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