import 'package:flutter/material.dart';
import 'package:githubsearch/model/core/issues.dart';
import 'package:githubsearch/model/core/repositories.dart';
import 'package:githubsearch/model/core/user.dart';
import 'package:githubsearch/model/services/github_search_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeProvider extends ChangeNotifier {
  User user = User();
  Issues issues = Issues();
  Repositories repositories = Repositories();
  List<UserItem>? userList = [];
  List<UserItem>? userCache = [];
  List<IssuesItem>? issuesList = [];
  List<IssuesItem>? issuesCache = [];
  List<RepoItem>? repoList = [];
  List<RepoItem>? repoCache = [];

  int page = 1;
  TextEditingController searchController = TextEditingController();
  List<RefreshController> refreshControllerList = [
    RefreshController(),
    RefreshController(),
    RefreshController(),
  ];
  bool lazyMode = true;

  void searchUser(query, bool isLoadMore) async {
    if (isLoadMore) {
      if (lazyMode) {
        page += 1;
      }
    } else {
      page = 1;
    }
    var result = await GithubSearchApi.searchUser(query, page);
    if (result != null) {
      if (isLoadMore) {
        if (lazyMode) {
          userList?.addAll(result.items as Iterable<UserItem>);
        } else {
          user = result;
          userList = result.items;
        }
      } else {
        user = result;
        userList = result.items;
      }
    }
    notifyListeners();
  }

  void searchIssues(query, bool isLoadMore) async {
    if (isLoadMore) {
      if (lazyMode) {
        page += 1;
      }
    } else {
      page = 1;
    }
    var result = await GithubSearchApi.searchIssues(query, page);
    if (result != null) {
      if (isLoadMore) {
        if (lazyMode) {
          issuesList?.addAll(result.items as Iterable<IssuesItem>);
        } else {
          issues = result;
          issuesList = result.items;
        }
      } else {
        issues = result;
        issuesList = result.items;
      }
    }
    notifyListeners();
  }

  void searchRepo(query, bool isLoadMore) async {
    if (isLoadMore) {
      if (lazyMode) {
        page += 1;
      }
    } else {
      page = 1;
    }
    var result = await GithubSearchApi.searchRepo(query, page);
    if (result != null) {
      if (isLoadMore) {
        if (lazyMode) {
          repoList?.addAll(result.items as Iterable<RepoItem>);
        } else {
          repositories = result;
          repoList = result.items;
        }
      } else {
        repositories = result;
        repoList = result.items;
      }
    }
    notifyListeners();
  }

  void onLoading(int index) async {
    await Future.delayed(Duration(milliseconds: 1000));
    switch (index) {
      case 0:
        searchUser(searchController.text, true);
        break;
      case 1:
        searchIssues(searchController.text, true);
        break;
      case 2:
        searchRepo(searchController.text, true);
        break;
      default:
    }
    for (int i = 0; i < refreshControllerList.length; i++) {
      refreshControllerList[i].loadComplete();
    }
  }

  void changePagingMode(bool state, int index) {
    lazyMode = state;
    if (!state) {
      switch (index) {
        case 0:
          if (userList!.length > 10) {
            for (int i = 0; i < userList!.length - 10; i++) {
              userCache?.add(userList![i]);
            }
            userList?.removeRange(0, userList!.length - 10);
          }
          break;
        case 1:
          if (issuesList!.length > 10) {
            for (int i = 0; i < issuesList!.length - 10; i++) {
              issuesCache?.add(issuesList![i]);
            }
            issuesList?.removeRange(0, issuesList!.length - 10);
          }
          break;
        case 2:
          if (repoList!.length > 10) {
            for (int i = 0; i < repoList!.length - 10; i++) {
              repoCache?.add(repoList![i]);
            }
            repoList?.removeRange(0, repoList!.length - 10);
          }
          break;
        default:
      }
    } else {
      switch (index) {
        case 0:
          userList?.insertAll(0, userCache!);
          userCache?.clear();
          break;
        case 1:
          issuesList?.insertAll(0, issuesCache!);
          issuesCache?.clear();
          break;
        case 2:
          repoList?.insertAll(0, repoCache!);
          repoList?.clear();
          break;
        default:
      }
    }
    notifyListeners();
  }
}
