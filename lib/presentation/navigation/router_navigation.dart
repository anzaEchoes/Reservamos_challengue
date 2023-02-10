import 'package:get/get.dart';
import 'package:reservamos_app/presentation/screans/detail_searching_city_screan/detail_searching_city_screan.dart';
import 'package:reservamos_app/presentation/screans/home/home_screan.dart';
import 'package:reservamos_app/presentation/screans/search/search_screan.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(name: '/homeScreen', page: () => const HomeScrean()),
  GetPage(name: '/searchScreen', page: () => const SearchScrean()),
  GetPage(name: '/detailSearchingCity', page: () => DetailSearchingCity()),
];
