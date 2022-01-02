// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:poll_answer/search/search_controller.dart';
import 'package:poll_answer/theme/colors.dart';

class SearchView extends StatelessWidget {
  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        hint: tr('search-hint'),
        margins: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 16),
        transitionDuration: const Duration(milliseconds: 300),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: 0.0,
        openAxisAlignment: 0.0,
        elevation: 10,
        height: 50,
        hintStyle: searchTextStyle(),
        queryStyle: searchTextStyle(),
        iconColor: iconColorWhite,
        backgroundColor: endColorAppBar,
        backdropColor: transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        width: double.infinity,
        debounceDelay: const Duration(milliseconds: 200),
        onQueryChanged: (query) {
          // Call your model, bloc, controller here.
        },
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: Colors.accents.map((color) {
                  return Container(height: 112, color: color);
                }).toList(),
              ),
            ),
          );
        },
        body: Container(
          child: Center(
            child: Text("Search View"),
          ),
        ),
      ),
    );
  }

  TextStyle searchTextStyle() {
    return TextStyle(color: appBarTextColor, fontSize: 16, fontFamily: 'Rubik');
  }
}
