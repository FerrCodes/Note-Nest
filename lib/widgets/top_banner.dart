import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BannerType { success, error, info }

class TopBanner {
  static OverlayEntry? _currentEntry;

  /// Tampilkan banner dari atas layar
  static void show(
    BuildContext context, {
    required String message,
    BannerType type = BannerType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Tutup banner lama kalau ada
    _dismiss();

    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => _TopBannerWidget(
        message: message,
        type: type,
        duration: duration,
        onDismiss: _dismiss,
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);
  }

  static void _dismiss() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _TopBannerWidget extends StatefulWidget {
  final String message;
  final BannerType type;
  final Duration duration;
  final VoidCallback onDismiss;

  const _TopBannerWidget({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_TopBannerWidget> createState() => _TopBannerWidgetState();
}

class _TopBannerWidgetState extends State<_TopBannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Auto dismiss
    _timer = Timer(widget.duration, () => _dismissAnimated());
  }

  Future<void> _dismissAnimated() async {
    if (!mounted) return;
    _timer?.cancel();
    await _controller.reverse();
    if (mounted) widget.onDismiss();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  IconData _getIcon() {
    switch (widget.type) {
      case BannerType.success:
        return Icons.check_circle;
      case BannerType.error:
        return Icons.cancel;
      case BannerType.info:
        return Icons.info;
    }
  }

  Color _getIconColor() {
    switch (widget.type) {
      case BannerType.success:
        return const Color(0xFF34C759); // Hijau iOS
      case BannerType.error:
        return const Color(0xFFFF3B30); // Merah iOS
      case BannerType.info:
        return const Color(0xFF0A84FF); // Biru iOS
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 0),
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (_) {
                HapticFeedback.lightImpact();
                _timer?.cancel();
                widget.onDismiss();
              },
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  _dismissAnimated();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E), // <-- Full opaque
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(_getIcon(), color: _getIconColor(), size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: widget.message,
                            style: const TextStyle(
                              color: Color(0xFFF2F2F7),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
