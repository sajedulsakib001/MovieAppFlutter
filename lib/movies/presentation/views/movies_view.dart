import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/presentation/components/error_screen.dart';
import 'package:movies_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_app/core/presentation/components/slider_card.dart';
import 'package:movies_app/core/resources/app_routes.dart';

import 'package:movies_app/core/presentation/components/custom_slider.dart';
import 'package:movies_app/core/presentation/components/section_listview_card.dart';
import 'package:movies_app/core/presentation/components/section_header.dart';
import 'package:movies_app/core/presentation/components/section_listview.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/presentation/components/all_movies.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_event.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc/movies_state.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()..add(GetMoviesEvent()),
      child: Scaffold(
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const LoadingIndicator();
              case RequestStatus.loaded:
                return MoviesWidget(
                  nowPlayingMovies: state.movies[0],
                  popularMovies: state.movies[1],
                  topRatedMovies: state.movies[2],
                );
              case RequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context.read<MoviesBloc>().add(GetMoviesEvent());
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class MoviesWidget extends StatelessWidget {
  final List<Media> nowPlayingMovies;
  final List<Media> popularMovies;
  final List<Media> topRatedMovies;

  const MoviesWidget({
    super.key,
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSlider(
              itemBuilder: (context, itemIndex, _) {
                return SliderCard(
                  media: nowPlayingMovies[itemIndex],
                  itemIndex: itemIndex,
                );
              },
            ),
            const SizedBox(height: 10),
            const SectionHeaderCustom(
              title: AppStrings.popularMovies,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: SizedBox(
                height: 5,
                width: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 7),
            SectionListView(
              height: AppSize.s240,
              itemCount: popularMovies.length,
              itemBuilder: (context, index) {
                return SectionListViewCard(media: popularMovies[index]);
              },
            ),
            const SizedBox(height: 10),
            const SectionHeaderCustom(
              title: AppStrings.topRatedMovies,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: SizedBox(
                height: 5,
                width: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 7),
            SectionListView(
              height: AppSize.s240,
              itemCount: topRatedMovies.length,
              itemBuilder: (context, index) {
                return SectionListViewCard(media: topRatedMovies[index]);
              },
            ),
            const SizedBox(height: 10),
            SectionHeader(
                title: 'Movies',
                onSeeAllTap: () {
                  context.goNamed(AppRoutes.popularMoviesRoute);
                }),
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: SizedBox(
                height: 5,
                width: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p16, right: AppPadding.p16),
              child: AllMoviesGridView(results: popularMovies),
            )
          ],
        ),
      ),
    );
  }
}
