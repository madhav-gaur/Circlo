import 'package:circlo/core/components/circle_card.dart';
import 'package:circlo/core/router/routes.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/features/circles/providers/circle_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Circles extends ConsumerStatefulWidget {
  const Circles({super.key});

  @override
  ConsumerState<Circles> createState() => _CirclesState();
}

class _CirclesState extends ConsumerState<Circles> {
  @override
  Widget build(BuildContext context) {
    final circlesAsync = ref.watch(userCirclesProvider);

    return Scaffold(
      body: circlesAsync.when(
        data: (circles) {
          if (circles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.group_outlined,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 12),
                  Text("No Circles Found", style: AppFonts.screenTitle),
                  SizedBox(height: 4),
                  Text(
                    "You are not a member of any circle yet.",
                    style: AppFonts.body,
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 90, top: 12),
            itemCount: circles.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final circle = circles[index];
              return CircleCard(
                circle: circle,
                onTap: () {
                  context.push(
                    AppRoutes.circleDashboard.replaceFirst(
                      ':circleId',
                      circle.circleId,
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
