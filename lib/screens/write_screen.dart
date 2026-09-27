import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/journal_entry.dart';
import '../utils/preset_images.dart';
import '../l10n/app_localizations.dart';

class WriteScreen extends StatefulWidget {
  final JournalEntry? entry;

  const WriteScreen({super.key, this.entry});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String _selectedMood = 'Calm';
  late String _selectedImage;

  String _getLocalizedMood(BuildContext context, String mood) {
    final l10n = AppLocalizations.of(context)!;
    switch (mood) {
      case 'Calm':
        return l10n.filterCalm;
      case 'Grateful':
        return l10n.filterGrateful;
      case 'Peaceful':
        return l10n.filterPeaceful;
      case 'Focused':
        return l10n.filterFocused;
      default:
        return mood;
    }
  }

  final Color bgColor = const Color(0xFF121212);
  final Color cardColor = const Color(0xFF1E1E1E);
  final Color textPrimary = const Color(0xFFF2F2F7);
  final Color textSecondary = const Color(0xFF8E8E93);

  final List<Map<String, dynamic>> _moods = [
    {'icon': Icons.wb_sunny_outlined, 'label': 'Calm'},
    {'icon': Icons.favorite_border, 'label': 'Grateful'},
    {'icon': Icons.cloud_outlined, 'label': 'Peaceful'},
    {'icon': Icons.eco_outlined, 'label': 'Focused'},
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.entry?.title ?? '');
    _contentController = TextEditingController(
      text: widget.entry?.content ?? '',
    );
    _selectedMood = widget.entry?.mood ?? 'Calm';
    _selectedImage = widget.entry?.imageUrl ?? PresetImages.getDefault();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.entry != null;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // === KONTEN UTAMA ===
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 80, 24, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // === PILIHAN GAMBAR ===
                    Text(
                      AppLocalizations.of(context)!.selectImage,
                      style: TextStyle(
                        fontSize: 14,
                        color: textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: PresetImages.images.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final img = PresetImages.images[index];
                          final isSelected = _selectedImage == img['url'];
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              setState(() {
                                _selectedImage = img['url']!;
                              });
                            },
                            child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? textPrimary
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.network(
                                      img['url']!,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Container(color: cardColor);
                                          },
                                    ),
                                    if (isSelected)
                                      Container(
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                        child: const Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // === MOOD SELECTOR ===
                    Text(
                      AppLocalizations.of(context)!.howFeeling,
                      style: TextStyle(
                        fontSize: 14,
                        color: textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _moods.map((mood) {
                        final isSelected = _selectedMood == mood['label'];
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _selectedMood = mood['label'];
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected ? textPrimary : cardColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  mood['icon'],
                                  color: isSelected ? bgColor : textPrimary,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _getLocalizedMood(context, mood['label']),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isSelected
                                      ? textPrimary
                                      : textSecondary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // === JUDUL ===
                    TextField(
                      controller: _titleController,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.titleHint,
                        hintStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: textSecondary.withValues(alpha: 0.5),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // === ISI JURNAL ===
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 200),
                      child: TextField(
                        controller: _contentController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 16,
                          color: textPrimary.withValues(alpha: 0.8),
                          height: 1.6,
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.contentHint,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: textSecondary.withValues(alpha: 0.5),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // === TOMBOL CLOSE (KIRI ATAS) ===
            Positioned(
              top: 16,
              left: 16,
              child: _buildCircleButton(
                icon: Icons.close,
                onTap: () => Navigator.pop(context),
              ),
            ),

            // === TOMBOL SAVE/UPDATE (KANAN ATAS) ===
            Positioned(
              top: 16,
              right: 16,
              child: _buildCircleButton(
                label: isEditing
                    ? AppLocalizations.of(context)!.update
                    : AppLocalizations.of(context)!.save,
                labelColor: const Color(0xFF0A84FF),
                onTap: () async {
                  HapticFeedback.mediumImpact();

                  if (_titleController.text.isEmpty &&
                      _contentController.text.isEmpty) {
                    Navigator.pop(context);
                    return;
                  }

                  final box = Hive.box<JournalEntry>('journalBox');
                  final today = DateFormat(
                    'MMM d, yyyy HH:mm',
                  ).format(DateTime.now());

                  if (isEditing) {
                    widget.entry!.title = _titleController.text.isEmpty
                        ? 'Untitled'
                        : _titleController.text;
                    widget.entry!.content = _contentController.text;
                    widget.entry!.mood = _selectedMood;
                    widget.entry!.imageUrl = _selectedImage;
                    widget.entry!.lastEdited = DateTime.now();
                    await widget.entry!.save();
                  } else {
                    final newEntry = JournalEntry(
                      title: _titleController.text.isEmpty
                          ? 'Untitled'
                          : _titleController.text,
                      content: _contentController.text,
                      date: today,
                      mood: _selectedMood,
                      imageUrl: _selectedImage,
                      lastEdited: DateTime.now(),
                    );
                    await box.add(newEntry);
                  }

                  if (!context.mounted) return;
                  HapticFeedback.lightImpact();
                  Navigator.pop(context);
                },
              ),
            ),
            // === JUDUL MELAYANG DI TENGAH ATAS (PILL) ===
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    isEditing
                        ? AppLocalizations.of(context)!.editEntry
                        : AppLocalizations.of(context)!.newEntry,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    IconData? icon,
    String? label,
    required VoidCallback onTap,
    Color? labelColor,
    bool isPrimary = false,
  }) {
    final isLabeled = label != null;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        padding: isLabeled
            ? const EdgeInsets.symmetric(horizontal: 18, vertical: 10)
            : const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isPrimary ? textPrimary : cardColor.withValues(alpha: 0.9),
          shape: isLabeled ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: isLabeled ? BorderRadius.circular(20) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: isLabeled
            ? Text(
                label,
                style: TextStyle(
                  color: labelColor ?? textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )
            : Icon(icon, color: textPrimary, size: 20),
      ),
    );
  }
}
