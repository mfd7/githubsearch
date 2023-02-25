import 'package:flutter/material.dart';

import '../../shared/helper/helper.dart';

class RepoCard extends StatelessWidget {
  final String image;
  final String title;
  final DateTime createdDate;
  final int watcher;
  final int stars;
  final int forks;
  const RepoCard(this.image, this.title, this.createdDate, this.watcher,
      this.stars, this.forks);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Image.network(image),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleLarge,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    formatDate(createdDate),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      size: 15,
                    ),
                    Text(
                      ' $watcher',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.star,
                      size: 15,
                    ),
                    Text(
                      ' $stars',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.fork_left,
                      size: 15,
                    ),
                    Text(
                      ' $forks',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
