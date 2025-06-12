import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? contentPadding;

  const LiquidGlassDialog({
    Key? key,
    this.title,
    this.content,
    this.actions,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: LiquidGlassEffects.buildGlassContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (content != null)
              Padding(
                padding:
                    contentPadding ?? const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: content!,
              ),
            if (actions != null && actions!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!
                      .map(
                        (action) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: action,
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
        borderRadius: 20,
        isDark: isDark,
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? content,
    List<Widget>? actions,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => LiquidGlassDialog(
        title: title,
        content: content,
        actions: actions,
        contentPadding: contentPadding,
      ),
    );
  }
}
