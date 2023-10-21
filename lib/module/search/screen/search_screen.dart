import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xsis_test/common/models/movies_model.dart';
import 'package:xsis_test/common/widgets/loading_bar.dart';
import 'package:xsis_test/core/style/app_colors.dart';
import 'package:xsis_test/module/home/widgets/detail_dialog.dart';
import 'package:xsis_test/module/home/widgets/movie_portrait._card.dart';
import 'package:xsis_test/module/search/data/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchMoviesController>(
        init: SearchMoviesController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.list_rounded),
              backgroundColor: AppColors.primaryColor,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: controller.seacrhTxt,
                  onChanged: (val) {
                    controller.searchOnChange();
                  },
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      border: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.primaryColor,
                      ),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
            ),
            body: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                Expanded(
                  child: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        childCount: controller.isLoading
                            ? 10
                            : controller.searchResult.length, (context, index) {
                      if (!controller.isLoading) {
                        Result item = controller.searchResult[index];
                        return GestureDetector(
                          onTap: () {
                            showAdaptiveDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    insetPadding: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: DetailDialog(
                                      item: item,
                                      imageUrl: controller.imageUrl,
                                    ),
                                  );
                                });
                          },
                          child: MoviePortraitCard(
                              item: item, imageUrl: controller.imageUrl),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: LoadingBar(
                            width: 280,
                            height: 400,
                          ),
                        );
                      }
                    }),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (controller.isLoadingMore)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 32),
                          child: const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
