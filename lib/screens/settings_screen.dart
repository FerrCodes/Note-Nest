import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/journal_entry.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Color bgColor = const Color(0xFF121212);
  final Color cardColor = const Color(0xFF1E1E1E);
  final Color textPrimary = const Color(0xFFF2F2F7);
  final Color textSecondary = const Color(0xFF8E8E93);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // === KONTEN UTAMA ===
            ListView(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
              children: [
                // === SECTION 0: BAHASA ===
                _buildSectionTitle(AppLocalizations.of(context)!.language),
                const SizedBox(height: 12),
                _buildLanguageSelector(),
                const SizedBox(height: 32),

                // === SECTION 1: DATA ===
                _buildSectionTitle(AppLocalizations.of(context)!.data),
                const SizedBox(height: 12),
                _buildSettingItem(
                  icon: Icons.file_download_outlined,
                  title: AppLocalizations.of(context)!.exportJournals,
                  subtitle: AppLocalizations.of(context)!.exportJournalsDesc,
                  onTap: _exportJournals,
                ),
                const SizedBox(height: 8),
                _buildSettingItem(
                  icon: Icons.delete_outline,
                  title: AppLocalizations.of(context)!.deleteAllJournals,
                  subtitle: AppLocalizations.of(context)!.deleteAllJournalsDesc,
                  onTap: _confirmDeleteAll,
                  isDestructive: true,
                ),

                const SizedBox(height: 32),

                // === SECTION 2: TENTANG ===
                _buildSectionTitle(AppLocalizations.of(context)!.about),
                const SizedBox(height: 12),
                _buildSettingItem(
                  icon: Icons.info_outline,
                  title: AppLocalizations.of(context)!.aboutApp,
                  subtitle: AppLocalizations.of(context)!.version,
                  onTap: _showAboutDialog,
                ),
                const SizedBox(height: 8),
                _buildSettingItem(
                  icon: Icons.mail_outline,
                  title: AppLocalizations.of(context)!.sendFeedback,
                  subtitle: AppLocalizations.of(context)!.feedbackDesc,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    // Nanti bisa diarahkan ke email
                  },
                ),

                const SizedBox(height: 40),

                // === FOOTER ===
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.madeWith,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary.withValues(alpha: 0.5),
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),

            // === TOMBOL CLOSE (KIRI ATAS) ===
            Positioned(
              top: 12,
              left: 20,
              child: _buildCircleButton(
                icon: Icons.close,
                onTap: () => Navigator.pop(context),
              ),
            ),

            // === PILL JUDUL (TENGAH ATAS) ===
            Positioned(
              top: 12,
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
                    AppLocalizations.of(context)!.settings,
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

  // === TOMBOL BULAT ===
  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardColor.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: textPrimary, size: 20),
      ),
    );
  }

  // === LANGUAGE SELECTOR ===
  Widget _buildLanguageSelector() {
    final settingsBox = Hive.box('settingsBox');
    final currentLang = settingsBox.get('languageCode', defaultValue: 'en');

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _buildLangOption('en', 'English', currentLang)),
          const SizedBox(width: 8),
          Expanded(child: _buildLangOption('id', 'Indonesia', currentLang)),
        ],
      ),
    );
  }

  Widget _buildLangOption(String code, String label, String currentLang) {
    final isSelected = currentLang == code;
    return GestureDetector(
      onTap: () async {
        HapticFeedback.selectionClick();
        final settingsBox = Hive.box('settingsBox');
        await settingsBox.put('languageCode', code);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? textPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? bgColor : textPrimary,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // === WIDGET BANTUAN ===
  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textSecondary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDestructive
                    ? Colors.red.withValues(alpha: 0.15)
                    : textPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isDestructive ? Colors.red : textPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? Colors.red : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: textSecondary),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: textSecondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  // === FUNGSI EXPORT ===
  void _exportJournals() {
    final box = Hive.box<JournalEntry>('journalBox');

    if (box.isEmpty) {
      _showSnackBar(AppLocalizations.of(context)!.nothingToExport);
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('=== NOTENEST EXPORT ===');
    buffer.writeln(
      'Tanggal Export: ${DateFormat('MMM d, yyyy - HH:mm').format(DateTime.now())}',
    );
    buffer.writeln('Total Jurnal: ${box.length}');
    buffer.writeln('================================\n');

    final entries = box.values.toList().reversed.toList();
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      buffer.writeln('--- Jurnal #${i + 1} ---');
      buffer.writeln('Tanggal: ${entry.date}');
      buffer.writeln('Mood   : ${entry.mood}');
      buffer.writeln('Judul  : ${entry.title}');
      buffer.writeln('Isi    :');
      buffer.writeln(entry.content);
      buffer.writeln('\n');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));

    _showSnackBar(AppLocalizations.of(context)!.exportedToClipboard);
  }

  // === FUNGSI HAPUS SEMUA ===
  void _confirmDeleteAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          AppLocalizations.of(context)!.deleteAllTitle,
          style: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
        ),
        content: Text(
          AppLocalizations.of(context)!.deleteAllDesc,
          style: TextStyle(color: textSecondary, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(color: textSecondary),
            ),
          ),
          TextButton(
            onPressed: () async {
              final box = Hive.box<JournalEntry>('journalBox');
              await box.clear();
              if (!context.mounted) return;
              Navigator.pop(context);
              HapticFeedback.heavyImpact();
              _showSnackBar(AppLocalizations.of(context)!.allJournalsDeleted);
            },
            child: Text(
              AppLocalizations.of(context)!.deleteAll,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // === FUNGSI TENTANG ===
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          AppLocalizations.of(context)!.appName,
          style: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.version,
              style: TextStyle(
                color: textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.aboutDesc,
              style: TextStyle(color: textSecondary, height: 1.5, fontSize: 13),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.copyright,
              style: TextStyle(
                color: const Color(0xFFFFD60A).withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(color: Color(0xFF0A84FF)),
            ),
          ),
        ],
      ),
    );
  }

  // === SNACKBAR HELPER ===
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Color(0xFF121212),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF2F2F7), // Putih
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 2),
        elevation: 0,
      ),
    );
  }
}
