import 'package:flutter/material.dart';
import 'package:githubsearch/ui/widgets/repo_card.dart';
import 'package:pager/pager.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../provider/home_provider.dart';
import '../../../shared/constants/colors.dart';

class RepoView extends StatelessWidget {
  const RepoView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final repoList = homeProvider.repoList;
    return Column(
      children: [
        if (homeProvider.lazyMode)
          Expanded(
            child: SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              controller: homeProvider.refreshControllerList[2],
              onLoading: () => homeProvider.onLoading(2),
              child: ListView.builder(
                itemCount: repoList?.length,
                itemBuilder: (context, index) {
                  return RepoCard(
                      repoList![index].owner!.avatarUrl!,
                      repoList![index].name!,
                      repoList![index].createdAt!,
                      repoList![index].watchers!,
                      repoList![index].stargazersCount!,
                      repoList![index].forks!);
                },
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: repoList?.length,
              itemBuilder: (context, index) {
                return RepoCard(
                    repoList![index].owner!.avatarUrl!,
                    repoList![index].name!,
                    repoList![index].createdAt!,
                    repoList![index].watchers!,
                    repoList![index].stargazersCount!,
                    repoList![index].forks!);
              },
            ),
          ),
        if (homeProvider.repositories.totalCount != null)
          if (!homeProvider.lazyMode)
            SizedBox(
                width: double.infinity,
                child: Pager(
                  numberButtonSelectedColor: primary,
                  currentPage: homeProvider.page,
                  totalPages: homeProvider.repositories.totalCount != null
                      ? (homeProvider.repositories.totalCount! / 10).ceil() >
                              1000
                          ? 100
                          : (homeProvider.repositories.totalCount! / 10).ceil()
                      : 0,
                  onPageChanged: (page) {
                    homeProvider.page = page;
                    homeProvider.searchRepo(
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
