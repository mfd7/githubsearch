import 'package:flutter/material.dart';
import 'package:githubsearch/shared/helper/helper.dart';

class IssuesCard extends StatelessWidget {
  final String title;
  final DateTime updateDate;
  final String state;
  const IssuesCard(this.title, this.updateDate, this.state);

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
              child: Image.network(
                  'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png'),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    formatDate(updateDate),
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                state,
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
