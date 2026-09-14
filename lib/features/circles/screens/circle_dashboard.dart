import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/themes/borders.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/core/themes/paddings.dart';
import 'package:circlo/core/widgets/member_tile.dart';
import 'package:circlo/features/circles/providers/circle_provider.dart';
import 'package:circlo/features/circles/screens/live_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CircleDashboard extends ConsumerStatefulWidget {
  final String circleId;
  const new({super.key, required this.circleId});

  @override
  ConsumerState<CircleDashboard> createState() => _CircleDashboardState();
}

class _CircleDashboardState extends ConsumerState<CircleDashboard> {
  @override
  Widget build(BuildContext context) {
    final circleAsync = ref.watch(circleProvider(widget.circleId));
    return Scaffold(
      appBar: AppBar(
        title: circleAsync.when(
          data: (circle) => Text(circle!.name),
          error: (e, s) => Text(e.toString()),
          loading: () => CircularProgressIndicator(),
        ),
      ),
      body: Padding(
        padding: AppPadding.pagePadding,
        child: circleAsync.when(
          data: (circle) {
            circle = circle!;
            return ListView(
              children: [
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: AppBorders.medium,
                    color: AppColors.surface,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "3 Members sharing location",
                        style: AppFonts.cardTitle,
                      ),
                      SizedBox(height: 12),
                      PrimaryButton(
                        label: "View Live Map",
                        onPressed: () => context.push('/map-test'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Members (${circle.members.length})",
                  style: AppFonts.cardTitle,
                ),
                SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppBorders.small,
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Column(
                        children: List.generate(circle.members.length, (index) {
                          final uid = circle!.members[index];
                          return MemberTile(memberId: uid);
                        }),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                SecondaryButton(label: "Invite Member", onPressed: () {}),
              ],
            );
          },
          error: (e, s) => Text(e.toString()),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
