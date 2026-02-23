import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/app/theme/app_colors.dart';
import 'package:ielts_ai_trainer/app/theme/app_styles.dart';
import 'package:ielts_ai_trainer/features/setting/setting_api_service.dart';
import 'package:ielts_ai_trainer/shared/enums/ai_name.dart';
import 'package:ielts_ai_trainer/shared/setting/app_settings.dart';
import 'package:ielts_ai_trainer/shared/views/base_screen_scaffold.dart';
import 'package:ielts_ai_trainer/shared/views/loading_indicator.dart';
import 'package:ielts_ai_trainer/shared/views/texts.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Setting Screen.
class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

/// State for SettingScreen
class _SettingScreenState extends State<SettingScreen> {
  /// Selected AI Agent type.
  AiName _aiAgent = AppSettings.instance.aiAgent;

  /// Application version.
  String _version = '';

  /// ChatGPT availability status.
  String _chatGPTStatus = '';

  /// Gemini availability status.
  String _geminiStatus = '';

  /// Whether the mouse is on the AI Agent type area.
  bool _hoveringOnAiAgent = false;

  @override
  void initState() {
    super.initState();

    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      // Display version number beforehand.
      _version = packageInfo.version;
    });

    final srv = SettingApiService();
    final resp = await srv.getApiStatus();
    if (mounted) {
      // Check mounted, likely to have navigated to another screen.
      setState(() {
        _chatGPTStatus = resp.chatGPTStatus;
        _geminiStatus = resp.geminiStatus;
      });
    }
  }

  /// Options for prompt type.
  List<DropdownMenuEntry<AiName>> get _aiAgentEntries {
    final entries = <DropdownMenuEntry<AiName>>[];
    for (final ain in AiName.values) {
      final label = switch (ain) {
        AiName.chatGpt => 'Chat GPT',
        AiName.gemini => 'Gemini',
      };
      entries.add(
        DropdownMenuEntry(
          value: ain,
          label: label,
          style: MenuItemButton.styleFrom(
            textStyle: TextStyle(color: AppColors.textColor),
            foregroundColor: AppColors.textColor,
            backgroundColor: ain == _aiAgent ? Colors.grey.shade200 : null,
            overlayColor: Colors.grey,
          ),
        ),
      );
    }
    return entries;
  }

  /// Called when AI Agent type changes.
  void _onSelectedAiAgent(AiName? value) {
    if (value != null) {
      AppSettings.instance.setAiAgent(value);
      setState(() {
        _aiAgent = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: AppStyles.screenPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  // Title
                  ScreenTitleText('Setting'),
                  SizedBox(height: 20),
                  // AI Agent type
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: FieldLabel('AI Agent'),
                  ),
                  MouseRegion(
                    onEnter: (_) => setState(() => _hoveringOnAiAgent = true),
                    onExit: (_) => setState(() => _hoveringOnAiAgent = false),
                    child: DropdownMenu<AiName>(
                      textStyle: AppStyles.textFieldStyle(context),
                      inputDecorationTheme: InputDecorationTheme(
                        hintStyle: AppStyles.placeHolderText,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 11,
                          horizontal: 6,
                        ),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _hoveringOnAiAgent
                                ? AppColors.focusColor
                                : AppColors.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      width: 250,
                      requestFocusOnTap: false,
                      initialSelection: _aiAgent,
                      dropdownMenuEntries: _aiAgentEntries,
                      onSelected: _onSelectedAiAgent,
                    ),
                  ),
                  SizedBox(height: 20),
                  // ChatGPT Status
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: FieldLabel('ChatGPT Status'),
                  ),
                  if (_chatGPTStatus.isNotEmpty)
                    Text(_chatGPTStatus)
                  else
                    LoadingIndicator('Checking status...'),
                  SizedBox(height: 20),
                  // Gemini Status
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: FieldLabel('Gemini Status'),
                  ),
                  if (_geminiStatus.isNotEmpty)
                    Text(_geminiStatus)
                  else
                    LoadingIndicator('Checking status...'),
                  // To put version information in the bottom.
                  Spacer(),
                  if (_version.isNotEmpty) Text('ver. $_version'),
                  SizedBox(height: AppStyles.screenBottomPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
