import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/presentation/components/image_with_shimmer.dart';
import 'package:movies_app/core/resources/app_routes.dart';
import 'package:movies_app/core/resources/app_values.dart';

class TVGridViewCard extends StatelessWidget {
  const TVGridViewCard({
    super.key,
    required this.item,
  });

  final Media item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(AppRoutes.tvShowDetailsRoute,
                params: {'tvShowId': item.tmdbID.toString()});
          },
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl: item.posterUrl,
                width: double.infinity,
                height: AppSize.s150,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
