///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn.internal(_root);
	late final TranslationsWellnessPackagesEn wellnessPackages = TranslationsWellnessPackagesEn.internal(_root);
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loginTitle => 'Welcome Back';
	String get loginSubtitle => 'Sign in to continue';
	String get loginButton => 'Sign In';
	String get loginLoading => 'Signing in…';
	String get registerTitle => 'Create Account';
	String get registerSubtitle => 'Fill in the details below to get started';
	String get registerButton => 'Create Account';
	String get registerLoading => 'Creating account…';
	String get emailLabel => 'Email';
	String get emailHint => 'you@example.com';
	String get passwordLabel => 'Password';
	String get passwordHint => '········';
	String get nameLabel => 'Full Name';
	String get nameHint => 'John Doe';
	String get dontHaveAccount => 'Don\'t have an account?';
	String get alreadyHaveAccount => 'Already have an account?';
	String get registerLink => 'Register';
	String get loginLink => 'Sign In';
	late final TranslationsAuthValidationEn validation = TranslationsAuthValidationEn.internal(_root);
	String get logoutButton => 'Sign Out';
	String get logoutConfirmTitle => 'Sign Out';
	String get logoutConfirmMessage => 'Are you sure you want to sign out?';
	String get devTestCredentialsHint => 'Dev mode: tap to fill test credentials';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get appName => 'TUG Wellness';
	String get ok => 'OK';
	String get cancel => 'Cancel';
	String get confirm => 'Confirm';
	String get retry => 'Retry';
	String get loading => 'Loading…';
	String get save => 'Save';
	String get close => 'Close';
	String get error => 'Something went wrong';
	String get errorNetwork => 'No internet connection. Please check your network and try again.';
	String get errorServer => 'Server error. Please try again later.';
	String get emptyState => 'Nothing here yet';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Home';
	String get welcome => 'You\'re signed in!';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get languageTitle => 'Language';
	String get languageEnglish => 'English';
	String get languageIndonesian => 'Bahasa Indonesia';
}

// Path: wellnessPackages
class TranslationsWellnessPackagesEn {
	TranslationsWellnessPackagesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Wellness Packages';
	String get searchHint => 'Search packages…';
	String get searchTooltipOpen => 'Search';
	String get searchTooltipClose => 'Clear search';
	String get empty => 'No packages available';
	String get emptySubtitle => 'Check back later for wellness packages.';
	String get loadingMoreLabel => 'Loading more…';
	String durationMinutes({required Object minutes}) => '${minutes} min';
	String get navButton => 'Wellness Packages';
}

// Path: auth.validation
class TranslationsAuthValidationEn {
	TranslationsAuthValidationEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get emailRequired => 'Email is required';
	String get emailInvalid => 'Enter a valid email address';
	String get passwordRequired => 'Password is required';
	String get passwordTooShort => 'Password must be at least 6 characters';
	String get nameRequired => 'Full name is required';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.loginTitle': return 'Welcome Back';
			case 'auth.loginSubtitle': return 'Sign in to continue';
			case 'auth.loginButton': return 'Sign In';
			case 'auth.loginLoading': return 'Signing in…';
			case 'auth.registerTitle': return 'Create Account';
			case 'auth.registerSubtitle': return 'Fill in the details below to get started';
			case 'auth.registerButton': return 'Create Account';
			case 'auth.registerLoading': return 'Creating account…';
			case 'auth.emailLabel': return 'Email';
			case 'auth.emailHint': return 'you@example.com';
			case 'auth.passwordLabel': return 'Password';
			case 'auth.passwordHint': return '········';
			case 'auth.nameLabel': return 'Full Name';
			case 'auth.nameHint': return 'John Doe';
			case 'auth.dontHaveAccount': return 'Don\'t have an account?';
			case 'auth.alreadyHaveAccount': return 'Already have an account?';
			case 'auth.registerLink': return 'Register';
			case 'auth.loginLink': return 'Sign In';
			case 'auth.validation.emailRequired': return 'Email is required';
			case 'auth.validation.emailInvalid': return 'Enter a valid email address';
			case 'auth.validation.passwordRequired': return 'Password is required';
			case 'auth.validation.passwordTooShort': return 'Password must be at least 6 characters';
			case 'auth.validation.nameRequired': return 'Full name is required';
			case 'auth.logoutButton': return 'Sign Out';
			case 'auth.logoutConfirmTitle': return 'Sign Out';
			case 'auth.logoutConfirmMessage': return 'Are you sure you want to sign out?';
			case 'auth.devTestCredentialsHint': return 'Dev mode: tap to fill test credentials';
			case 'common.appName': return 'TUG Wellness';
			case 'common.ok': return 'OK';
			case 'common.cancel': return 'Cancel';
			case 'common.confirm': return 'Confirm';
			case 'common.retry': return 'Retry';
			case 'common.loading': return 'Loading…';
			case 'common.save': return 'Save';
			case 'common.close': return 'Close';
			case 'common.error': return 'Something went wrong';
			case 'common.errorNetwork': return 'No internet connection. Please check your network and try again.';
			case 'common.errorServer': return 'Server error. Please try again later.';
			case 'common.emptyState': return 'Nothing here yet';
			case 'home.title': return 'Home';
			case 'home.welcome': return 'You\'re signed in!';
			case 'settings.languageTitle': return 'Language';
			case 'settings.languageEnglish': return 'English';
			case 'settings.languageIndonesian': return 'Bahasa Indonesia';
			case 'wellnessPackages.title': return 'Wellness Packages';
			case 'wellnessPackages.searchHint': return 'Search packages…';
			case 'wellnessPackages.searchTooltipOpen': return 'Search';
			case 'wellnessPackages.searchTooltipClose': return 'Clear search';
			case 'wellnessPackages.empty': return 'No packages available';
			case 'wellnessPackages.emptySubtitle': return 'Check back later for wellness packages.';
			case 'wellnessPackages.loadingMoreLabel': return 'Loading more…';
			case 'wellnessPackages.durationMinutes': return ({required Object minutes}) => '${minutes} min';
			case 'wellnessPackages.navButton': return 'Wellness Packages';
			default: return null;
		}
	}
}

