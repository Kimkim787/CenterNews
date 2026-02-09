import 'package:get/get.dart';
import 'package:centernews/features/screens/login/screen.dart';
import 'package:centernews/features/screens/news/news_page.dart';
import 'package:centernews/features/pages/news_detail/news_detail_page.dart';
import 'package:centernews/features/screens/news/controller.dart';
import 'package:centernews/features/screens/news/interface.dart';
import 'package:centernews/features/screens/bookmarks/bookmarks_page.dart';
import 'package:centernews/features/screens/bookmarks/bookmarks_controller.dart';
import 'package:centernews/features/screens/bookmarks/bookmarks_interface.dart';
import 'package:centernews/features/screens/login/signup_page.dart';
import 'routes.dart';

class AppPages {
  const AppPages._();

  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: AppRoutes.news,
      page: () => const NewsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<INewsController>(() => NewsController());
      }),
    ),
    GetPage(
      name: AppRoutes.newsDetail,
      page: () => const NewsDetailPage(),
    ),
    GetPage(
      name: AppRoutes.bookmarks,
      page: () => const BookmarksPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<IBookmarkController>(() => BookmarkController());
      }),
    ),
  ];
}
