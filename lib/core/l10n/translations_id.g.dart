///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsId extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsId({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.id,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <id>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsId _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthId auth = _TranslationsAuthId._(_root);
	@override late final _TranslationsCommonId common = _TranslationsCommonId._(_root);
	@override late final _TranslationsHomeId home = _TranslationsHomeId._(_root);
	@override late final _TranslationsSettingsId settings = _TranslationsSettingsId._(_root);
	@override late final _TranslationsWellnessPackagesId wellnessPackages = _TranslationsWellnessPackagesId._(_root);
}

// Path: auth
class _TranslationsAuthId extends TranslationsAuthEn {
	_TranslationsAuthId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get loginTitle => 'Selamat Datang';
	@override String get loginSubtitle => 'Masuk untuk melanjutkan';
	@override String get loginButton => 'Masuk';
	@override String get loginLoading => 'Sedang masuk…';
	@override String get registerTitle => 'Buat Akun';
	@override String get registerSubtitle => 'Isi data di bawah ini untuk memulai';
	@override String get registerButton => 'Buat Akun';
	@override String get registerLoading => 'Membuat akun…';
	@override String get emailLabel => 'Email';
	@override String get emailHint => 'anda@contoh.com';
	@override String get passwordLabel => 'Kata Sandi';
	@override String get passwordHint => '········';
	@override String get nameLabel => 'Nama Lengkap';
	@override String get nameHint => 'Budi Santoso';
	@override String get dontHaveAccount => 'Belum punya akun?';
	@override String get alreadyHaveAccount => 'Sudah punya akun?';
	@override String get registerLink => 'Daftar';
	@override String get loginLink => 'Masuk';
	@override late final _TranslationsAuthValidationId validation = _TranslationsAuthValidationId._(_root);
	@override String get logoutButton => 'Keluar';
	@override String get logoutConfirmTitle => 'Keluar';
	@override String get logoutConfirmMessage => 'Apakah Anda yakin ingin keluar?';
	@override String get devTestCredentialsHint => 'Mode dev: ketuk untuk mengisi kredensial uji';
}

// Path: common
class _TranslationsCommonId extends TranslationsCommonEn {
	_TranslationsCommonId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get appName => 'TUG Wellness';
	@override String get ok => 'OK';
	@override String get cancel => 'Batal';
	@override String get confirm => 'Konfirmasi';
	@override String get retry => 'Coba Lagi';
	@override String get loading => 'Memuat…';
	@override String get save => 'Simpan';
	@override String get close => 'Tutup';
	@override String get error => 'Terjadi kesalahan';
	@override String get errorNetwork => 'Tidak ada koneksi internet. Periksa jaringan Anda dan coba lagi.';
	@override String get errorServer => 'Terjadi kesalahan pada server. Silakan coba beberapa saat lagi.';
	@override String get emptyState => 'Belum ada data';
}

// Path: home
class _TranslationsHomeId extends TranslationsHomeEn {
	_TranslationsHomeId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Beranda';
	@override String get welcome => 'Anda telah masuk!';
}

// Path: settings
class _TranslationsSettingsId extends TranslationsSettingsEn {
	_TranslationsSettingsId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get languageTitle => 'Bahasa';
	@override String get languageEnglish => 'English';
	@override String get languageIndonesian => 'Bahasa Indonesia';
}

// Path: wellnessPackages
class _TranslationsWellnessPackagesId extends TranslationsWellnessPackagesEn {
	_TranslationsWellnessPackagesId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paket Wellness';
	@override String get searchHint => 'Cari paket…';
	@override String get searchTooltipOpen => 'Cari';
	@override String get searchTooltipClose => 'Hapus pencarian';
	@override String get empty => 'Belum ada paket tersedia';
	@override String get emptySubtitle => 'Kunjungi kembali untuk melihat paket wellness.';
	@override String get loadingMoreLabel => 'Memuat lebih banyak…';
	@override String durationMinutes({required Object minutes}) => '${minutes} menit';
	@override String get navButton => 'Paket Wellness';
}

// Path: auth.validation
class _TranslationsAuthValidationId extends TranslationsAuthValidationEn {
	_TranslationsAuthValidationId._(TranslationsId root) : this._root = root, super.internal(root);

	final TranslationsId _root; // ignore: unused_field

	// Translations
	@override String get emailRequired => 'Email wajib diisi';
	@override String get emailInvalid => 'Masukkan alamat email yang valid';
	@override String get passwordRequired => 'Kata sandi wajib diisi';
	@override String get passwordTooShort => 'Kata sandi minimal 6 karakter';
	@override String get nameRequired => 'Nama lengkap wajib diisi';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsId {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth.loginTitle': return 'Selamat Datang';
			case 'auth.loginSubtitle': return 'Masuk untuk melanjutkan';
			case 'auth.loginButton': return 'Masuk';
			case 'auth.loginLoading': return 'Sedang masuk…';
			case 'auth.registerTitle': return 'Buat Akun';
			case 'auth.registerSubtitle': return 'Isi data di bawah ini untuk memulai';
			case 'auth.registerButton': return 'Buat Akun';
			case 'auth.registerLoading': return 'Membuat akun…';
			case 'auth.emailLabel': return 'Email';
			case 'auth.emailHint': return 'anda@contoh.com';
			case 'auth.passwordLabel': return 'Kata Sandi';
			case 'auth.passwordHint': return '········';
			case 'auth.nameLabel': return 'Nama Lengkap';
			case 'auth.nameHint': return 'Budi Santoso';
			case 'auth.dontHaveAccount': return 'Belum punya akun?';
			case 'auth.alreadyHaveAccount': return 'Sudah punya akun?';
			case 'auth.registerLink': return 'Daftar';
			case 'auth.loginLink': return 'Masuk';
			case 'auth.validation.emailRequired': return 'Email wajib diisi';
			case 'auth.validation.emailInvalid': return 'Masukkan alamat email yang valid';
			case 'auth.validation.passwordRequired': return 'Kata sandi wajib diisi';
			case 'auth.validation.passwordTooShort': return 'Kata sandi minimal 6 karakter';
			case 'auth.validation.nameRequired': return 'Nama lengkap wajib diisi';
			case 'auth.logoutButton': return 'Keluar';
			case 'auth.logoutConfirmTitle': return 'Keluar';
			case 'auth.logoutConfirmMessage': return 'Apakah Anda yakin ingin keluar?';
			case 'auth.devTestCredentialsHint': return 'Mode dev: ketuk untuk mengisi kredensial uji';
			case 'common.appName': return 'TUG Wellness';
			case 'common.ok': return 'OK';
			case 'common.cancel': return 'Batal';
			case 'common.confirm': return 'Konfirmasi';
			case 'common.retry': return 'Coba Lagi';
			case 'common.loading': return 'Memuat…';
			case 'common.save': return 'Simpan';
			case 'common.close': return 'Tutup';
			case 'common.error': return 'Terjadi kesalahan';
			case 'common.errorNetwork': return 'Tidak ada koneksi internet. Periksa jaringan Anda dan coba lagi.';
			case 'common.errorServer': return 'Terjadi kesalahan pada server. Silakan coba beberapa saat lagi.';
			case 'common.emptyState': return 'Belum ada data';
			case 'home.title': return 'Beranda';
			case 'home.welcome': return 'Anda telah masuk!';
			case 'settings.languageTitle': return 'Bahasa';
			case 'settings.languageEnglish': return 'English';
			case 'settings.languageIndonesian': return 'Bahasa Indonesia';
			case 'wellnessPackages.title': return 'Paket Wellness';
			case 'wellnessPackages.searchHint': return 'Cari paket…';
			case 'wellnessPackages.searchTooltipOpen': return 'Cari';
			case 'wellnessPackages.searchTooltipClose': return 'Hapus pencarian';
			case 'wellnessPackages.empty': return 'Belum ada paket tersedia';
			case 'wellnessPackages.emptySubtitle': return 'Kunjungi kembali untuk melihat paket wellness.';
			case 'wellnessPackages.loadingMoreLabel': return 'Memuat lebih banyak…';
			case 'wellnessPackages.durationMinutes': return ({required Object minutes}) => '${minutes} menit';
			case 'wellnessPackages.navButton': return 'Paket Wellness';
			default: return null;
		}
	}
}

