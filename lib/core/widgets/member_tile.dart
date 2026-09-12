import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/features/auth/providers/user_provider.dart';
import 'package:circlo/features/circles/models/circle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberTile extends ConsumerStatefulWidget {
  final String memberId;
  const new({super.key, required this.memberId});

  @override
  ConsumerState<MemberTile> createState() => MemberTileState();
}

class MemberTileState extends ConsumerState<MemberTile> {
  @override
  Widget build(BuildContext context) {
    final memberAsync = ref.watch(userByIdProvider(widget.memberId));
    return memberAsync.when(
      data: (member) {
        member = member!;
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.secondary.withAlpha(30),
            child:
                member.avatar != null &&
                    member.avatar!.isNotEmpty &&
                    member.avatar!.startsWith('http')
                ? ClipOval(
                    child: Image.network(
                      member.avatar!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    member.name.isNotEmpty
                        ? member.name.substring(0, 1).toUpperCase()
                        : '?',
                    style: AppFonts.cardTitle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
          ),
          title: Text(member.name, style: AppFonts.cardTitle),
        );
      },
      error: (error, s) => Text(error.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}
