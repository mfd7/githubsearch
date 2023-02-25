import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String image;
  final String username;
  const UserCard(this.image, this.username);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Image.network(image),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              username,
              style: textTheme.headlineSmall,
            )
          ],
        ),
      ),
    );
  }
}
