import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class MomentsScreen extends StatelessWidget {
  const MomentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moments')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (int i = 0; i < 3; i++)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(child: Icon(Icons.person)),
                      SizedBox(width: 12),
                      Text('Avatar user'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Güncel anlarımızı paylaşalım!'),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.favorite_border),
                      SizedBox(width: 8),
                      Text('89'),
                      SizedBox(width: 24),
                      Icon(Icons.comment_outlined),
                      SizedBox(width: 8),
                      Text('23'),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
