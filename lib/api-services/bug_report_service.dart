import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BugReportService {
  static const String botUsername = "NES_Phoenix_SupportBot";

  Future<void> reportBug(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('user_id') ?? "Неизвестный пользователь";
    final String? userName = prefs.getString('user_name') ?? "Неизвестное имя";
    final String? appVersion = prefs.getString('app_version') ?? "Неизвестная версия";

    String currentScreen = ModalRoute.of(context)?.settings.name ?? "Неизвестный экран";

    String message =
        "🐞 Баг-репорт:\n"
        "👤 Пользователь: $userName ($userId)\n"
        "📲 Версия приложения: $appVersion\n"
        "📌 Текущий экран: $currentScreen\n"
        "✏️ Описание проблемы: ";

    String encodedMessage = Uri.encodeComponent(message);
    String telegramUrl = "https://t.me/$botUsername?text=$encodedMessage";

    if (await canLaunchUrl(Uri.parse(telegramUrl))) {
      await launchUrl(Uri.parse(telegramUrl), mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Не удалось открыть Telegram");
    }
  }
}
