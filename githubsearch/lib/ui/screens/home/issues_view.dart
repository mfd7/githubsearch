import 'package:flutter/material.dart';
import 'package:githubsearch/ui/widgets/issues_card.dart';
import 'package:pager/pager.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../provider/home_provider.dart';
import '../../../shared/constants/colors.dart';

class IssuesView extends StatelessWidget {
  const IssuesView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final issuesList = homeProvider.issuesList;
    return Column(
      children: [
        if (homeProvider.lazyMode)
          Expanded(
            child: SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              controller: homeProvider.refreshControllerList[1],
              onLoading: () => homeProvider.onLoading(1),
              child: ListView.builder(
                itemCount: issuesList?.length,
                itemBuilder: (context, index) {
                  return IssuesCard(issuesList![index].title!,
                      issuesList![index].updatedAt!, issuesList![index].state!);
                },
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: issuesList?.length,
              itemBuilder: (context, index) {
                return IssuesCard(issuesList![index].title!,
                    issuesList![index].updatedAt!, issuesList![index].state!);
              },
            ),
          ),
        if (homeProvider.issues.totalCount != null)
          if (!homeProvider.lazyMode)
            SizedBox(
                width: double.infinity,
                child: Pager(
                  numberButtonSelectedColor: primary,
                  currentPage: homeProvider.page,
                  totalPages: homeProvider.issues.totalCount != null
                      ? (homeProvider.issues.totalCount! / 10).ceil() > 1000
                          ? 100
                          : (homeProvider.issues.totalCount! / 10).ceil()
                      : 0,
                  onPageChanged: (page) {
                    homeProvider.page = page;
                    homeProvider.searchIssues(
                        homeProvider.searchController.text, true);
                  },
                ))
          else
            const SizedBox.shrink()
        else
          const SizedBox.shrink()
      ],
    );
  }
}
