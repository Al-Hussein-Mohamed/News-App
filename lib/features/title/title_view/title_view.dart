import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/home_manager/home_cubit.dart';

import '../../../core/config/constants.dart';
import '../title_manager/title_cubit.dart';
import '../title_manager/title_states.dart';

class TitleView extends StatelessWidget {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = HomeCubit.get(context);
    var titleCubit = TitleCubit.get(context);
    return AnimatedPositioned(
      top: homeCubit.isCategorySheetOpened ? -100 : 47,
      right: 30,
      curve: Curves.easeInOut,
      duration: Constants.duration,
      child: BlocBuilder<TitleCubit, TitleState>(
        builder: (context, state) {
          return  Text(
            titleCubit.title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
