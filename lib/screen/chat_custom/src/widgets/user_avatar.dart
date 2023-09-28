import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gohomy/components/empty/saha_empty_avatar.dart';

import '../../../../components/empty/saha_empty_image.dart';
import '../models/bubble_rtl_alignment.dart';
import '../util.dart';
import 'inherited_chat_theme.dart';

/// Renders user's avatar or initials next to a message.
class UserAvatar extends StatelessWidget {
  /// Creates user avatar.
  const UserAvatar({
    super.key,
    required this.author,
    this.bubbleRtlAlignment,
    this.onAvatarTap,
  });

  /// Author to show image and name initials from.
  final types.User author;

  /// See [Message.bubbleRtlAlignment].
  final BubbleRtlAlignment? bubbleRtlAlignment;

  /// Called when user taps on an avatar.
  final void Function(types.User)? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final color = getUserAvatarNameColor(
      author,
      InheritedChatTheme.of(context).theme.userAvatarNameColors,
    );
    final hasImage = author.imageUrl != null;
    final initials = getUserInitials(author);
    return Container(
      margin: bubbleRtlAlignment == BubbleRtlAlignment.left
          ? const EdgeInsetsDirectional.only(end: 8)
          : const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => onAvatarTap?.call(author),
        child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(author.imageUrl ?? '',
                  width: 30, height: 30, fit: BoxFit.cover,
                errorBuilder: (context, url, error) => const SahaEmptyAvata(height: 30,width: 30,),
              ),
            )

            // CircleAvatar(
            //   backgroundColor: hasImage
            //       ? InheritedChatTheme.of(context)
            //           .theme
            //           .userAvatarImageBackgroundColor
            //       : color,
            //   backgroundImage: hasImage ? NetworkImage(author.imageUrl!) : null,
            //   onBackgroundImageError: (exception, stackTrace) {
            //     setState(() {
            //       // set ảnh mặc định hoặc icon lỗi cho avatar
            //       backgroundImage = AssetImage('assets/default-avatar.png');
            //     });
            //   },
            //   radius: 16,
            //   child: !hasImage
            //       ? Text(
            //           initials,
            //           style:
            //               InheritedChatTheme.of(context).theme.userAvatarTextStyle,
            //         )
            //       : null,
            // ),
            ),
      ),
    );
  }
}
