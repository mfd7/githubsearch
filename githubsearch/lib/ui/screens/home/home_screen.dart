import 'package:flutter/material.dart';
import 'package:githubsearch/provider/home_provider.dart';
import 'package:githubsearch/shared/constants/colors.dart';
import 'package:githubsearch/ui/screens/home/issues_view.dart';
import 'package:githubsearch/ui/screens/home/repo_view.dart';
import 'package:githubsearch/ui/screens/home/user_view.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: true);
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: CustomAppBar(
            height: 180,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      controller: homeProvider.searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        switch (DefaultTabController.of(context).index) {
                          case 0:
                            homeProvider.page = 1;
                            homeProvider.searchUser(
                                homeProvider.searchController.text, false);
                            break;
                          case 1:
                            homeProvider.page = 1;
                            homeProvider.searchIssues(
                                homeProvider.searchController.text, false);
                            break;
                          case 2:
                            homeProvider.page = 1;
                            homeProvider.searchRepo(
                                homeProvider.searchController.text, false);
                            break;
                          default:
                        }
                      },
                    ),
                  ),
                ),
                TabBar(
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        homeProvider.page = 1;
                        homeProvider.searchUser(
                            homeProvider.searchController.text, false);
                        break;
                      case 1:
                        homeProvider.page = 1;
                        homeProvider.searchIssues(
                            homeProvider.searchController.text, false);
                        break;
                      case 2:
                        homeProvider.page = 1;
                        homeProvider.searchRepo(
                            homeProvider.searchController.text, false);
                        break;
                      default:
                    }
                  },
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.people),
                      text: 'Users',
                    ),
                    Tab(
                      icon: Icon(Icons.chat),
                      text: 'Issues',
                    ),
                    Tab(
                      icon: Icon(Icons.folder_copy),
                      text: 'Repositories',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              homeProvider.lazyMode ? selected : unSelected,
                          side: homeProvider.lazyMode
                              ? BorderSide.none
                              : const BorderSide(color: white),
                        ),
                        onPressed: () {
                          switch (DefaultTabController.of(context).index) {
                            case 0:
                              homeProvider.changePagingMode(true, 0);
                              break;
                            case 1:
                              homeProvider.changePagingMode(true, 1);
                              break;
                            case 2:
                              homeProvider.changePagingMode(true, 2);
                              break;
                            default:
                          }
                        },
                        child: const Text(
                          'Lazy Loading',
                          style: TextStyle(color: white),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              homeProvider.lazyMode ? unSelected : selected,
                          side: homeProvider.lazyMode
                              ? const BorderSide(color: white)
                              : BorderSide.none,
                        ),
                        onPressed: () {
                          switch (DefaultTabController.of(context).index) {
                            case 0:
                              homeProvider.changePagingMode(false, 0);
                              break;
                            case 1:
                              homeProvider.changePagingMode(false, 1);
                              break;
                            case 2:
                              homeProvider.changePagingMode(false, 2);
                              break;
                            default:
                          }
                        },
                        child: const Text(
                          'With Index',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [UserView(), IssuesView(), RepoView()],
          ),
        );
      }),
    );
  }
}
