import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/components/circle_card.dart';
import 'package:circlo/core/components/text_field.dart';
import 'package:circlo/core/router/routes.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/features/auth/providers/user_provider.dart';
import 'package:circlo/features/circles/providers/circle_provider.dart';
import 'package:circlo/features/circles/services/circle_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final circlesAsync = ref.watch(userCirclesProvider);
    final userName = userAsync.value?.name ?? "there";

    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.only(bottom: 80),
          children: [
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                context.go(AppRoutes.signin);
              },
              child: Text("Sign out"),
            ),
            Text(
              "Good afternoon, $userName",
              style: AppFonts.sectionTitle.copyWith(fontSize: 28),
            ),
            Text(
              "Here's whats happening in your Circles today.",
              style: AppFonts.body,
            ),
            SizedBox(height: 24),
            Text("Your Circles", style: AppFonts.sectionTitle),
            SizedBox(height: 12),
            circlesAsync.when(
              data: (circles) {
                if (circles.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.group_off_outlined,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(height: 8),
                          Text("No circles yet", style: AppFonts.cardTitle),
                          Text(
                            "Create or join a circle to get started",
                            style: AppFonts.body,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: circles.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final circle = circles[index];
                    return CircleCard(
                      circle: circle,
                      onTap: () {
                        context.push(
                          AppRoutes.circleCreated.replaceFirst(
                            ':circleId',
                            circle.circleId,
                          ),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (err, _) =>
                  Center(child: Text("Error loading circles: $err")),
            ),
            SizedBox(height: 100),
          ],
        ),
        Positioned(
          bottom: 85,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PrimaryButton(
                  label: "+ Create Circle",
                  onPressed: () => context.push(AppRoutes.createCircle),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: SecondaryButton(
                  label: "Join a Circle",
                  onPressed: ()=> context.push(AppRoutes.joinCircle),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
