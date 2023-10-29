import 'package:flutter/material.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/resources/app_values.dart';
import 'package:movies_app/movies/presentation/components/all_movies_card.dart';

class AllMoviesGridView extends StatelessWidget {
  const AllMoviesGridView({
    super.key,
    required this.results,
  });

  final List<Media> results;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (results.length / 3) * 225,
      child: Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
          itemCount: results.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (context, index) {
            return MovieGridViewCard(item: results[index]);
          },
        ),
      ),
    );
  }
}
