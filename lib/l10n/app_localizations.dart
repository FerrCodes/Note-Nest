import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'NoteNest'**
  String get appName;

  /// No description provided for @reflect.
  ///
  /// In en, this message translates to:
  /// **'Reflect'**
  String get reflect;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search journals...'**
  String get searchHint;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterFavorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get filterFavorite;

  /// No description provided for @filterCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get filterCalm;

  /// No description provided for @filterGrateful.
  ///
  /// In en, this message translates to:
  /// **'Grateful'**
  String get filterGrateful;

  /// No description provided for @filterPeaceful.
  ///
  /// In en, this message translates to:
  /// **'Peaceful'**
  String get filterPeaceful;

  /// No description provided for @filterFocused.
  ///
  /// In en, this message translates to:
  /// **'Focused'**
  String get filterFocused;

  /// No description provided for @quote.
  ///
  /// In en, this message translates to:
  /// **'\"Small shifts in perspective can open the door to profound inner stillness.\"'**
  String get quote;

  /// No description provided for @todaysEntry.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Entry'**
  String get todaysEntry;

  /// No description provided for @noJournalsTitle.
  ///
  /// In en, this message translates to:
  /// **'No journals yet'**
  String get noJournalsTitle;

  /// No description provided for @noJournalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Create a new entry and start writing about your first moment of the day.'**
  String get noJournalsDesc;

  /// No description provided for @noResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get noResultsTitle;

  /// No description provided for @noResultsDesc.
  ///
  /// In en, this message translates to:
  /// **'Try another keyword or change the mood filter.'**
  String get noResultsDesc;

  /// No description provided for @noFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavoritesTitle;

  /// No description provided for @noFavoritesDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap the bookmark icon on a journal\nto mark it as favorite.'**
  String get noFavoritesDesc;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Journal?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmDesc.
  ///
  /// In en, this message translates to:
  /// **'This journal will be permanently deleted and cannot be restored.'**
  String get deleteConfirmDesc;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Want to Delete All Journals?'**
  String get deleteAllTitle;

  /// No description provided for @deleteAllDesc.
  ///
  /// In en, this message translates to:
  /// **'All journals will be permanently deleted.'**
  String get deleteAllDesc;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// No description provided for @journalDeleted.
  ///
  /// In en, this message translates to:
  /// **'Journal deleted successfully'**
  String get journalDeleted;

  /// No description provided for @allJournalsDeleted.
  ///
  /// In en, this message translates to:
  /// **'All journals deleted successfully'**
  String get allJournalsDeleted;

  /// No description provided for @newEntry.
  ///
  /// In en, this message translates to:
  /// **'New Entry'**
  String get newEntry;

  /// No description provided for @editEntry.
  ///
  /// In en, this message translates to:
  /// **'Edit Entry'**
  String get editEntry;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleHint;

  /// No description provided for @contentHint.
  ///
  /// In en, this message translates to:
  /// **'Start writing your thoughts...'**
  String get contentHint;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select image'**
  String get selectImage;

  /// No description provided for @howFeeling.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get howFeeling;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @exportJournals.
  ///
  /// In en, this message translates to:
  /// **'Export Journals'**
  String get exportJournals;

  /// No description provided for @exportJournalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Save all journals to a text file'**
  String get exportJournalsDesc;

  /// No description provided for @deleteAllJournals.
  ///
  /// In en, this message translates to:
  /// **'Delete All Journals'**
  String get deleteAllJournals;

  /// No description provided for @deleteAllJournalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete all journal data'**
  String get deleteAllJournalsDesc;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutDesc.
  ///
  /// In en, this message translates to:
  /// **'A minimalist journal app to capture daily moments, self-reflection, and track your mood.'**
  String get aboutDesc;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'This application is currently under development; please report any bugs immediately.'**
  String get copyright;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'v1.0.0'**
  String get version;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get sendFeedback;

  /// No description provided for @feedbackDesc.
  ///
  /// In en, this message translates to:
  /// **'Suggestions or bug reports'**
  String get feedbackDesc;

  /// No description provided for @madeWith.
  ///
  /// In en, this message translates to:
  /// **'© 2026 . All rights reserved.'**
  String get madeWith;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @streakDesc.
  ///
  /// In en, this message translates to:
  /// **'Journaling streak'**
  String get streakDesc;

  /// No description provided for @startStreak.
  ///
  /// In en, this message translates to:
  /// **'Start your streak today!'**
  String get startStreak;

  /// No description provided for @totalJournals.
  ///
  /// In en, this message translates to:
  /// **'Total Journals'**
  String get totalJournals;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @weeklyChart.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get weeklyChart;

  /// No description provided for @moodDistribution.
  ///
  /// In en, this message translates to:
  /// **'Mood Distribution'**
  String get moodDistribution;

  /// No description provided for @topMood.
  ///
  /// In en, this message translates to:
  /// **'Top Mood'**
  String get topMood;

  /// No description provided for @noDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get noDataTitle;

  /// No description provided for @noDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Write your first journal to\nsee statistics here.'**
  String get noDataDesc;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @indonesian.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Indonesia'**
  String get indonesian;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Write Your Reflections'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Desc.
  ///
  /// In en, this message translates to:
  /// **'Capture moments, thoughts, and feelings every day. No rules, no pressure.'**
  String get onboarding1Desc;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Track Your Mood'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Desc.
  ///
  /// In en, this message translates to:
  /// **'Choose a mood that represents your day. See your emotional patterns over time.'**
  String get onboarding2Desc;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'See Your Growth'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Desc.
  ///
  /// In en, this message translates to:
  /// **'Simple statistics help you understand yourself better.'**
  String get onboarding3Desc;

  /// No description provided for @exportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Journals exported successfully!'**
  String get exportedSuccessfully;

  /// No description provided for @nothingToExport.
  ///
  /// In en, this message translates to:
  /// **'No journals to export yet'**
  String get nothingToExport;

  /// No description provided for @journalsWithMood.
  ///
  /// In en, this message translates to:
  /// **'{count} journals with this mood'**
  String journalsWithMood(int count);

  /// No description provided for @journalDetail.
  ///
  /// In en, this message translates to:
  /// **'Journal Detail'**
  String get journalDetail;

  /// No description provided for @uploadFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Upload from gallery'**
  String get uploadFromGallery;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// No description provided for @tapToChoose.
  ///
  /// In en, this message translates to:
  /// **'Tap to choose photo from your phone'**
  String get tapToChoose;

  /// No description provided for @tapToChange.
  ///
  /// In en, this message translates to:
  /// **'Tap to change photo'**
  String get tapToChange;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload photo'**
  String get uploadPhoto;

  /// No description provided for @galleryOption.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryOption;

  /// No description provided for @galleryOptionDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose existing photo'**
  String get galleryOptionDesc;

  /// No description provided for @cameraOption.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraOption;

  /// No description provided for @cameraOptionDesc.
  ///
  /// In en, this message translates to:
  /// **'Take photo directly'**
  String get cameraOptionDesc;

  /// No description provided for @photoTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tips for Choosing Photo Aspect Ratios'**
  String get photoTipsTitle;

  /// No description provided for @photoTipsDesc.
  ///
  /// In en, this message translates to:
  /// **'For best results in the detail view, use landscape (wide) or square photos. Portrait photos may be cropped.'**
  String get photoTipsDesc;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @readingTime.
  ///
  /// In en, this message translates to:
  /// **'{count} min read'**
  String readingTime(int count);

  /// No description provided for @wordCount.
  ///
  /// In en, this message translates to:
  /// **'{count} words'**
  String wordCount(int count);

  /// No description provided for @editedTime.
  ///
  /// In en, this message translates to:
  /// **'Edited {time}'**
  String editedTime(String time);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} months ago'**
  String monthsAgo(int count);

  /// No description provided for @yearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} years ago'**
  String yearsAgo(int count);

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
