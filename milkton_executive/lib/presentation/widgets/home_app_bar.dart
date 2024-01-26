import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/cubit/query/query_cubit.dart';
import 'package:milkton_executive/cubit/search/search_cubit.dart';

AppBar appBar = AppBar(
  foregroundColor: Colors.white,
  backgroundColor: Colors.deepPurple,
  title: BlocBuilder<SearchCubit, SearchState>(
    builder: (context, state) {
      if (state is SearchActive) {
        return TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              context.read<QueryCubit>().setQuery(value);
            });
      }
      return const Text("Milkton Executive");
    },
  ),
  actions: [
    BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return IconButton(
            onPressed: () {
              if (state is SearchActive) {
                context.read<QueryCubit>().setQuery("");
                context.read<SearchCubit>().closeSearch();
              } else {
                context.read<SearchCubit>().activateSearch();
              }
            },
            icon: Icon(state is SearchActive ? Icons.close : Icons.search));
      },
    ),
    const SizedBox(width: 12),
  ],
);
