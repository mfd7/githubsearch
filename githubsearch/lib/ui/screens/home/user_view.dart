import 'package:flutter/material.dart';
import 'package:githubsearch/shared/constants/colors.dart';
import 'package:pager/pager.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../provider/home_provider.dart';
import '../../widgets/user_card.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    final userList = homeProvider.userList;
    return Column(
      children: [
        if (homeProvider.lazyMode)
          Expanded(
            child: SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              controller: homeProvider.refreshControllerList[0],
              onLoading: () => homeProvider.onLoading(0),
              child: ListView.builder(
                itemCount: userList?.length,
                itemBuilder: (context, index) {
                  return UserCard(
                      userList![index].avatarUrl!, userList![index].login!);
                },
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: userList?.length,
              itemBuilder: (context, index) {
                return UserCard(
                    userList![index].avatarUrl!, userList![index].login!);
              },
            ),
          ),
        if (homeProvider.user.totalCount != null)
          if (!homeProvider.lazyMode)
            SizedBox(
                width: double.infinity,
                child: Pager(
                  numberButtonSelectedColor: primary,
                  currentPage: homeProvider.page,
                  totalPages: homeProvider.user.totalCount != null
                      ? (homeProvider.user.totalCount! / 10).ceil() > 1000
                          ? 100
                          : (homeProvider.user.totalCount! / 10).ceil()
                      : 0,
                  onPageChanged: (page) {
                    homeProvider.page = page;
                    homeProvider.searchUser(
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
