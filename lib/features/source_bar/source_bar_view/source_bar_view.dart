import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/color_palette.dart';
import '../../article/article_manager/article_cubit.dart';
import '../../home/home_manager/home_cubit.dart';
import '../custom_widgets/source_tab_item_widget.dart';
import '../source_manager/source_cubit.dart';
import '../source_manager/source_states.dart';

class SourceBarView extends StatefulWidget {
  const SourceBarView({
    super.key,
  });

  @override
  State<SourceBarView> createState() => _SourceBarViewState();
}

class _SourceBarViewState extends State<SourceBarView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    var sourceCubit = SourceCubit.get(context);
    var articleCubit = ArticleCubit.get(context);
    var homeCubit = HomeCubit.get(context);
    return BlocBuilder<SourceCubit, SourceState>(
      builder: (context, state) {
        switch (state) {
          case DismissSourceState():
            {
              return const SizedBox();
            }

          case LoadingSourceState():
            {
              return Positioned(
                bottom: 90,
                left: screenWidth * 0.5 - 18,
                child: const CircularProgressIndicator(
                  color: ColorPalette.primaryColor,
                ),
              );
            }

          case ErrorSourceState():
            {
              return Center(
                child: Text(state.error ?? "Error!"),
              );
            }

          case SuccessSourceState():
            {
              if (state.fetch) {
                articleCubit.fetchArticlesList(
                    state.sourcesList[state.idx].id, null);
              }
              return Stack(
                children: [
                  AnimatedPositioned(
                    width: screenWidth,
                    height: articleCubit.isArticleOpened ? 0 : 140,
                    bottom: homeCubit.isCategorySheetOpened ||
                            homeCubit.isSearch ||
                            sourceCubit.hide
                        ? -160
                        : 0,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    child: Container(
                      color: Colors.black.withOpacity(.78),
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    width: screenWidth,
                    bottom: homeCubit.isCategorySheetOpened ||
                            homeCubit.isSearch ||
                            sourceCubit.hide
                        ? -120
                        : 80,
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DefaultTabController(
                        length: state.sourcesList.length,
                        child: TabBar(
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          indicator: const BoxDecoration(),
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 6),
                          tabAlignment: TabAlignment.start,
                          onTap: (value) {
                            sourceCubit.idx = value;
                          },
                          tabs: state.sourcesList
                              .map(
                                (e) => SourceTabItemWidget(
                                  source: e,
                                  isSelected:
                                      state.idx == state.sourcesList.indexOf(e),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: screenWidth,
                    height: 90,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.01),
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }
}
