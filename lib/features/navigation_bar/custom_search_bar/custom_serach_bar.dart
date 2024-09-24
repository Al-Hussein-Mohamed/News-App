import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/constants.dart';
import '../../article/article_manager/article_cubit.dart';
import '../../home/home_manager/home_cubit.dart';
import '../../source_bar/source_manager/source_cubit.dart';
import '../../title/title_manager/title_cubit.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  var formKey = GlobalKey<FormState>();
  double _height = -80;
  Curve _curve = Curves.easeOut;
  String content = "";
  bool _focused = false;
  bool valid = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1)).then((_) {
      setState(() {
        _height = 50;
      });
    });
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      setState(() {
        _focused = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    return Stack(
      children: [
        GestureDetector(
          onTap: _onBarrierTap,
          child: Container(
            color: Colors.black54,
          ),
        ),
        AnimatedPositioned(
          top: _height,
          duration: Constants.duration,
          curve: _curve,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 65,
            width: screenWidth - 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: valid ? Colors.white : Colors.red),
            ),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        cursorColor: valid ? Colors.black : Colors.red,
                        autofocus: true,
                        onFieldSubmitted: _search,
                        onChanged: (value) {
                          content = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Invalid search!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorText: null,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed:() =>  _search(content),
                    icon: Icon(
                      Icons.search_rounded,
                      color: valid ? Colors.black : Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onBarrierTap() {
    setState(() {
      _height = -80;
      _curve = Curves.easeInOutCubicEmphasized;
    });

    _close();
  }

  void _search(String content) {
    if (formKey.currentState!.validate()){
      var articleCubit = context.read<ArticleCubit>();
      var sourceCubit = context.read<SourceCubit>();
      setState(() {
        valid = true;
        articleCubit.fetchArticlesList(null, content);
        sourceCubit.fetchSourcesList(null, false);
        _close();
      });
    } else {
      setState(() {
        valid = false;
      });
    }
  }

  Future<void> _close() async{
    var titleCubit = context.read<TitleCubit>();
    var homeCubit = context.read<HomeCubit>();
    await Future.delayed(const Duration(milliseconds: 100)).then((_) {
      titleCubit.title = content;
      homeCubit.isSearch = true;
      Navigator.of(context).pop();
    });
  }
}
