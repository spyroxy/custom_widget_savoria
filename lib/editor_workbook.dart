import 'package:custom_widget_savoria/custom_widget.dart';
import 'package:custom_widget_savoria/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:highlight/languages/dart.dart';

class WidgetConfig {
  final String id;
  final String type;
  final Map<String, dynamic> properties;
  String? customCode;
  double top;
  double left;

  WidgetConfig(
      {required this.type,
      required this.properties,
      this.customCode,
      this.top = 50,
      this.left = 50})
      : id = DateTime.now().microsecondsSinceEpoch.toString();
}

class EditorWorkbook extends StatefulWidget {
  const EditorWorkbook({super.key});
  @override
  State<EditorWorkbook> createState() => _EditorWorkbookState();
}

class _EditorWorkbookState extends State<EditorWorkbook> {
  List<WidgetConfig> canvasItems = [];
  String rootLayout = 'Stack'; // Column, Row, ListView, Stack
  String deviceSize = 'Mobile'; // Mobile, Tablet, Web
  bool isLandscape = false;
  bool showGrid = false;
  bool isPreviewMode = false;
  int? selectedItemIndex;
  CodeController? _codeController;
  int? _lastSelectedIndex;
  String _canvasBg = 'solid_dark';

  final List<String> availableWidgets = [
    'Label',
    'Logo Placeholder',
    'Spacing',
    'Icon',
    // 'CustomTextFieldStandard',
    // 'CustomButtonStandard',
    // 'CustomCircleButton',
    'GlassCard',
    'GlassButton',
    'GlassBackground',
    'GlassContainer',
    'GlassTextField',
    'GlassPrefixTextField',
    'GlassDropdown',
    'GlassCheckbox',
    'GlassSwitch',
    'GlassTab',
    'GlassListTile',
    'GlassTable',
    // 'CustomDropdown',
    // 'CustomSearchText'
  ];

  Map<String, dynamic> _getDefaultProperties(String type) {
    switch (type) {
      case 'Label':
        return {
          'text': 'Login to Your Account',
          'fontSize': '24',
          'fontWeight': 'bold',
          'alignment': 'center',
          'color': 'Colors.white'
        };
      case 'Logo Placeholder':
        return {'size': '100'};
      case 'Spacing':
        return {'size': '20'}; // Can be width for Row, height for Column
      case 'Icon':
        return {'icon': 'Icons.star', 'color': 'Colors.white', 'size': '24'};
      case 'CustomButtonStandard':
        return {
          'size': '100',
          'title': 'Login',
          'colorButton': 'Colors.purpleAccent',
          'colorButtonIcon': 'Colors.purple'
        };
      case 'CustomTextFieldStandard':
        return {
          'label': 'Email',
          'hint': 'Enter your email',
          'isPassword': 'false',
          'colorIcon': 'Colors.grey',
          'colorObscure': 'Colors.grey'
        };
      case 'CustomCircleButton':
        return {
          'text': 'Star',
          'icon': 'Icons.star',
          'colorCircle': 'Colors.purpleAccent',
          'colorIcon': 'Colors.white',
          'colorText': 'Colors.white',
          'size': '50',
          'sizeIcon': '25'
        };
      case 'GlassCard':
        return {
          'title': 'Glass Card',
          'subtitle': 'This is a preview',
          'blur': '10',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.2'
        };
      case 'GlassButton':
        return {
          'text': 'Tap Me!',
          'borderRadius': '16',
          'fontSize': '16',
          'fontWeight': 'bold',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.2',
          'blur': '10',
          'textColor': 'Colors.white',
          'icon': 'none',
          'iconSize': '18',
          'iconColor': 'Colors.white',
        };
      case 'GlassBackground':
        return {'borderRadius': '10', 'companyColors': 'default'};
      case 'GlassContainer':
        return {
          'width': '200',
          'height': '150',
          'blur': '10',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.2'
        };
      case 'GlassTextField':
        return {
          'hint': 'Enter text...',
          'obscureText': 'false',
          'blur': '10',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.1'
        };
      case 'GlassPrefixTextField':
        return {
          'labelText': 'Calendar',
          'hintText': 'dd/mm/yyyy',
          'prefixIcon': 'Icons.calendar_month',
          'prefixColor': 'Color(0xFFE51C23)',
          'prefixWidth': '60',
          'borderRadius': '12',
          'blur': '10',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.08'
        };
      case 'GlassDropdown':
        return {
          'label': 'Select Option',
          'hint': 'Choose one...',
          'blur': '10',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.1'
        };
      case 'GlassCheckbox':
        return {
          'label': 'Remember me',
          'value': 'false',
          'blur': '10',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.1'
        };
      case 'GlassSwitch':
        return {
          'label': 'Enable feature',
          'value': 'false',
          'blur': '10',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.1'
        };
      case 'GlassTab':
        return {
          'tabs': 'Tab 1,Tab 2,Tab 3',
          'selectedIndex': '0',
          'blur': '10',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.08'
        };
      case 'GlassListTile':
        return {
          'title': 'DO12345678',
          'status': 'Ready',
          'statusColor': 'Color(0xFF81C784)',
          'statusTextColor': 'Color(0xFF2E7D32)',
          'headerIcon': 'Icons.inventory_2',
          'headerIconBgColor': 'Color(0xFF8B7EFE)',
          'name': 'Nur Said',
          'shop': 'Toko Berkah Jaya',
          'address':
              'Jl. Jendral Sudirman Kav 10, RT 05 \\ RW 10, Jakarta Pusat, Indonesia',
          'date': '2025-10-30',
          'actionText': 'Take Shipment',
          'actionColor': 'Color(0xFF5F51E8)',
          'color': 'Color(0xFFFFFFFF)',
          'opacity': '0.2',
          'blur': '10',
          'textColor': 'Colors.white',
          'subTextColor': 'Colors.white70',
        };
      case 'GlassTable':
        return {
          'columnsCount': '3',
          'rowsCount': '3',
          'borderRadius': '16',
          'blur': '10',
          'color': 'Colors.white',
          'opacity': '0.2',
          'textColor': 'Colors.white',
        };
      case 'CustomDropdown':
        return {'label': 'Select Option', 'hint': 'Choose one...'};
      case 'CustomSearchText':
        return {'hint': 'Search here...'};
      default:
        return {};
    }
  }

  BoxDecoration _getCanvasDecoration(bool hasCandidate) {
    if (hasCandidate) {
      return BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        border: deviceSize != 'Web'
            ? Border.all(color: Colors.grey, width: 2)
            : null,
      );
    }

    final border =
        deviceSize != 'Web' ? Border.all(color: Colors.grey, width: 2) : null;
    final boxShadow = deviceSize != 'Web'
        ? [const BoxShadow(color: Colors.black26, blurRadius: 10)]
        : null;

    switch (_canvasBg) {
      case 'solid_dark':
        return BoxDecoration(
          color: const Color(0xFF121212),
          border: border,
          boxShadow: boxShadow,
        );
      case 'solid_blue':
        return BoxDecoration(
          color: const Color(0xFF0D47A1),
          border: border,
          boxShadow: boxShadow,
        );
      case 'solid_purple':
        return BoxDecoration(
          color: const Color(0xFF4A148C),
          border: border,
          boxShadow: boxShadow,
        );
      case 'gradient_dusk':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF000000)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'gradient_ocean':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'gradient_sunset':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4568DC), Color(0xFFB06AB3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'gradient_neon':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'gradient_deep_space':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'savoria':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: GlassBackground.savoria,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'gonusa':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: GlassBackground.gonusa,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'gda':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: GlassBackground.gda,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'ptb':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: GlassBackground.ptb,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'skp':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: GlassBackground.skp,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      case 'skr':
        return BoxDecoration(
          gradient: const LinearGradient(
            colors: GlassBackground.skr,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: border,
          boxShadow: boxShadow,
        );
      default:
        return BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: border,
          boxShadow: boxShadow,
        );
    }
  }

  IconData _getIconDataFromString(String name) {
    String cleanName = name.trim();
    if (cleanName.startsWith('Icons.')) {
      cleanName = cleanName.substring(6);
    }
    switch (cleanName.toLowerCase()) {
      case 'star':
        return Icons.star;
      case 'home':
        return Icons.home;
      case 'add':
        return Icons.add;
      case 'close':
        return Icons.close;
      case 'settings':
        return Icons.settings;
      case 'person':
        return Icons.person;
      case 'search':
        return Icons.search;
      case 'favorite':
        return Icons.favorite;
      case 'info':
        return Icons.info;
      case 'check':
        return Icons.check;
      case 'warning':
        return Icons.warning;
      case 'error':
        return Icons.error;
      case 'lock':
        return Icons.lock;
      case 'login':
        return Icons.login;
      case 'qr_code':
        return Icons.qr_code;
      case 'touch_app':
        return Icons.touch_app;
      case 'edit':
        return Icons.edit;
      case 'image':
        return Icons.image;
      case 'preview':
        return Icons.preview;
      case 'email':
        return Icons.email;
      case 'phone':
        return Icons.phone;
      case 'notifications':
        return Icons.notifications;
      case 'menu':
        return Icons.menu;
      case 'share':
        return Icons.share;
      case 'refresh':
        return Icons.refresh;
      case 'arrow_back_ios':
        return Icons.arrow_back_ios;
      case 'arrow_forward_ios':
        return Icons.arrow_forward_ios;
      case 'play_arrow':
        return Icons.play_arrow;
      case 'pause':
        return Icons.pause;
      case 'inventory_2':
        return Icons.inventory_2;
      case 'storefront':
        return Icons.storefront;
      case 'location_on':
        return Icons.location_on;
      case 'calendar_today':
        return Icons.calendar_today;
      case 'calendar_month':
        return Icons.calendar_month;
      case 'chevron_right':
        return Icons.chevron_right;
      default:
        return Icons.help_outline;
    }
  }

  Color _getColorFromString(String colorStr) {
    String clean = colorStr.trim();
    if (clean.startsWith('Colors.')) {
      String colorName = clean.substring(7).toLowerCase();
      switch (colorName) {
        case 'white':
          return Colors.white;
        case 'black':
          return Colors.black;
        case 'blue':
          return Colors.blue;
        case 'red':
          return Colors.red;
        case 'green':
          return Colors.green;
        case 'yellow':
          return Colors.yellow;
        case 'orange':
          return Colors.orange;
        case 'purple':
          return Colors.purple;
        case 'pink':
          return Colors.pink;
        case 'grey':
          return Colors.grey;
        case 'amber':
          return Colors.amber;
        case 'teal':
          return Colors.teal;
        case 'cyan':
          return Colors.cyan;
        case 'transparent':
          return Colors.transparent;
        default:
          return Colors.white;
      }
    }
    if (clean.contains('Color(')) {
      final reg = RegExp(r'Color\(\s*0x([0-9a-fA-F]+)\s*\)');
      final match = reg.firstMatch(clean);
      if (match != null) {
        final hexStr = match.group(1);
        if (hexStr != null) {
          final val = int.tryParse(hexStr, radix: 16);
          if (val != null) return Color(val);
        }
      }
    }
    return Colors.white;
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GalleryThemeWrapper(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Playground Glassmorphism Widget Savoria V.1.1'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: deviceSize,
                    dropdownColor: Theme.of(context).primaryColor,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                    iconEnabledColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                    items: ['Mobile', 'Tablet', 'Web']
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Row(children: [
                              Icon(
                                  e == 'Mobile'
                                      ? Icons.phone_android
                                      : e == 'Tablet'
                                          ? Icons.tablet_mac
                                          : Icons.desktop_mac,
                                  size: 16,
                                  color: Colors.white),
                              const SizedBox(width: 8),
                              Text(e)
                            ])))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => deviceSize = v);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: rootLayout,
                    dropdownColor: Theme.of(context).primaryColor,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                    iconEnabledColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                    items: ['Column', 'Row', 'ListView', 'Stack']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => rootLayout = v);
                    },
                  ),
                ),
              ),
            ),
            if (deviceSize != 'Web')
              IconButton(
                icon: Icon(isLandscape
                    ? Icons.stay_current_landscape
                    : Icons.stay_current_portrait),
                tooltip: 'Toggle Orientation',
                onPressed: () => setState(() => isLandscape = !isLandscape),
              ),
            IconButton(
              icon: Icon(showGrid ? Icons.grid_off : Icons.grid_on),
              tooltip: 'Toggle Grid Ruler',
              onPressed: () => setState(() => showGrid = !showGrid),
            ),
            IconButton(
              icon:
                  Icon(isPreviewMode ? Icons.visibility_off : Icons.visibility),
              tooltip: 'Toggle Preview Mode',
              onPressed: () => setState(() => isPreviewMode = !isPreviewMode),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.wallpaper),
              tooltip: 'Canvas Background',
              onSelected: (value) {
                setState(() {
                  _canvasBg = value;
                });
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'default',
                  child: Row(
                    children: [
                      Icon(Icons.brightness_medium, color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Text('Default Theme'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'solid_dark',
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: Color(0xFF121212)),
                      SizedBox(width: 8),
                      Text('Solid Dark'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'solid_blue',
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: Color(0xFF0D47A1)),
                      SizedBox(width: 8),
                      Text('Solid Blue'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'solid_purple',
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: Color(0xFF4A148C)),
                      SizedBox(width: 8),
                      Text('Solid Purple'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'gradient_dusk',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Colors.teal),
                      SizedBox(width: 8),
                      Text('Gradient Dusk'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'gradient_ocean',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Gradient Ocean'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'gradient_sunset',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Colors.deepOrange),
                      SizedBox(width: 8),
                      Text('Gradient Sunset'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'gradient_neon',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Colors.pinkAccent),
                      SizedBox(width: 8),
                      Text('Gradient Neon'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'gradient_deep_space',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Colors.blueGrey),
                      SizedBox(width: 8),
                      Text('Gradient Deep Space'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'savoria',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Color(0xFFEC1B30)),
                      SizedBox(width: 8),
                      Text('Savoria Gradient'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'gonusa',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Color(0xFF382E82)),
                      SizedBox(width: 8),
                      Text('Gonusa Gradient'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'gda',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Color(0xFF00A3DE)),
                      SizedBox(width: 8),
                      Text('GDA Gradient'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'ptb',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Color(0xFFFAB726)),
                      SizedBox(width: 8),
                      Text('PTB Gradient'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'skp',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Color(0xFF57311F)),
                      SizedBox(width: 8),
                      Text('SKP Gradient'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'skr',
                  child: Row(
                    children: [
                      Icon(Icons.gradient, color: Color(0xFF004B8B)),
                      SizedBox(width: 8),
                      Text('SKR Gradient'),
                    ],
                  ),
                ),
              ],
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.palette_outlined),
              tooltip: 'Templates',
              onSelected: (value) {
                if (value == 'login_glass') {
                  _loadGlassLoginTemplate();
                } else if (value == 'login_web') {
                  _loadGlassWebLoginTemplate();
                } else if (value == 'list_glass_tile') {
                  _loadGlassListTileTemplate();
                } else if (value == 'clear') {
                  setState(() {
                    canvasItems.clear();
                  });
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'login_glass',
                  child: Row(
                    children: [
                      Icon(Icons.phone_android, color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Text('Glass Login Mobile'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'login_web',
                  child: Row(
                    children: [
                      Icon(Icons.desktop_mac, color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Text('Glass Login Web'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'list_glass_tile',
                  child: Row(
                    children: [
                      Icon(Icons.list, color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Text('Glass ListTile List'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text('Clear Canvas'),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.menu_book),
              onPressed: _showDeveloperGuide,
              tooltip: 'Developer & Integration Guide',
            ),
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: _showGeneratedCode,
              tooltip: 'Generate Code',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                setState(() {
                  canvasItems.clear();
                });
              },
              tooltip: 'Clear Canvas',
            ),
            ValueListenableBuilder<bool>(
              valueListenable: galleryThemeNotifier,
              builder: (context, isDark, _) {
                return IconButton(
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => galleryThemeNotifier.value = !isDark,
                  tooltip: 'Toggle Theme',
                );
              },
            ),
          ],
        ),
        body: Row(
          children: [
            // Sidebar (Toolbox)
            if (!isPreviewMode)
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                      right: BorderSide(color: Colors.grey.withOpacity(0.3))),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: availableWidgets.length,
                  itemBuilder: (context, index) {
                    final widgetName = availableWidgets[index];
                    return Draggable<String>(
                      data: widgetName,
                      feedback: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 140,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(widgetName,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)),
                        ),
                      ),
                      childWhenDragging: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(widgetName,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Theme.of(context).primaryColor.withOpacity(0.1),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(widgetName,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                ),
              ),

            // Canvas (Drag Target)
            Expanded(
              child: DragTarget<String>(
                onAcceptWithDetails: (details) {
                  setState(() {
                    WidgetConfig newConfig = WidgetConfig(
                      type: details.data,
                      properties: _getDefaultProperties(details.data),
                    );
                    newConfig.customCode = _generateWidgetString(newConfig);
                    canvasItems.add(newConfig);
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  double? w;
                  double? h;
                  if (deviceSize == 'Mobile') {
                    w = isLandscape ? 812 : 375;
                    h = isLandscape ? 375 : 812;
                  } else if (deviceSize == 'Tablet') {
                    w = isLandscape ? 1024 : 768;
                    h = isLandscape ? 768 : 1024;
                  }

                  Widget canvas = Container(
                    width: w,
                    height: h,
                    decoration: _getCanvasDecoration(candidateData.isNotEmpty),
                    child: ClipRect(
                      child: Stack(
                        children: [
                          if (_canvasBg != 'default') ...[
                            Positioned(
                              top: 80,
                              left: 30,
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pinkAccent,
                                      Colors.purpleAccent
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 120,
                              right: 20,
                              child: Container(
                                width: 220,
                                height: 220,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.cyanAccent,
                                      Colors.blueAccent
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 380,
                              right: 90,
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellowAccent.withOpacity(0.55),
                                ),
                              ),
                            ),
                          ],
                          if (showGrid && !isPreviewMode) ...[
                            const GridPaper(
                              color: Colors.blue,
                              interval: 50,
                              divisions: 1,
                              subdivisions: 5,
                              child: SizedBox.expand(),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  width: 1,
                                  color: Colors.redAccent.withOpacity(0.5)),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  height: 1,
                                  color: Colors.redAccent.withOpacity(0.5)),
                            ),
                          ],
                          _buildCanvasContent(),
                        ],
                      ),
                    ),
                  );

                  return Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black26
                        : Colors.black.withOpacity(0.05),
                    alignment: Alignment.center,
                    child: deviceSize == 'Web'
                        ? canvas
                        : SingleChildScrollView(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: canvas))),
                  );
                },
              ),
            ),
            if (!isPreviewMode &&
                selectedItemIndex != null &&
                selectedItemIndex! < canvasItems.length)
              _buildPropertiesPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildCanvasContent() {
    if (canvasItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.drag_indicator,
                size: 50, color: Colors.red.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text("Drag widgets kesini untuk memulai!",
                style: TextStyle(color: Colors.red.withOpacity(0.8))),
            const SizedBox(height: 8),
            Text("Layout Saat Ini: $rootLayout",
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    if (rootLayout == 'Stack') {
      return Stack(
        clipBehavior: Clip.none,
        children: canvasItems.asMap().entries.map((entry) {
          int index = entry.key;
          WidgetConfig config = entry.value;
          final double paddingOffset = selectedItemIndex == index ? 6 : 5;
          return Positioned(
            left: isPreviewMode ? config.left : config.left - paddingOffset,
            top: isPreviewMode ? config.top : config.top - paddingOffset,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  config.left += details.delta.dx;
                  config.top += details.delta.dy;
                });
              },
              child: _buildItemWrapper(index, config),
            ),
          );
        }).toList(),
      );
    } else if (rootLayout == 'Row') {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: canvasItems.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: _buildItemWrapper(entry.key, entry.value),
            );
          }).toList(),
        ),
      );
    } else {
      // Column or ListView
      return ReorderableListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: canvasItems.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = canvasItems.removeAt(oldIndex);
            canvasItems.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          final config = canvasItems[index];
          return Padding(
            key:
                ValueKey(config.id), // Unique key required for reorderable list
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildItemWrapper(index, config),
          );
        },
      );
    }
  }

  Widget _buildItemWrapper(int index, WidgetConfig config) {
    if (isPreviewMode) return _buildRealWidgetPreview(config);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () => _editProperties(index),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                  color: selectedItemIndex == index
                      ? Colors.blueAccent
                      : Colors.blueAccent.withOpacity(0.3),
                  width: selectedItemIndex == index ? 2 : 1,
                  style: BorderStyle.solid),
            ),
            child: IgnorePointer(
              child: _buildRealWidgetPreview(config),
            ),
          ),
        ),
        // Delete Button
        Positioned(
          right: -10,
          top: -10,
          child: InkWell(
            onTap: () {
              setState(() {
                canvasItems.removeAt(index);
              });
            },
            child: const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ),
        // Drag Handle / Move Indicator
        Positioned(
          left: -10,
          top: 10,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: rootLayout == 'Stack' ? Colors.green : Colors.grey,
            child: Icon(
                rootLayout == 'Stack' ? Icons.open_with : Icons.drag_handle,
                size: 12,
                color: Colors.white),
          ),
        ),
        // Resize Handle (Bottom-Right)
        if (selectedItemIndex == index)
          Positioned(
            right: -10,
            bottom: -10,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  double currentW = double.tryParse(
                          config.properties['width']?.toString() ?? '') ??
                      150;
                  double currentH = double.tryParse(
                          config.properties['height']?.toString() ?? '') ??
                      50;

                  if (config.properties['width'] == null &&
                      config.properties['height'] == null) {
                    if (config.type == 'GlassContainer') {
                      currentW = double.tryParse(
                              config.properties['width']?.toString() ??
                                  '200') ??
                          200;
                      currentH = double.tryParse(
                              config.properties['height']?.toString() ??
                                  '150') ??
                          150;
                    } else if (config.type == 'Spacing') {
                      final s = double.tryParse(
                              config.properties['size']?.toString() ?? '20') ??
                          20;
                      currentW = s;
                      currentH = s;
                    } else if (config.type == 'Logo Placeholder') {
                      final s = double.tryParse(
                              config.properties['size']?.toString() ?? '100') ??
                          100;
                      currentW = s;
                      currentH = s;
                    } else if (config.type == 'CustomSearchText') {
                      currentW = 300;
                      currentH = 50;
                    }
                  }

                  double newW = (currentW + details.delta.dx).clamp(20, 800);
                  double newH = (currentH + details.delta.dy).clamp(20, 800);

                  if (config.type == 'Spacing') {
                    config.properties['size'] =
                        (rootLayout == 'Row' ? newW : newH).toStringAsFixed(0);
                  } else if (config.type == 'Logo Placeholder') {
                    config.properties['size'] = newW.toStringAsFixed(0);
                  } else {
                    config.properties['width'] = newW.toStringAsFixed(0);
                    config.properties['height'] = newH.toStringAsFixed(0);
                  }

                  config.customCode = _generateWidgetString(config);
                  if (_codeController != null && selectedItemIndex == index) {
                    _codeController!.text = config.customCode!;
                  }
                });
              },
              child: const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.aspect_ratio, size: 12, color: Colors.white),
              ),
            ),
          )
      ],
    );
  }

  void _editProperties(int index) {
    setState(() {
      selectedItemIndex = index;
    });
  }

  Widget _buildPropertiesPanel() {
    final config = canvasItems[selectedItemIndex!];

    if (_lastSelectedIndex != selectedItemIndex) {
      _lastSelectedIndex = selectedItemIndex;
      _codeController?.dispose();
      _codeController = CodeController(
        text: config.customCode ?? _generateWidgetString(config),
        language: dart,
      );
    } else {
      final currentText = config.customCode ?? _generateWidgetString(config);
      if (_codeController != null && _codeController!.text != currentText) {
        _codeController!.text = currentText;
      }
    }

    return Container(
      width: 550,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(left: BorderSide(color: Colors.grey.withOpacity(0.3))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Properties: ${config.type}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => setState(() {
                    selectedItemIndex = null;
                    _lastSelectedIndex = null;
                    _codeController?.dispose();
                    _codeController = null;
                  }),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (config.type == 'GlassTextField' ||
                      config.type == 'CustomTextFieldStandard')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Obscure Text (Password)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          Switch(
                            value: config.type == 'GlassTextField'
                                ? config.properties['obscureText'] == 'true'
                                : config.properties['isPassword'] == 'true',
                            onChanged: (val) {
                              setState(() {
                                if (config.type == 'GlassTextField') {
                                  config.properties['obscureText'] =
                                      val ? 'true' : 'false';
                                } else {
                                  config.properties['isPassword'] =
                                      val ? 'true' : 'false';
                                }
                                config.customCode =
                                    _generateWidgetString(config);
                                _codeController?.text = config.customCode!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  if (config.type == 'GlassTextField' ||
                      config.type == 'CustomTextFieldStandard')
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  if (config.type == 'GlassCheckbox' ||
                      config.type == 'GlassSwitch')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            config.type == 'GlassCheckbox'
                                ? 'Checkbox Value'
                                : 'Switch Value',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          Switch(
                            value: config.properties['value'] == 'true',
                            onChanged: (val) {
                              setState(() {
                                config.properties['value'] =
                                    val ? 'true' : 'false';
                                config.customCode =
                                    _generateWidgetString(config);
                                _codeController?.text = config.customCode!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  if (config.type == 'GlassCheckbox' ||
                      config.type == 'GlassSwitch')
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  if (config.type == 'Label')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Text Color',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          Builder(builder: (context) {
                            final currentColor =
                                config.properties['color']?.toString() ??
                                    'Colors.white';
                            final itemsList = [
                              'Colors.white',
                              'Colors.white70',
                              'Colors.black',
                              'Colors.black87',
                              'Colors.blue',
                              'Colors.orange',
                              'Colors.red',
                              'Colors.green',
                              'Colors.grey'
                            ];
                            if (!itemsList.contains(currentColor)) {
                              itemsList.add(currentColor);
                            }
                            return DropdownButton<String>(
                              style: const TextStyle(color: Colors.black),
                              dropdownColor: Colors.white,
                              value: currentColor,
                              onChanged: (val) {
                                setState(() {
                                  config.properties['color'] = val;
                                  config.customCode =
                                      _generateWidgetString(config);
                                  _codeController?.text = config.customCode!;
                                });
                              },
                              items: itemsList.map((e) {
                                final label = e
                                    .replaceFirst('Colors.', '')
                                    .replaceFirst('Color(0xFF', '#')
                                    .replaceFirst(')', '');
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(label.isNotEmpty
                                      ? label[0].toUpperCase() +
                                          label.substring(1)
                                      : ''),
                                );
                              }).toList(),
                            );
                          }),
                        ],
                      ),
                    ),
                  if (config.type == 'Label')
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  if (config.type == 'Icon')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Icon Type',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Builder(builder: (context) {
                                final currentIcon =
                                    config.properties['icon']?.toString() ??
                                        'Icons.star';
                                final itemsList = [
                                  'Icons.check',
                                  'Icons.menu',
                                  'Icons.share',
                                  'Icons.refresh',
                                  'Icons.arrow_back_ios',
                                  'Icons.arrow_forward_ios',
                                  'Icons.play_arrow',
                                  'Icons.pause',
                                  'Icons.warning',
                                  'Icons.error',
                                  'Icons.lock',
                                  'Icons.edit',
                                  'Icons.image',
                                  'Icons.preview',
                                  'Icons.email',
                                  'Icons.phone',
                                  'Icons.star',
                                  'Icons.home',
                                  'Icons.person',
                                  'Icons.settings',
                                  'Icons.lock',
                                  'Icons.edit',
                                  'Icons.calendar_month',
                                  'Icons.notifications',
                                  'Icons.search',
                                  'Icons.info'
                                ];
                                if (!itemsList.contains(currentIcon)) {
                                  itemsList.add(currentIcon);
                                }
                                return DropdownButton<String>(
                                  style: const TextStyle(color: Colors.black),
                                  dropdownColor: Colors.white,
                                  value: currentIcon,
                                  onChanged: (val) {
                                    setState(() {
                                      config.properties['icon'] = val;
                                      config.customCode =
                                          _generateWidgetString(config);
                                      _codeController?.text =
                                          config.customCode!;
                                    });
                                  },
                                  items: itemsList.map((e) {
                                    final label = e.replaceFirst('Icons.', '');
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(label.isNotEmpty
                                          ? label[0].toUpperCase() +
                                              label.substring(1)
                                          : ''),
                                    );
                                  }).toList(),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Icon Color',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Builder(builder: (context) {
                                final currentColor =
                                    config.properties['color']?.toString() ??
                                        'Colors.white';
                                final itemsList = [
                                  'Colors.white',
                                  'Colors.white70',
                                  'Colors.black',
                                  'Colors.black87',
                                  'Colors.blue',
                                  'Colors.orange',
                                  'Colors.red',
                                  'Colors.green',
                                  'Colors.grey'
                                ];
                                if (!itemsList.contains(currentColor)) {
                                  itemsList.add(currentColor);
                                }
                                return DropdownButton<String>(
                                  style: const TextStyle(color: Colors.black),
                                  dropdownColor: Colors.white,
                                  value: currentColor,
                                  onChanged: (val) {
                                    setState(() {
                                      config.properties['color'] = val;
                                      config.customCode =
                                          _generateWidgetString(config);
                                      _codeController?.text =
                                          config.customCode!;
                                    });
                                  },
                                  items: itemsList.map((e) {
                                    final label = e
                                        .replaceFirst('Colors.', '')
                                        .replaceFirst('Color(0xFF', '#')
                                        .replaceFirst(')', '');
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(label.isNotEmpty
                                          ? label[0].toUpperCase() +
                                              label.substring(1)
                                          : ''),
                                    );
                                  }).toList(),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Icon Size',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              Builder(builder: (context) {
                                final currentSize =
                                    config.properties['size']?.toString() ??
                                        '24';
                                final itemsList = [
                                  '16',
                                  '20',
                                  '24',
                                  '30',
                                  '40',
                                  '50'
                                ];
                                if (!itemsList.contains(currentSize)) {
                                  itemsList.add(currentSize);
                                }
                                return DropdownButton<String>(
                                  style: const TextStyle(color: Colors.black),
                                  dropdownColor: Colors.white,
                                  value: currentSize,
                                  onChanged: (val) {
                                    setState(() {
                                      config.properties['size'] = val;
                                      config.customCode =
                                          _generateWidgetString(config);
                                      _codeController?.text =
                                          config.customCode!;
                                    });
                                  },
                                  items: itemsList
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (config.type == 'Icon')
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  if (config.type == 'CustomButtonStandard') ...[
                    _buildColorProperty(config, 'Button Color', 'colorButton',
                        'Colors.purpleAccent'),
                    _buildColorProperty(config, 'Icon Area Color',
                        'colorButtonIcon', 'Colors.purple'),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  ],
                  if (config.type == 'CustomTextFieldStandard') ...[
                    _buildColorProperty(
                        config, 'Icon Area Color', 'colorIcon', 'Colors.grey'),
                    _buildColorProperty(config, 'Visibility Icon Color',
                        'colorObscure', 'Colors.grey'),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  ],
                  if (config.type == 'CustomCircleButton') ...[
                    _buildColorProperty(config, 'Circle Color', 'colorCircle',
                        'Colors.purpleAccent'),
                    _buildColorProperty(
                        config, 'Icon Color', 'colorIcon', 'Colors.white'),
                    _buildColorProperty(
                        config, 'Text Color', 'colorText', 'Colors.white'),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  ],
                  if (config.type.startsWith('Glass') &&
                      config.type != 'GlassBackground') ...[
                    _buildColorProperty(
                        config, 'Glass Base Color', 'color', 'Colors.white'),
                    _buildSliderProperty(
                        config, 'Glass Opacity', 'opacity', 0.0, 1.0, 0.2),
                    _buildSliderProperty(
                        config, 'Glass Blur Amount', 'blur', 0.0, 30.0, 10.0),
                    if (config.type == 'GlassPrefixTextField')
                      _buildColorProperty(config, 'Prefix Container Color',
                          'prefixColor', 'Color(0xFFE51C23)'),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  ],
                  if (config.type == 'GlassButton') ...[
                    _buildTextProperty(
                        config, 'Button Text', 'text', 'Tap Me!'),
                    _buildTextProperty(config, 'Font Size', 'fontSize', '16'),
                    _buildTextProperty(
                        config, 'Border Radius', 'borderRadius', '16'),
                    _buildColorProperty(
                        config, 'Text Color', 'textColor', 'Colors.white'),
                    _buildIconProperty(config, 'Left Icon', 'icon'),
                    _buildTextProperty(config, 'Icon Size', 'iconSize', '18'),
                    _buildColorProperty(
                        config, 'Icon Color', 'iconColor', 'Colors.white'),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  ],
                  if (config.type == 'GlassTable') ...[
                    _buildTextProperty(
                        config, 'Columns Count', 'columnsCount', '3'),
                    _buildTextProperty(config, 'Rows Count', 'rowsCount', '3'),
                    _buildColorProperty(
                        config, 'Text Color', 'textColor', 'Colors.white'),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  ],
                  if (config.type == 'GlassListTile') ...[
                    _buildTextProperty(
                        config, 'Card Title', 'title', 'DO12345678'),
                    _buildTextProperty(
                        config, 'Status Text', 'status', 'Ready'),
                    _buildTextProperty(
                        config, 'Customer Name', 'name', 'Nur Said'),
                    _buildTextProperty(
                        config, 'Shop Name', 'shop', 'Toko Berkah Jaya'),
                    _buildTextProperty(config, 'Delivery Address', 'address',
                        'Jl. Jendral Sudirman Kav 10, RT 05 \\ RW 10, Jakarta Pusat, Indonesia'),
                    _buildTextProperty(
                        config, 'Delivery Date', 'date', '2025-10-30'),
                    _buildTextProperty(
                        config, 'Action Text', 'actionText', 'Take Shipment'),
                    _buildColorProperty(config, 'Status Bg Color',
                        'statusColor', 'Color(0xFF81C784)'),
                    _buildColorProperty(config, 'Status Text Color',
                        'statusTextColor', 'Color(0xFF2E7D32)'),
                    _buildColorProperty(config, 'Header Icon Bg',
                        'headerIconBgColor', 'Color(0xFF8B7EFE)'),
                    _buildColorProperty(config, 'Action Text Color',
                        'actionColor', 'Color(0xFF5F51E8)'),
                    _buildColorProperty(
                        config, 'Text Color', 'textColor', 'Colors.white'),
                    _buildColorProperty(config, 'Sub-text Color',
                        'subTextColor', 'Colors.white70'),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                  ],
                  if (config.type == 'GlassBackground')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Company Background',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          DropdownButton<String>(
                            value:
                                config.properties['companyColors'] ?? 'default',
                            onChanged: (val) {
                              setState(() {
                                config.properties['companyColors'] = val;
                                config.customCode =
                                    _generateWidgetString(config);
                                _codeController?.text = config.customCode!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                  value: 'default',
                                  child: Text('Default Dark')),
                              DropdownMenuItem(
                                  value: 'savoria', child: Text('Savoria')),
                              DropdownMenuItem(
                                  value: 'gonusa', child: Text('Gonusa')),
                              DropdownMenuItem(
                                  value: 'gda', child: Text('GDA')),
                              DropdownMenuItem(
                                  value: 'ptb', child: Text('PTB')),
                              DropdownMenuItem(
                                  value: 'skp', child: Text('SKP')),
                              DropdownMenuItem(
                                  value: 'skr', child: Text('SKR')),
                              DropdownMenuItem(
                                  value: 'light', child: Text('Light Glass')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (config.type == 'GlassBackground')
                    Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Raw Code Override (Export)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange)),
                  const SizedBox(height: 8),
                  const Text(
                      'Mengedit kode di bawah ini akan meng-update visual di Canvas secara otomatis dengan mendeteksi parameter properti yang dikenal.',
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: CodeTheme(
                      data: CodeThemeData(styles: draculaTheme),
                      child: CodeField(
                        controller: _codeController!,
                        cursorColor: Colors.blue,
                        textStyle: const TextStyle(
                            fontFamily: 'monospace', fontSize: 11),
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        lineNumbers: true,
                        wrap: true,
                        onChanged: (val) {
                          setState(() {
                            config.customCode = val;
                            _parsePropertiesFromCustomCode(config);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextProperty(WidgetConfig config, String label,
      String propertyKey, String defaultValue) {
    final String currentValue =
        config.properties[propertyKey]?.toString() ?? defaultValue;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 36,
              child: TextFormField(
                key: ValueKey('${config.id}_$propertyKey'),
                initialValue: currentValue,
                style: const TextStyle(color: Colors.black, fontSize: 13),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (val) {
                  config.properties[propertyKey] = val;
                  config.customCode = _generateWidgetString(config);
                  _codeController?.text = config.customCode!;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconProperty(
      WidgetConfig config, String label, String propertyKey) {
    final String currentIcon =
        config.properties[propertyKey]?.toString() ?? 'none';
    final itemsList = [
      'none',
      'Icons.login',
      'Icons.qr_code',
      'Icons.touch_app',
      'Icons.info',
      'Icons.home',
      'Icons.settings',
      'Icons.lock',
      'Icons.person',
      'Icons.search',
      'Icons.check',
      'Icons.close',
    ];
    if (!itemsList.contains(currentIcon)) {
      itemsList.add(currentIcon);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          DropdownButton<String>(
            style: const TextStyle(color: Colors.black),
            dropdownColor: Colors.white,
            value: currentIcon,
            onChanged: (val) {
              setState(() {
                config.properties[propertyKey] = val;
                config.customCode = _generateWidgetString(config);
                _codeController?.text = config.customCode!;
              });
            },
            items: itemsList.map((e) {
              final cleanLabel =
                  e == 'none' ? 'None' : e.replaceFirst('Icons.', '');
              return DropdownMenuItem(
                value: e,
                child: Text(cleanLabel.isNotEmpty
                    ? cleanLabel[0].toUpperCase() + cleanLabel.substring(1)
                    : ''),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorProperty(WidgetConfig config, String label,
      String propertyKey, String defaultValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Builder(builder: (context) {
            final currentColor =
                config.properties[propertyKey]?.toString() ?? defaultValue;
            final itemsList = [
              'Colors.white',
              'Colors.white70',
              'Colors.black',
              'Colors.black87',
              'Colors.blue',
              'Colors.orange',
              'Colors.red',
              'Colors.green',
              'Colors.grey',
              'Colors.purple',
              'Colors.purpleAccent',
              'Colors.amber',
              'Color(0xFFE51C23)',
              'Color(0x33FFFFFF)'
            ];
            if (!itemsList.contains(currentColor)) {
              itemsList.add(currentColor);
            }
            return DropdownButton<String>(
              style: const TextStyle(color: Colors.black),
              dropdownColor: Colors.white,
              value: currentColor,
              onChanged: (val) {
                setState(() {
                  config.properties[propertyKey] = val;
                  config.customCode = _generateWidgetString(config);
                  _codeController?.text = config.customCode!;
                });
              },
              items: itemsList.map((e) {
                String labelStr = e
                    .replaceFirst('Colors.', '')
                    .replaceFirst('Color(0xFF', '#')
                    .replaceFirst('Color(0x', '#')
                    .replaceFirst(')', '');
                if (labelStr == '33FFFFFF') labelStr = 'Glass (20%)';
                return DropdownMenuItem(
                  value: e,
                  child: Text(labelStr.isNotEmpty
                      ? labelStr[0].toUpperCase() + labelStr.substring(1)
                      : ''),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSliderProperty(WidgetConfig config, String label,
      String propertyKey, double min, double max, double defaultValue) {
    final double currentValue = double.tryParse(
            config.properties[propertyKey]?.toString() ??
                defaultValue.toString()) ??
        defaultValue;
    final int displayDecimals = max <= 1.0 ? 2 : 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
              Text(
                currentValue.toStringAsFixed(displayDecimals),
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blueAccent,
              inactiveTrackColor: Colors.blueAccent.withOpacity(0.2),
              thumbColor: Colors.blueAccent,
              overlayColor: Colors.blueAccent.withOpacity(0.1),
              valueIndicatorColor: Colors.blueAccent,
            ),
            child: Slider(
              value: currentValue,
              min: min,
              max: max,
              onChanged: (val) {
                setState(() {
                  config.properties[propertyKey] =
                      val.toStringAsFixed(displayDecimals);
                  config.customCode = _generateWidgetString(config);
                  _codeController?.text = config.customCode!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRealWidgetPreview(WidgetConfig config) {
    Widget child;
    switch (config.type) {
      case 'Label':
        FontWeight fw = FontWeight.normal;
        String fwStr =
            config.properties['fontWeight']?.toString().toLowerCase() ?? 'bold';
        if (fwStr == 'bold')
          fw = FontWeight.bold;
        else if (fwStr == 'w300')
          fw = FontWeight.w300;
        else if (fwStr == 'w400')
          fw = FontWeight.w400;
        else if (fwStr == 'w500')
          fw = FontWeight.w500;
        else if (fwStr == 'w600')
          fw = FontWeight.w600;
        else if (fwStr == 'w700') fw = FontWeight.w700;

        child = Text(
          config.properties['text'] ?? '',
          style: TextStyle(
            fontSize: double.tryParse(
                    config.properties['fontSize']?.toString() ?? '24') ??
                24,
            fontWeight: fw,
            color: _getColorFromString(
                config.properties['color'] ?? 'Colors.white'),
          ),
          textAlign: config.properties['alignment'] == 'center'
              ? TextAlign.center
              : TextAlign.left,
        );
        if (config.properties['alignment'] == 'center') {
          child = Center(child: child);
        }
        break;
      case 'GonusaLogo':
        child = const GonusaLogo();
        break;
      case 'SavoriaPillLogo':
        child = const SavoriaPillLogo();
        break;
      case 'Logo Placeholder':
        double size =
            double.tryParse(config.properties['size']?.toString() ?? '100') ??
                100;
        child = Center(
          child: PremiumAppLogo(size: size),
        );
        break;
      case 'Spacing':
        double s =
            double.tryParse(config.properties['size']?.toString() ?? '20') ??
                20;
        child = SizedBox(
          height: rootLayout == 'Row' ? null : s,
          width: rootLayout == 'Row' ? s : null,
          child: Container(
            color: Colors.blueAccent.withOpacity(0.1),
            child: Center(
                child: Text('Spacing: $s',
                    style: const TextStyle(
                        fontSize: 10, color: Colors.blueAccent))),
          ),
        );
        break;
      case 'Icon':
        final iconData =
            _getIconDataFromString(config.properties['icon'] ?? 'Icons.star');
        final color =
            _getColorFromString(config.properties['color'] ?? 'Colors.white');
        final size =
            double.tryParse(config.properties['size']?.toString() ?? '24') ??
                24.0;
        child = Icon(
          iconData,
          color: color,
          size: size,
        );
        break;
      case 'CustomButtonStandard':
        child = CustomButtonStandard(
            title: config.properties['title'] ?? 'Button',
            colorButton: _getColorFromString(
                config.properties['colorButton'] ?? 'Colors.purpleAccent'),
            colorButtonIcon: _getColorFromString(
                config.properties['colorButtonIcon'] ?? 'Colors.purple'),
            onTap: () {},
            icon: const Icon(Icons.touch_app, color: Colors.white));
        break;
      case 'CustomTextFieldStandard':
        bool isPass = config.properties['isPassword'] == 'true';
        child = SizedBox(
          width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                  config.properties['width'] == null
              ? 250
              : null,
          child: CustomTextFieldStandard(
              label: config.properties['label'] ?? '',
              hint: config.properties['hint'] ?? '',
              icon: isPass ? Icons.lock : Icons.edit,
              colorIcon: _getColorFromString(
                  config.properties['colorIcon'] ?? 'Colors.grey'),
              colorObscure: _getColorFromString(
                  config.properties['colorObscure'] ?? 'Colors.grey'),
              obscure: isPass),
        );
        break;
      case 'CustomCircleButton':
        child = CustomCircleButton(
            icon: _getIconDataFromString(
                config.properties['icon'] ?? 'Icons.star'),
            text: config.properties['text'] ?? '',
            onPressed: () {},
            colorCircle: _getColorFromString(
                config.properties['colorCircle'] ?? 'Colors.purpleAccent'),
            colorIcon: _getColorFromString(
                config.properties['colorIcon'] ?? 'Colors.white'),
            colorText: _getColorFromString(
                config.properties['colorText'] ?? 'Colors.white'),
            heightCircle: double.tryParse(
                    config.properties['size']?.toString() ?? '50') ??
                50,
            widhtCircle: double.tryParse(
                    config.properties['size']?.toString() ?? '50') ??
                50,
            sizeIcon: double.tryParse(
                    config.properties['sizeIcon']?.toString() ?? '25') ??
                25);
        break;
      case 'GlassListTile':
        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                    config.properties['width'] == null
                ? 350
                : null,
            child: GlassListTile(
              title: config.properties['title'] ?? 'DO12345678',
              status: config.properties['status'] ?? 'Ready',
              statusColor: _getColorFromString(
                  config.properties['statusColor'] ?? 'Color(0xFF81C784)'),
              statusTextColor: _getColorFromString(
                  config.properties['statusTextColor'] ?? 'Color(0xFF2E7D32)'),
              headerIcon: _getIconDataFromString(
                  config.properties['headerIcon'] ?? 'Icons.inventory_2'),
              headerIconBgColor: _getColorFromString(
                  config.properties['headerIconBgColor'] ??
                      'Color(0xFF8B7EFE)'),
              name: config.properties['name'] ?? '',
              shop: config.properties['shop'] ?? '',
              address: config.properties['address'] ?? '',
              date: config.properties['date'] ?? '',
              actionText: config.properties['actionText'] ?? '',
              actionColor: _getColorFromString(
                  config.properties['actionColor'] ?? 'Color(0xFF5F51E8)'),
              color: _getColorFromString(
                  config.properties['color'] ?? 'Colors.white'),
              opacity: double.tryParse(
                      config.properties['opacity']?.toString() ?? '0.2') ??
                  0.2,
              blur: double.tryParse(
                      config.properties['blur']?.toString() ?? '10') ??
                  10.0,
              textColor: _getColorFromString(
                  config.properties['textColor'] ?? 'Colors.white'),
              subTextColor: _getColorFromString(
                  config.properties['subTextColor'] ?? 'Colors.white70'),
            ));
        break;
      case 'GlassCard':
        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                    config.properties['width'] == null
                ? 250
                : null,
            child: GlassCard(
                title: config.properties['title'] ?? '',
                subtitle: config.properties['subtitle'] ?? '',
                blur: double.tryParse(
                        config.properties['blur']?.toString() ?? '10') ??
                    10.0,
                color: _getColorFromString(
                    config.properties['color'] ?? 'Colors.white'),
                opacity: double.tryParse(
                        config.properties['opacity']?.toString() ?? '0.2') ??
                    0.2,
                icon: Icons.preview));
        break;
      case 'GlassButton':
        FontWeight fwBtn = FontWeight.normal;
        String fwStrBtn =
            config.properties['fontWeight']?.toString().toLowerCase() ?? 'bold';
        if (fwStrBtn == 'bold')
          fwBtn = FontWeight.bold;
        else if (fwStrBtn == 'w300')
          fwBtn = FontWeight.w300;
        else if (fwStrBtn == 'w400')
          fwBtn = FontWeight.w400;
        else if (fwStrBtn == 'w500')
          fwBtn = FontWeight.w500;
        else if (fwStrBtn == 'w600')
          fwBtn = FontWeight.w600;
        else if (fwStrBtn == 'w700') fwBtn = FontWeight.w700;

        final iconStr = config.properties['icon']?.toString() ?? 'none';
        final iconData =
            iconStr == 'none' ? null : _getIconDataFromString(iconStr);

        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') && config.properties['width'] == null
                ? 250
                : null,
            child: GlassButton(
                onPressed: () {},
                borderRadius:
                    double.tryParse(config.properties['borderRadius']?.toString() ?? '16') ??
                        16,
                color: _getColorFromString(
                    config.properties['color'] ?? 'Colors.white'),
                opacity: double.tryParse(config.properties['opacity']?.toString() ?? '0.2') ??
                    0.2,
                blur: double.tryParse(config.properties['blur']?.toString() ?? '10') ??
                    10.0,
                icon: iconData,
                iconSize: double.tryParse(config.properties['iconSize']?.toString() ?? '18') ??
                    18.0,
                iconColor: _getColorFromString(
                    config.properties['iconColor'] ?? 'Colors.white'),
                child: Text(config.properties['text'] ?? 'Tap Me!',
                    style: TextStyle(color: _getColorFromString(config.properties['textColor'] ?? 'Colors.white'), fontSize: double.tryParse(config.properties['fontSize']?.toString() ?? '16') ?? 16, fontWeight: fwBtn))));
        break;
      case 'GlassTable':
        child = SizedBox(
          width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                  config.properties['width'] == null
              ? 300
              : null,
          child: GlassTable(
            columnsCount: int.tryParse(
                    config.properties['columnsCount']?.toString() ?? '3') ??
                3,
            rowsCount: int.tryParse(
                    config.properties['rowsCount']?.toString() ?? '3') ??
                3,
            borderRadius: double.tryParse(
                    config.properties['borderRadius']?.toString() ?? '16') ??
                16.0,
            blur: double.tryParse(
                    config.properties['blur']?.toString() ?? '10') ??
                10.0,
            color: _getColorFromString(
                config.properties['color'] ?? 'Colors.white'),
            opacity: double.tryParse(
                    config.properties['opacity']?.toString() ?? '0.2') ??
                0.2,
            textColor: _getColorFromString(
                config.properties['textColor'] ?? 'Colors.white'),
          ),
        );
        break;
      case 'GlassBackground':
        double w = MediaQuery.of(context).size.width;
        double h = MediaQuery.of(context).size.height;
        if (deviceSize == 'Mobile') {
          w = isLandscape ? 812 : 375;
          h = isLandscape ? 375 : 812;
        } else if (deviceSize == 'Tablet') {
          w = isLandscape ? 1024 : 768;
          h = isLandscape ? 768 : 1024;
        }

        List<Color>? selectedColors;
        final compColors =
            config.properties['companyColors']?.toString() ?? 'default';
        if (compColors == 'savoria')
          selectedColors = GlassBackground.savoria;
        else if (compColors == 'gonusa')
          selectedColors = GlassBackground.gonusa;
        else if (compColors == 'gda')
          selectedColors = GlassBackground.gda;
        else if (compColors == 'ptb')
          selectedColors = GlassBackground.ptb;
        else if (compColors == 'skp')
          selectedColors = GlassBackground.skp;
        else if (compColors == 'skr')
          selectedColors = GlassBackground.skr;
        else if (compColors == 'light') selectedColors = GlassBackground.light;

        child = SizedBox(
            height: h,
            width: w,
            child: GlassBackground(
              colors: selectedColors,
              child: const SizedBox(),
            ));
        break;
      case 'GlassContainer':
        child = GlassContainer(
          width: double.tryParse(
                  config.properties['width']?.toString() ?? '200') ??
              200,
          height: double.tryParse(
                  config.properties['height']?.toString() ?? '150') ??
              150,
          blur:
              double.tryParse(config.properties['blur']?.toString() ?? '10') ??
                  10,
          color:
              _getColorFromString(config.properties['color'] ?? 'Colors.white'),
          opacity: double.tryParse(
                  config.properties['opacity']?.toString() ?? '0.2') ??
              0.2,
          child: Center(
              child: Text(config.properties['text'] ?? '',
                  style: const TextStyle(color: Colors.white))),
        );
        break;
      case 'GlassTextField':
        final isPass = config.properties['obscureText'] == 'true';
        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                    config.properties['width'] == null
                ? 250
                : null,
            child: GlassTextField(
              controller:
                  TextEditingController(text: isPass ? 'password123' : ''),
              hintText: config.properties['hint'] ?? '',
              obscureText: isPass,
              color: _getColorFromString(
                  config.properties['color'] ?? 'Colors.white'),
              opacity: double.tryParse(
                      config.properties['opacity']?.toString() ?? '0.1') ??
                  0.1,
              blur: double.tryParse(
                      config.properties['blur']?.toString() ?? '10') ??
                  10.0,
            ));
        break;
      case 'GlassPrefixTextField':
        final prefixIcon = _getIconDataFromString(
            config.properties['prefixIcon'] ?? 'Icons.calendar_month');
        final prefixColor = _getColorFromString(
            config.properties['prefixColor'] ?? 'Color(0xFFE51C23)');
        final prefixWidth = double.tryParse(
                config.properties['prefixWidth']?.toString() ?? '60') ??
            60.0;
        final borderRadius = double.tryParse(
                config.properties['borderRadius']?.toString() ?? '12') ??
            12.0;
        final blur =
            double.tryParse(config.properties['blur']?.toString() ?? '10') ??
                10.0;
        final opacity = double.tryParse(
                config.properties['opacity']?.toString() ?? '0.08') ??
            0.08;
        final color =
            _getColorFromString(config.properties['color'] ?? 'Colors.white');

        child = SizedBox(
          width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                  config.properties['width'] == null
              ? 300
              : null,
          child: GlassPrefixTextField(
            labelText: config.properties['labelText'] ?? 'Label',
            hintText: config.properties['hintText'] ?? 'Enter text...',
            prefixIcon: prefixIcon,
            prefixColor: prefixColor,
            prefixWidth: prefixWidth,
            borderRadius: borderRadius,
            blur: blur,
            opacity: opacity,
            color: color,
          ),
        );
        break;
      case 'GlassDropdown':
        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                    config.properties['width'] == null
                ? 250
                : null,
            child: GlassDropdown(
              onTap: () {},
              labelText: config.properties['label'] ?? '',
              controller: TextEditingController(),
              hintText: config.properties['hint'] ?? '',
              color: _getColorFromString(
                  config.properties['color'] ?? 'Colors.white'),
              opacity: double.tryParse(
                      config.properties['opacity']?.toString() ?? '0.1') ??
                  0.1,
              blur: double.tryParse(
                      config.properties['blur']?.toString() ?? '10') ??
                  10.0,
            ));
        break;
      case 'GlassCheckbox':
        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                    config.properties['width'] == null
                ? 200
                : null,
            child: StatefulBuilder(builder: (context, setState) {
              return GlassCheckbox(
                label: config.properties['label'] ?? '',
                value: config.properties['value'] == 'true',
                color: _getColorFromString(
                    config.properties['color'] ?? 'Colors.white'),
                opacity: double.tryParse(
                        config.properties['opacity']?.toString() ?? '0.1') ??
                    0.1,
                blur: double.tryParse(
                        config.properties['blur']?.toString() ?? '10') ??
                    10.0,
                onChanged: (val) {
                  config.properties['value'] = val.toString();
                },
              );
            }));
        break;
      case 'GlassSwitch':
        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                    config.properties['width'] == null
                ? 200
                : null,
            child: StatefulBuilder(builder: (context, setState) {
              return GlassSwitch(
                label: config.properties['label'] ?? '',
                value: config.properties['value'] == 'true',
                color: _getColorFromString(
                    config.properties['color'] ?? 'Colors.white'),
                opacity: double.tryParse(
                        config.properties['opacity']?.toString() ?? '0.1') ??
                    0.1,
                blur: double.tryParse(
                        config.properties['blur']?.toString() ?? '10') ??
                    10.0,
                onChanged: (val) {
                  config.properties['value'] = val.toString();
                },
              );
            }));
        break;
      case 'GlassTab':
        final tabsList =
            (config.properties['tabs']?.toString() ?? 'Tab 1,Tab 2,Tab 3')
                .split(',')
                .map((e) => e.trim())
                .toList();
        final selectedIndex = int.tryParse(
                config.properties['selectedIndex']?.toString() ?? '0') ??
            0;
        child = SizedBox(child: StatefulBuilder(builder: (context, setState) {
          return GlassTab(
            tabs: tabsList,
            selectedIndex: selectedIndex,
            color: _getColorFromString(
                config.properties['color'] ?? 'Colors.white'),
            opacity: double.tryParse(
                    config.properties['opacity']?.toString() ?? '0.08') ??
                0.08,
            blur: double.tryParse(
                    config.properties['blur']?.toString() ?? '10') ??
                10.0,
            onTabSelected: (index) {
              config.properties['selectedIndex'] = index.toString();
            },
          );
        }));
        break;
      case 'CustomDropdown':
        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                    config.properties['width'] == null
                ? 250
                : null,
            child: CustomDropDown(
              onTap: () {},
              labelText: config.properties['label'] ?? '',
              textEditingController: TextEditingController(),
              hintText: config.properties['hint'] ?? '',
            ));
        break;
      case 'CustomSearchText':
        child = SizedBox(
            width: (rootLayout == 'Row' || rootLayout == 'Stack') &&
                    config.properties['width'] == null
                ? 300
                : null,
            child: CustomSearchText(
              textEditingController: TextEditingController(),
              hintText: config.properties['hint'] ?? '',
              onPressed: () {},
            ));
        break;
      default:
        child = Text(config.type);
    }
    if (config.type != 'GlassContainer' &&
        config.type != 'Spacing' &&
        config.type != 'Logo Placeholder') {
      final w = double.tryParse(config.properties['width']?.toString() ?? '');
      final h = double.tryParse(config.properties['height']?.toString() ?? '');
      if (w != null || h != null) {
        child = SizedBox(
          width: w,
          height: h,
          child: child,
        );
      }
    }
    return child;
  }

  String _generateWidgetString(WidgetConfig config) {
    StringBuffer sb = StringBuffer();
    switch (config.type) {
      case 'Label':
        String fwStr = config.properties['fontWeight']?.toString() ?? 'bold';
        String fwStl = config.properties['fontStyle']?.toString() ?? 'normal';
        String fwCode = fwStr == 'bold'
            ? 'FontWeight.bold'
            : (fwStr == 'normal' ? 'FontWeight.normal' : 'FontWeight.$fwStr');
        String fsCode = fwStl == 'italic'
            ? 'FontStyle.italic'
            : (fwStl == 'normal' ? 'FontStyle.normal' : 'FontStyle.$fwStl');
        sb.writeln('Text(');
        sb.writeln('  "${config.properties['text']}",');
        sb.writeln(
            '  style: TextStyle(fontSize: ${config.properties['fontSize']}, fontWeight: $fwCode, fontStyle: $fsCode, color: ${config.properties['color'] ?? 'Colors.white'}),');
        sb.writeln(
            '  textAlign: TextAlign.${config.properties['alignment'] == 'center' ? 'center' : 'left'},');
        sb.write(')');
        break;
      case 'GonusaLogo':
        sb.write('const GonusaLogo()');
        break;
      case 'SavoriaPillLogo':
        sb.write('const SavoriaPillLogo()');
        break;
      case 'Logo Placeholder':
        sb.writeln('Center(');
        sb.writeln('  child: PremiumAppLogo(');
        sb.writeln('    size: ${config.properties['size'] ?? '100'},');
        sb.writeln('  ),');
        sb.write(')');
        break;
      case 'Spacing':
        if (rootLayout == 'Row') {
          sb.write('const SizedBox(width: ${config.properties['size']})');
        } else {
          sb.write('const SizedBox(height: ${config.properties['size']})');
        }
        break;
      case 'Icon':
        sb.writeln('Icon(');
        sb.writeln('  ${config.properties['icon'] ?? 'Icons.star'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  size: ${config.properties['size'] ?? '24'},');
        sb.writeln(')');
        break;
      case 'CustomButtonStandard':
        sb.writeln('CustomButtonStandard(');
        sb.writeln('  title: "${config.properties['title']}",');
        sb.writeln(
            '  colorButton: ${config.properties['colorButton'] ?? 'Colors.purpleAccent'},');
        sb.writeln(
            '  colorButtonIcon: ${config.properties['colorButtonIcon'] ?? 'Colors.purple'},');
        sb.writeln('  onTap: () {},');
        sb.writeln('  icon: const Icon(Icons.touch_app, color: Colors.white),');
        sb.write(')');
        break;
      case 'CustomTextFieldStandard':
        bool isPass = config.properties['isPassword'] == 'true';
        sb.writeln('CustomTextFieldStandard(');
        sb.writeln('  label: "${config.properties['label']}",');
        sb.writeln('  hint: "${config.properties['hint']}",');
        sb.writeln('  icon: ${isPass ? 'Icons.lock' : 'Icons.edit'},');
        sb.writeln(
            '  colorIcon: ${config.properties['colorIcon'] ?? 'Colors.grey'},');
        sb.writeln(
            '  colorObscure: ${config.properties['colorObscure'] ?? 'Colors.grey'},');
        if (isPass) sb.writeln('  obscure: true,');
        sb.write(')');
        break;
      case 'CustomCircleButton':
        sb.writeln('CustomCircleButton(');
        sb.writeln(
            '  icon: ${config.properties['icon'] ?? 'Icons.star'}, text: "${config.properties['text']}",');
        sb.writeln('  onPressed: () {},');
        sb.writeln(
            '  colorCircle: ${config.properties['colorCircle'] ?? 'Colors.purpleAccent'},');
        sb.writeln(
            '  colorIcon: ${config.properties['colorIcon'] ?? 'Colors.white'},');
        sb.writeln(
            '  colorText: ${config.properties['colorText'] ?? 'Colors.white'},');
        sb.writeln(
            '  heightCircle: ${config.properties['size'] ?? '50'}, widhtCircle: ${config.properties['size'] ?? '50'}, sizeIcon: ${config.properties['sizeIcon'] ?? '25'},');
        sb.write(')');
        break;
      case 'GlassListTile':
        sb.writeln('GlassListTile(');
        sb.writeln('  title: "${config.properties['title'] ?? 'DO12345678'}",');
        sb.writeln('  status: "${config.properties['status'] ?? 'Ready'}",');
        sb.writeln(
            '  statusColor: ${config.properties['statusColor'] ?? 'Color(0xFF81C784)'},');
        sb.writeln(
            '  statusTextColor: ${config.properties['statusTextColor'] ?? 'Color(0xFF2E7D32)'},');
        sb.writeln(
            '  headerIcon: ${config.properties['headerIcon'] ?? 'Icons.inventory_2'},');
        sb.writeln(
            '  headerIconBgColor: ${config.properties['headerIconBgColor'] ?? 'Color(0xFF8B7EFE)'},');
        sb.writeln('  name: "${config.properties['name'] ?? ''}",');
        sb.writeln('  shop: "${config.properties['shop'] ?? ''}",');
        sb.writeln('  address: "${config.properties['address'] ?? ''}",');
        sb.writeln('  date: "${config.properties['date'] ?? ''}",');
        sb.writeln('  actionText: "${config.properties['actionText'] ?? ''}",');
        sb.writeln(
            '  actionColor: ${config.properties['actionColor'] ?? 'Color(0xFF5F51E8)'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.2'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.writeln(
            '  textColor: ${config.properties['textColor'] ?? 'Colors.white'},');
        sb.writeln(
            '  subTextColor: ${config.properties['subTextColor'] ?? 'Colors.white70'},');
        sb.write(')');
        break;
      case 'GlassTable':
        sb.writeln('GlassTable(');
        sb.writeln(
            '  columnsCount: ${config.properties['columnsCount'] ?? '3'},');
        sb.writeln('  rowsCount: ${config.properties['rowsCount'] ?? '3'},');
        sb.writeln(
            '  borderRadius: ${config.properties['borderRadius'] ?? '16'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.2'},');
        sb.writeln(
            '  textColor: ${config.properties['textColor'] ?? 'Colors.white'},');
        sb.write(')');
        break;
      case 'GlassCard':
        sb.writeln('GlassCard(');
        sb.writeln('  title: "${config.properties['title']}",');
        sb.writeln('  subtitle: "${config.properties['subtitle']}",');
        sb.writeln('  icon: Icons.preview,');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.2'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.write(')');
        break;
      case 'GlassButton':
        String fwStrBtn = config.properties['fontWeight']?.toString() ?? 'bold';
        String fwCodeBtn = fwStrBtn == 'bold'
            ? 'FontWeight.bold'
            : (fwStrBtn == 'normal'
                ? 'FontWeight.normal'
                : 'FontWeight.$fwStrBtn');
        sb.writeln('GlassButton(');
        sb.writeln('  onPressed: () {},');
        sb.writeln(
            '  borderRadius: ${config.properties['borderRadius'] ?? '16'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.2'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        final iconStr = config.properties['icon']?.toString() ?? 'none';
        if (iconStr != 'none') {
          sb.writeln('  icon: $iconStr,');
          sb.writeln('  iconSize: ${config.properties['iconSize'] ?? '18'},');
          sb.writeln(
              '  iconColor: ${config.properties['iconColor'] ?? 'Colors.white'},');
        }
        sb.writeln(
            '  child: Text("${config.properties['text'] ?? 'Tap Me!'}", style: TextStyle(color: ${config.properties['textColor'] ?? 'Colors.white'}, fontSize: ${config.properties['fontSize'] ?? '16'}, fontWeight: $fwCodeBtn)),');
        sb.writeln(')');
        break;
      case 'GlassBackground':
        final compColors =
            config.properties['companyColors']?.toString() ?? 'default';
        if (compColors != 'default') {
          sb.writeln('GlassBackground(');
          sb.writeln('  colors: GlassBackground.$compColors,');
          sb.writeln(
              '  child: const SizedBox(height: 200), // Replace with your content');
          sb.writeln(')');
        } else {
          sb.writeln('const GlassBackground(');
          sb.writeln(
              '  child: SizedBox(height: 200), // Replace with your content');
          sb.writeln(')');
        }
        break;
      case 'GlassContainer':
        sb.writeln('GlassContainer(');
        sb.writeln('  width: ${config.properties['width'] ?? '200'},');
        sb.writeln('  height: ${config.properties['height'] ?? '150'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.2'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.writeln(
            '  child: const Center(child: Text("${config.properties['text'] ?? ''}", style: TextStyle(color: Colors.white))),');
        sb.writeln(')');
        break;
      case 'GlassTextField':
        sb.writeln('GlassTextField(');
        sb.writeln('  controller: TextEditingController(),');
        sb.writeln('  hintText: "${config.properties['hint']}",');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.1'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        if (config.properties['obscureText'] == 'true') {
          sb.writeln('  obscureText: true,');
        }
        sb.writeln(')');
        break;
      case 'GlassPrefixTextField':
        sb.writeln('GlassPrefixTextField(');
        sb.writeln(
            '  labelText: "${config.properties['labelText'] ?? 'Label'}",');
        sb.writeln(
            '  hintText: "${config.properties['hintText'] ?? 'Enter text...'}",');
        sb.writeln(
            '  prefixIcon: ${config.properties['prefixIcon'] ?? 'Icons.calendar_month'},');
        sb.writeln(
            '  prefixColor: ${config.properties['prefixColor'] ?? 'Color(0xFFE51C23)'},');
        sb.writeln(
            '  prefixWidth: ${config.properties['prefixWidth'] ?? '60'},');
        sb.writeln(
            '  borderRadius: ${config.properties['borderRadius'] ?? '12'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.08'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.writeln(')');
        break;
      case 'GlassDropdown':
        sb.writeln('GlassDropdown(');
        sb.writeln('  onTap: () {},');
        sb.writeln('  labelText: "${config.properties['label'] ?? ''}",');
        sb.writeln('  controller: TextEditingController(),');
        sb.writeln('  hintText: "${config.properties['hint'] ?? ''}",');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.1'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.writeln(')');
        break;
      case 'GlassCheckbox':
        sb.writeln('GlassCheckbox(');
        sb.writeln('  label: "${config.properties['label'] ?? ''}",');
        sb.writeln('  value: ${config.properties['value'] == 'true'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.1'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.writeln('  onChanged: (val) {},');
        sb.writeln(')');
        break;
      case 'GlassSwitch':
        sb.writeln('GlassSwitch(');
        sb.writeln('  label: "${config.properties['label'] ?? ''}",');
        sb.writeln('  value: ${config.properties['value'] == 'true'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.1'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.writeln('  onChanged: (val) {},');
        sb.writeln(')');
        break;
      case 'GlassTab':
        final tabsString =
            config.properties['tabs']?.toString() ?? 'Tab 1,Tab 2,Tab 3';
        final tabsListCode = tabsString
            .split(',')
            .map((e) => '"${e.trim()}"')
            .toList()
            .toString();
        sb.writeln('GlassTab(');
        sb.writeln('  tabs: $tabsListCode,');
        sb.writeln(
            '  selectedIndex: ${config.properties['selectedIndex'] ?? '0'},');
        sb.writeln('  color: ${config.properties['color'] ?? 'Colors.white'},');
        sb.writeln('  opacity: ${config.properties['opacity'] ?? '0.08'},');
        sb.writeln('  blur: ${config.properties['blur'] ?? '10'},');
        sb.writeln('  onTabSelected: (index) {},');
        sb.writeln(')');
        break;
      case 'CustomDropdown':
        sb.writeln('CustomDropDown(');
        sb.writeln('  onTap: () {},');
        sb.writeln('  labelText: "${config.properties['label']}",');
        sb.writeln('  textEditingController: TextEditingController(),');
        sb.writeln('  hintText: "${config.properties['hint']}",');
        sb.writeln(')');
        break;
      case 'CustomSearchText':
        sb.writeln('CustomSearchText(');
        sb.writeln('  textEditingController: TextEditingController(),');
        sb.writeln('  hintText: "${config.properties['hint']}",');
        sb.writeln('  onPressed: () {},');
        sb.writeln(')');
        break;
    }
    String generated = sb.toString();
    if (config.type != 'GlassContainer' &&
        config.type != 'Spacing' &&
        config.type != 'Logo Placeholder') {
      final w = config.properties['width'];
      final h = config.properties['height'];
      if (w != null || h != null) {
        final wStr = w != null ? 'width: $w, ' : '';
        final hStr = h != null ? 'height: $h, ' : '';
        generated = 'SizedBox($wStr${hStr}child: $generated)';
      }
    }
    return generated.replaceAll('\n', '\n    '); // Indent properly
  }

  void _parsePropertiesFromCustomCode(WidgetConfig config) {
    final code = config.customCode;
    if (code == null || code.isEmpty) return;

    // Helper to find string values: key: "value" or key: 'value'
    String? parseStringProp(String key) {
      final reg = RegExp('$key\\s*:\\s*[\'"]([^\'"]*)[\'"]');
      final match = reg.firstMatch(code);
      return match?.group(1);
    }

    // Helper to find number values: key: 12.3
    String? parseNumberProp(String key) {
      final reg = RegExp('$key\\s*:\\s*([0-9.]+)');
      final match = reg.firstMatch(code);
      return match?.group(1);
    }

    // Helper to find boolean values: key: true/false
    String? parseBoolProp(String key) {
      final reg = RegExp('$key\\s*:\\s*(true|false)');
      final match = reg.firstMatch(code);
      return match?.group(1);
    }

    // Helper to find color values: key: Colors.white or key: Color(0xFF...)
    String? parseColorProp(String key) {
      final reg = RegExp(
          '$key\\s*:\\s*(Colors\\.[a-zA-Z_0-9]+|Color\\(\\s*0x[0-9a-fA-F]+\\s*\\))');
      final match = reg.firstMatch(code);
      return match?.group(1);
    }

    // Globally parse width and height for non-natively sized widgets
    if (config.type != 'GlassContainer' &&
        config.type != 'Spacing' &&
        config.type != 'Logo Placeholder') {
      final w = parseNumberProp('width');
      if (w != null) {
        config.properties['width'] = w;
      } else {
        config.properties.remove('width');
      }

      final h = parseNumberProp('height');
      if (h != null) {
        config.properties['height'] = h;
      } else {
        config.properties.remove('height');
      }
    }

    if (config.type == 'Label') {
      final textReg = RegExp(r'''Text\(\s*['"]([^'"]*)['"]''');
      final textMatch = textReg.firstMatch(code);
      if (textMatch != null) {
        config.properties['text'] = textMatch.group(1);
      }

      final fwReg = RegExp(r'fontWeight\s*:\s*FontWeight\.(\w+)');
      final fwMatch = fwReg.firstMatch(code);
      if (fwMatch != null) {
        config.properties['fontWeight'] = fwMatch.group(1);
      }

      final fwTextAlign = RegExp(r'textAlign\s*:\s*TextAlign\.(\w+)');
      final fwMatchTextAlign = fwTextAlign.firstMatch(code);
      if (fwMatchTextAlign != null) {
        config.properties['textAlign'] = fwMatchTextAlign.group(1);
      }

      final fwAlign = RegExp(r'alignment\s*:\s*Alignment\.(\w+)');
      final fwMatchAlign = fwAlign.firstMatch(code);
      if (fwMatchAlign != null) {
        config.properties['alignment'] = fwMatchAlign.group(1);
      }

      final fsMatch = parseNumberProp('fontSize');
      if (fsMatch != null) {
        config.properties['fontSize'] = fsMatch;
      }

      final fwStl = RegExp(r'fontStyle\s*:\s*FontStyle\.(\w+)');
      final fwMatchStl = fwStl.firstMatch(code);
      if (fwMatchStl != null) {
        config.properties['fontStyle'] = fwMatchStl.group(1);
      }

      final colorMatch = RegExp(
              r'color\s*:\s*(Colors\.[a-zA-Z_0-9]+|Color\(\s*0x[0-9a-fA-F]+\s*\))')
          .firstMatch(code);
      if (colorMatch != null) {
        config.properties['color'] = colorMatch.group(1);
      }
    } else if (config.type == 'CustomButtonStandard') {
      final title = parseStringProp('title');
      if (title != null) config.properties['title'] = title;

      final cb = parseColorProp('colorButton');
      if (cb != null) config.properties['colorButton'] = cb;

      final cbi = parseColorProp('colorButtonIcon');
      if (cbi != null) config.properties['colorButtonIcon'] = cbi;
    } else if (config.type == 'CustomTextFieldStandard') {
      final label = parseStringProp('label');
      if (label != null) config.properties['label'] = label;

      final hint = parseStringProp('hint');
      if (hint != null) config.properties['hint'] = hint;

      final isPass = parseBoolProp('obscure');
      if (isPass != null) config.properties['isPassword'] = isPass;

      final ci = parseColorProp('colorIcon');
      if (ci != null) config.properties['colorIcon'] = ci;

      final co = parseColorProp('colorObscure');
      if (co != null) config.properties['colorObscure'] = co;
    } else if (config.type == 'CustomCircleButton') {
      final text = parseStringProp('text');
      if (text != null) config.properties['text'] = text;

      final iconMatch =
          RegExp(r'icon\s*:\s*(Icons\.[a-zA-Z_0-9]+)').firstMatch(code);
      if (iconMatch != null) config.properties['icon'] = iconMatch.group(1);

      final cc = parseColorProp('colorCircle');
      if (cc != null) config.properties['colorCircle'] = cc;

      final ci = parseColorProp('colorIcon');
      if (ci != null) config.properties['colorIcon'] = ci;

      final ct = parseColorProp('colorText');
      if (ct != null) config.properties['colorText'] = ct;

      final hc = parseNumberProp('heightCircle');
      if (hc != null) config.properties['size'] = hc;

      final si = parseNumberProp('sizeIcon');
      if (si != null) config.properties['sizeIcon'] = si;
    } else if (config.type == 'GlassListTile') {
      final title = parseStringProp('title');
      if (title != null) config.properties['title'] = title;

      final status = parseStringProp('status');
      if (status != null) config.properties['status'] = status;

      final statusColor = parseColorProp('statusColor');
      if (statusColor != null) config.properties['statusColor'] = statusColor;

      final statusTextColor = parseColorProp('statusTextColor');
      if (statusTextColor != null)
        config.properties['statusTextColor'] = statusTextColor;

      final headerIconMatch =
          RegExp(r'headerIcon\s*:\s*(Icons\.[a-zA-Z_0-9]+)').firstMatch(code);
      if (headerIconMatch != null)
        config.properties['headerIcon'] = headerIconMatch.group(1);

      final headerIconBgColor = parseColorProp('headerIconBgColor');
      if (headerIconBgColor != null)
        config.properties['headerIconBgColor'] = headerIconBgColor;

      final name = parseStringProp('name');
      if (name != null) config.properties['name'] = name;

      final shop = parseStringProp('shop');
      if (shop != null) config.properties['shop'] = shop;

      final address = parseStringProp('address');
      if (address != null) config.properties['address'] = address;

      final date = parseStringProp('date');
      if (date != null) config.properties['date'] = date;

      final actionText = parseStringProp('actionText');
      if (actionText != null) config.properties['actionText'] = actionText;

      final actionColor = parseColorProp('actionColor');
      if (actionColor != null) config.properties['actionColor'] = actionColor;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;

      final textColor = parseColorProp('textColor');
      if (textColor != null) config.properties['textColor'] = textColor;

      final subTextColor = parseColorProp('subTextColor');
      if (subTextColor != null)
        config.properties['subTextColor'] = subTextColor;
    } else if (config.type == 'GlassTable') {
      final cc = parseNumberProp('columnsCount');
      if (cc != null) config.properties['columnsCount'] = cc;

      final rc = parseNumberProp('rowsCount');
      if (rc != null) config.properties['rowsCount'] = rc;

      final br = parseNumberProp('borderRadius');
      if (br != null) config.properties['borderRadius'] = br;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final textColor = parseColorProp('textColor');
      if (textColor != null) config.properties['textColor'] = textColor;
    } else if (config.type == 'GlassCard') {
      final title = parseStringProp('title');
      if (title != null) config.properties['title'] = title;

      final subtitle = parseStringProp('subtitle');
      if (subtitle != null) config.properties['subtitle'] = subtitle;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;
    } else if (config.type == 'GlassButton') {
      final textReg = RegExp(r'''Text\(\s*['"]([^'"]*)['"]''');
      final textMatch = textReg.firstMatch(code);
      if (textMatch != null) {
        config.properties['text'] = textMatch.group(1);
      }

      final br = parseNumberProp('borderRadius');
      if (br != null) config.properties['borderRadius'] = br;

      final fs = parseNumberProp('fontSize');
      if (fs != null) config.properties['fontSize'] = fs;

      final fwReg = RegExp(r'fontWeight\s*:\s*FontWeight\.(\w+)');
      final fwMatch = fwReg.firstMatch(code);
      if (fwMatch != null) {
        config.properties['fontWeight'] = fwMatch.group(1);
      }

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final txtColMatch = RegExp(
              r'TextStyle\(\s*color\s*:\s*(Colors\.[a-zA-Z_0-9]+|Color\(\s*0x[0-9a-fA-F]+\s*\))')
          .firstMatch(code);
      if (txtColMatch != null) {
        config.properties['textColor'] = txtColMatch.group(1);
      }

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;

      final iconMatch =
          RegExp(r'icon\s*:\s*(Icons\.[a-zA-Z_0-9]+)').firstMatch(code);
      if (iconMatch != null) {
        config.properties['icon'] = iconMatch.group(1);
      } else {
        config.properties['icon'] = 'none';
      }

      final iconSz = parseNumberProp('iconSize');
      if (iconSz != null) config.properties['iconSize'] = iconSz;

      final iconCol = parseColorProp('iconColor');
      if (iconCol != null) config.properties['iconColor'] = iconCol;
    } else if (config.type == 'GonusaLogo') {
      // No properties to parse
    } else if (config.type == 'SavoriaPillLogo') {
      // No properties to parse
    } else if (config.type == 'GlassBackground') {
      final compMatch =
          RegExp(r'colors\s*:\s*GlassBackground\.(\w+)').firstMatch(code);
      if (compMatch != null) {
        config.properties['companyColors'] = compMatch.group(1);
      } else {
        config.properties['companyColors'] = 'default';
      }
    } else if (config.type == 'GlassContainer') {
      final w = parseNumberProp('width');
      if (w != null) config.properties['width'] = w;

      final h = parseNumberProp('height');
      if (h != null) config.properties['height'] = h;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;
    } else if (config.type == 'GlassTextField') {
      final hint = parseStringProp('hintText');
      if (hint != null) config.properties['hint'] = hint;
      final obscure = parseBoolProp('obscureText');
      if (obscure != null) config.properties['obscureText'] = obscure;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;
    } else if (config.type == 'GlassPrefixTextField') {
      final labelMatch = parseStringProp('labelText');
      if (labelMatch != null) config.properties['labelText'] = labelMatch;

      final hintMatch = parseStringProp('hintText');
      if (hintMatch != null) config.properties['hintText'] = hintMatch;

      final prefixIconMatch =
          RegExp(r'prefixIcon\s*:\s*(Icons\.[a-zA-Z_0-9]+)').firstMatch(code);
      if (prefixIconMatch != null) {
        config.properties['prefixIcon'] = prefixIconMatch.group(1);
      }

      final prefixColorMatch = RegExp(
              r'prefixColor\s*:\s*(Colors\.[a-zA-Z_0-9]+|Color\(\s*0x[0-9a-fA-F]+\s*\))')
          .firstMatch(code);
      if (prefixColorMatch != null) {
        config.properties['prefixColor'] = prefixColorMatch.group(1);
      }

      final prefixWidthMatch = parseNumberProp('prefixWidth');
      if (prefixWidthMatch != null)
        config.properties['prefixWidth'] = prefixWidthMatch;

      final borderRadiusMatch = parseNumberProp('borderRadius');
      if (borderRadiusMatch != null)
        config.properties['borderRadius'] = borderRadiusMatch;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final opacityMatch = parseNumberProp('opacity');
      if (opacityMatch != null) config.properties['opacity'] = opacityMatch;

      final blurMatch = parseNumberProp('blur');
      if (blurMatch != null) config.properties['blur'] = blurMatch;
    } else if (config.type == 'GlassDropdown') {
      final label = parseStringProp('labelText');
      if (label != null) config.properties['label'] = label;

      final hint = parseStringProp('hintText');
      if (hint != null) config.properties['hint'] = hint;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;
    } else if (config.type == 'GlassCheckbox') {
      final label = parseStringProp('label');
      if (label != null) config.properties['label'] = label;

      final val = parseBoolProp('value');
      if (val != null) config.properties['value'] = val;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;
    } else if (config.type == 'GlassSwitch') {
      final label = parseStringProp('label');
      if (label != null) config.properties['label'] = label;

      final val = parseBoolProp('value');
      if (val != null) config.properties['value'] = val;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;
    } else if (config.type == 'GlassTab') {
      final tabsReg = RegExp(r'tabs\s*:\s*\[([^\]]*)\]');
      final tabsMatch = tabsReg.firstMatch(code);
      if (tabsMatch != null) {
        final items = RegExp('[\'"]([^\'"]*)[\'"]')
            .allMatches(tabsMatch.group(1) ?? '')
            .map((m) => m.group(1))
            .join(',');
        config.properties['tabs'] = items;
      }
      final selectedIndex = parseNumberProp('selectedIndex');
      if (selectedIndex != null)
        config.properties['selectedIndex'] = selectedIndex;

      final col = parseColorProp('color');
      if (col != null) config.properties['color'] = col;

      final op = parseNumberProp('opacity');
      if (op != null) config.properties['opacity'] = op;

      final blur = parseNumberProp('blur');
      if (blur != null) config.properties['blur'] = blur;
    } else if (config.type == 'CustomDropdown') {
      final label = parseStringProp('labelText');
      if (label != null) config.properties['label'] = label;

      final hint = parseStringProp('hintText');
      if (hint != null) config.properties['hint'] = hint;
    } else if (config.type == 'CustomSearchText') {
      final hint = parseStringProp('hintText');
      if (hint != null) config.properties['hint'] = hint;
    } else if (config.type == 'Spacing') {
      final w = parseNumberProp('width');
      final h = parseNumberProp('height');
      final size = parseNumberProp('size');
      if (w != null)
        config.properties['size'] = w;
      else if (h != null)
        config.properties['size'] = h;
      else if (size != null) config.properties['size'] = size;
    } else if (config.type == 'Icon') {
      final iconMatch =
          RegExp(r'Icon\(\s*(Icons\.[a-zA-Z_0-9]+)').firstMatch(code);
      if (iconMatch != null) {
        config.properties['icon'] = iconMatch.group(1);
      }
      final colorMatch = RegExp(
              r'color\s*:\s*(Colors\.[a-zA-Z_0-9]+|Color\(\s*0x[0-9a-fA-F]+\s*\))')
          .firstMatch(code);
      if (colorMatch != null) {
        config.properties['color'] = colorMatch.group(1);
      }
      final size = parseNumberProp('size');
      if (size != null) config.properties['size'] = size;
    } else if (config.type == 'Logo Placeholder') {
      final size = parseNumberProp('size');
      final w = parseNumberProp('width');
      final h = parseNumberProp('height');
      if (size != null)
        config.properties['size'] = size;
      else if (w != null)
        config.properties['size'] = w;
      else if (h != null) config.properties['size'] = h;
    }
  }

  void _loadGlassLoginTemplate() {
    setState(() {
      rootLayout = 'Stack';
      deviceSize = 'Mobile';
      isLandscape = false;
      canvasItems.clear();
      selectedItemIndex = null;
      _lastSelectedIndex = null;
      _codeController?.dispose();
      _codeController = null;

      // 1. Background (Light Glass Background)
      // final bg = WidgetConfig(
      //   type: 'GlassBackground',
      //   properties: {
      //     'companyColors': 'light',
      //   },
      //   top: 0,
      //   left: 0,
      // );
      // bg.customCode = _generateWidgetString(bg);

      // 2. Savoria Pill Logo (Top Right)
      final savoriaLogo = WidgetConfig(
        type: 'SavoriaPillLogo',
        properties: {},
        top: 50,
        left: 280,
      );
      savoriaLogo.customCode = _generateWidgetString(savoriaLogo);

      // 3. App Logo (Center Top)
      final appLogo = WidgetConfig(
        type: 'Logo Placeholder',
        properties: {
          'size': '110',
        },
        top: 110,
        left: 132.5,
      );
      appLogo.customCode = _generateWidgetString(appLogo);

      // 4. App Name Title
      final title = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'APP NAME',
          'fontSize': '28',
          'fontWeight': 'bold',
          'color': 'Color(0xFF312E81)',
          'alignment': 'center',
        },
        top: 235,
        left: 20,
      );
      title.properties['width'] = '335';
      title.properties['height'] = '40';
      title.customCode = _generateWidgetString(title);

      // 5. Subtitle
      final subtitle = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Silahkan login untuk melanjutkan',
          'fontSize': '14',
          'fontWeight': 'normal',
          'color': 'Colors.black54',
          'alignment': 'center',
        },
        top: 275,
        left: 20,
      );
      subtitle.properties['width'] = '335';
      subtitle.properties['height'] = '30';
      subtitle.customCode = _generateWidgetString(subtitle);

      // 6. NIK Label
      final nikLabel = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'NIK',
          'fontSize': '13',
          'fontWeight': 'bold',
          'color': 'Colors.black87',
          'alignment': 'left',
        },
        top: 320,
        left: 24,
      );
      nikLabel.properties['width'] = '327';
      nikLabel.properties['height'] = '20';
      nikLabel.customCode = _generateWidgetString(nikLabel);

      // 7. NIK Text Field
      final nikField = WidgetConfig(
        type: 'GlassPrefixTextField',
        properties: {
          'labelText': '',
          'hintText': '7023xxx',
          'prefixIcon': 'Icons.person',
          'prefixColor': 'Color(0xFF312E81)',
          'color': 'Colors.black12',
          'opacity': '0.05',
          'textColor': 'Colors.black87',
          'subTextColor': 'Colors.black38',
        },
        top: 345,
        left: 24,
      );
      nikField.properties['width'] = '327';
      nikField.properties['height'] = '60';
      nikField.customCode = _generateWidgetString(nikField);

      // 8. Password Label
      final passwordLabel = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Password',
          'fontSize': '13',
          'fontWeight': 'bold',
          'color': 'Colors.black87',
          'alignment': 'left',
        },
        top: 415,
        left: 24,
      );
      passwordLabel.properties['width'] = '327';
      passwordLabel.properties['height'] = '20';
      passwordLabel.customCode = _generateWidgetString(passwordLabel);

      // 9. Password Text Field
      final passwordField = WidgetConfig(
        type: 'GlassPrefixTextField',
        properties: {
          'labelText': '',
          'hintText': '••••••••',
          'prefixIcon': 'Icons.lock',
          'prefixColor': 'Color(0xFF312E81)',
          'obscureText': 'true',
          'color': 'Colors.black12',
          'opacity': '0.05',
          'textColor': 'Colors.black87',
          'subTextColor': 'Colors.black38',
        },
        top: 440,
        left: 24,
      );
      passwordField.properties['width'] = '327';
      passwordField.properties['height'] = '60';
      passwordField.customCode = _generateWidgetString(passwordField);

      // 10. Login Button (Solid Indigo Background)
      final loginBtn = WidgetConfig(
        type: 'GlassButton',
        properties: {
          'text': 'LOGIN',
          'fontSize': '14',
          'fontWeight': 'bold',
          'borderRadius': '8',
          'color': 'Color(0xFF312E81)',
          'opacity': '0.95',
          'textColor': 'Colors.white',
        },
        top: 515,
        left: 24,
      );
      loginBtn.properties['width'] = '327';
      loginBtn.properties['height'] = '48';
      loginBtn.customCode = _generateWidgetString(loginBtn);

      // 11. OR Divider Text
      final orDivider = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'OR',
          'fontSize': '12',
          'fontWeight': 'bold',
          'color': 'Colors.black87',
          'alignment': 'center',
        },
        top: 580,
        left: 24,
      );
      orDivider.properties['width'] = '327';
      orDivider.properties['height'] = '20';
      orDivider.customCode = _generateWidgetString(orDivider);

      // 12. Scan QR Button
      final qrBtn = WidgetConfig(
        type: 'GlassButton',
        properties: {
          'text': 'SCAN WITH QR',
          'fontSize': '14',
          'fontWeight': 'bold',
          'borderRadius': '8',
          'color': 'Colors.white',
          'opacity': '0.8',
          'textColor': 'Color(0xFF312E81)',
        },
        top: 615,
        left: 24,
      );
      qrBtn.properties['width'] = '327';
      qrBtn.properties['height'] = '48';
      qrBtn.customCode = _generateWidgetString(qrBtn);

      // 13. Version Label (v1.0.0)
      final versionLabel = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'V.1.0.0',
          'fontSize': '12',
          'fontWeight': 'bold',
          'color': 'Colors.black87',
          'alignment': 'center',
        },
        top: 700,
        left: 24,
      );
      versionLabel.properties['width'] = '327';
      versionLabel.properties['height'] = '20';
      versionLabel.customCode = _generateWidgetString(versionLabel);

      // 14. Gonusa Prima Distribusi Logo
      final gonusaLogo = WidgetConfig(
        type: 'GonusaLogo',
        properties: {},
        top: 725,
        left: 110,
      );
      gonusaLogo.customCode = _generateWidgetString(gonusaLogo);

      // 15. Copyright Label
      final copyrightLabel = WidgetConfig(
        type: 'Label',
        properties: {
          'text': '© 2025 Savoria. All rights reserved.',
          'fontSize': '12',
          'fontWeight': 'normal',
          'color': 'Colors.black54',
          'alignment': 'center',
        },
        top: 755,
        left: 24,
      );
      copyrightLabel.properties['width'] = '327';
      copyrightLabel.properties['height'] = '20';
      copyrightLabel.customCode = _generateWidgetString(copyrightLabel);

      canvasItems.addAll([
        // bg,
        savoriaLogo,
        appLogo,
        title,
        subtitle,
        nikLabel,
        nikField,
        passwordLabel,
        passwordField,
        loginBtn,
        orDivider,
        qrBtn,
        versionLabel,
        gonusaLogo,
        copyrightLabel
      ]);
    });
  }

  void _loadGlassWebLoginTemplate() {
    setState(() {
      rootLayout = 'Stack';
      deviceSize = 'Web';
      isLandscape = false;
      canvasItems.clear();
      selectedItemIndex = null;
      _lastSelectedIndex = null;
      _codeController?.dispose();
      _codeController = null;

      final bg = WidgetConfig(
        type: 'GlassBackground',
        properties: {},
        top: 0,
        left: 0,
      );
      bg.customCode = _generateWidgetString(bg);

      // Left Container (Login Form)
      final leftContainer = WidgetConfig(
        type: 'GlassContainer',
        properties: {
          'width': '500',
          'height': '580',
          'blur': '15',
        },
        top: 80,
        left: 80,
      );
      leftContainer.customCode = _generateWidgetString(leftContainer);

      // Logo Placeholder
      final logo = WidgetConfig(
        type: 'Logo Placeholder',
        properties: {
          'size': '90',
        },
        top: 120,
        left: 285,
      );
      logo.customCode = _generateWidgetString(logo);

      // GIMS Title
      final title = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'GIMS',
          'fontSize': '28',
          'fontWeight': 'bold',
          'alignment': 'center',
          'width': '200',
          'height': '35',
        },
        top: 220,
        left: 230,
      );
      title.customCode = _generateWidgetString(title);

      // GIMS Subtitle
      final subtitle = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Gonusa Inventory Management System',
          'fontSize': '12',
          'fontWeight': 'normal',
          'alignment': 'center',
          'width': '400',
          'height': '20',
        },
        top: 260,
        left: 130,
      );
      subtitle.customCode = _generateWidgetString(subtitle);

      // Email Label
      final emailLabel = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Full Name / Email',
          'fontSize': '12',
          'fontWeight': 'w500',
          'alignment': 'left',
          'width': '400',
          'height': '20',
        },
        top: 300,
        left: 130,
      );
      emailLabel.customCode = _generateWidgetString(emailLabel);

      // Email Field
      final emailField = WidgetConfig(
        type: 'GlassTextField',
        properties: {
          'hint': 'you@savoria.co.id',
          'width': '400',
          'height': '50',
        },
        top: 325,
        left: 130,
      );
      emailField.customCode = _generateWidgetString(emailField);

      // Password Label
      final passwordLabel = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Password',
          'fontSize': '12',
          'fontWeight': 'w500',
          'alignment': 'left',
          'width': '400',
          'height': '20',
        },
        top: 390,
        left: 130,
      );
      passwordLabel.customCode = _generateWidgetString(passwordLabel);

      // Password Field
      final passwordField = WidgetConfig(
        type: 'GlassTextField',
        properties: {
          'hint': '••••••••',
          'width': '400',
          'height': '50',
          'obscureText': 'true',
        },
        top: 415,
        left: 130,
      );
      passwordField.customCode = _generateWidgetString(passwordField);

      // Remember Me Label
      final rememberMe = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Remember me',
          'fontSize': '11',
          'fontWeight': 'normal',
          'alignment': 'left',
          'width': '150',
          'height': '20',
        },
        top: 480,
        left: 130,
      );
      rememberMe.customCode = _generateWidgetString(rememberMe);

      // Forgot Password Label
      final forgotPassword = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Forgot Password?',
          'fontSize': '11',
          'fontWeight': 'normal',
          'alignment': 'right',
          'width': '150',
          'height': '20',
        },
        top: 480,
        left: 380,
      );
      forgotPassword.customCode = _generateWidgetString(forgotPassword);

      // Login Button
      final loginBtn = WidgetConfig(
        type: 'GlassButton',
        properties: {
          'text': 'LOGIN',
          'fontSize': '14',
          'fontWeight': 'bold',
          'borderRadius': '12',
          'width': '400',
          'height': '45',
        },
        top: 515,
        left: 130,
      );
      loginBtn.customCode = _generateWidgetString(loginBtn);

      // Footer
      final footer = WidgetConfig(
        type: 'Label',
        properties: {
          'text': '© 2025 Gonusa Prima Distribusi. All rights reserved.',
          'fontSize': '10',
          'fontWeight': 'normal',
          'alignment': 'center',
          'width': '400',
          'height': '20',
        },
        top: 620,
        left: 130,
      );
      footer.customCode = _generateWidgetString(footer);

      // Right Container (App Info)
      final rightContainer = WidgetConfig(
        type: 'GlassContainer',
        properties: {
          'width': '460',
          'height': '580',
          'blur': '15',
        },
        top: 80,
        left: 620,
      );
      rightContainer.customCode = _generateWidgetString(rightContainer);

      // Description Label
      final description = WidgetConfig(
        type: 'Label',
        properties: {
          'text':
              'Aplikasi ini adalah platform manajemen internal milik Gonusa Prima Distribusi. Fokus utama aplikasi ini adalah menangani Pemusnahan Bad Stock dan pembuatan Realisasi Pemusnahan.',
          'fontSize': '12',
          'fontWeight': 'normal',
          'alignment': 'left',
          'width': '400',
          'height': '70',
        },
        top: 120,
        left: 650,
      );
      description.customCode = _generateWidgetString(description);

      // GlassCard 1
      final card1 = WidgetConfig(
        type: 'GlassCard',
        properties: {
          'title': 'Dashboard Utama',
          'subtitle':
              'Pemantauan barang near ed dan proses persetujuan pemusnahan (Approval).',
          'width': '400',
          'height': '95',
        },
        top: 200,
        left: 650,
      );
      card1.customCode = _generateWidgetString(card1);

      // GlassCard 2
      final card2 = WidgetConfig(
        type: 'GlassCard',
        properties: {
          'title': 'Status Tracking',
          'subtitle': 'Pantau setiap pengajuan pemusnahan secara transparan.',
          'width': '400',
          'height': '95',
        },
        top: 310,
        left: 650,
      );
      card2.customCode = _generateWidgetString(card2);

      // GlassCard 3
      final card3 = WidgetConfig(
        type: 'GlassCard',
        properties: {
          'title': 'Support dan Service',
          'subtitle': 'Support yang siap membantu secara cepat.',
          'width': '400',
          'height': '95',
        },
        top: 420,
        left: 650,
      );
      card3.customCode = _generateWidgetString(card3);

      // Support Label
      final supportLabel = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Email Support:',
          'fontSize': '11',
          'fontWeight': 'normal',
          'alignment': 'left',
          'width': '400',
          'height': '20',
        },
        top: 530,
        left: 650,
      );
      supportLabel.customCode = _generateWidgetString(supportLabel);

      // Support Value
      final supportValue = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'application@savoria.co.id',
          'fontSize': '12',
          'fontWeight': 'bold',
          'alignment': 'left',
          'width': '400',
          'height': '20',
        },
        top: 550,
        left: 650,
      );
      supportValue.customCode = _generateWidgetString(supportValue);

      canvasItems.addAll([
        bg,
        leftContainer,
        logo,
        title,
        subtitle,
        emailLabel,
        emailField,
        passwordLabel,
        passwordField,
        rememberMe,
        forgotPassword,
        loginBtn,
        footer,
        rightContainer,
        description,
        card1,
        card2,
        card3,
        supportLabel,
        supportValue,
      ]);
    });
  }

  void _loadGlassListTileTemplate() {
    setState(() {
      rootLayout = 'Column';
      deviceSize = 'Mobile';
      isLandscape = false;
      canvasItems.clear();
      selectedItemIndex = null;
      _lastSelectedIndex = null;
      _codeController?.dispose();
      _codeController = null;

      final header = WidgetConfig(
        type: 'Label',
        properties: {
          'text': 'Fitur Utama GIMS',
          'fontSize': '22',
          'fontWeight': 'bold',
          'alignment': 'center',
        },
      );
      header.customCode = _generateWidgetString(header);

      final spacer = WidgetConfig(
        type: 'Spacing',
        properties: {
          'size': '15',
        },
      );
      spacer.customCode = _generateWidgetString(spacer);

      final tile1 = WidgetConfig(
        type: 'GlassCard',
        properties: {
          'title': 'Dashboard Utama',
          'subtitle':
              'Pemantauan barang near ed dan proses persetujuan pemusnahan.',
        },
      );
      tile1.customCode = _generateWidgetString(tile1);

      final tile2 = WidgetConfig(
        type: 'GlassCard',
        properties: {
          'title': 'Status Tracking',
          'subtitle': 'Pantau setiap pengajuan pemusnahan secara transparan.',
        },
      );
      tile2.customCode = _generateWidgetString(tile2);

      final tile3 = WidgetConfig(
        type: 'GlassCard',
        properties: {
          'title': 'Support dan Service',
          'subtitle': 'Support yang siap membantu secara cepat dan responsif.',
        },
      );
      tile3.customCode = _generateWidgetString(tile3);

      final tile4 = WidgetConfig(
        type: 'GlassCard',
        properties: {
          'title': 'Pengaturan Akun',
          'subtitle': 'Kelola informasi profil, hak akses, dan ganti password.',
        },
      );
      tile4.customCode = _generateWidgetString(tile4);

      canvasItems.addAll([header, spacer, tile1, tile2, tile3, tile4]);
    });
  }

  void _showGeneratedCode() {
    if (canvasItems.isEmpty) {
      CustomToast.showToastError(context, "Canvas is empty!");
      return;
    }

    StringBuffer sb = StringBuffer();
    sb.writeln('$rootLayout(');
    if (rootLayout == 'Column') {
      sb.writeln('  crossAxisAlignment: CrossAxisAlignment.stretch,');
    } else if (rootLayout == 'Row') {
      sb.writeln('  crossAxisAlignment: CrossAxisAlignment.start,');
    } else if (rootLayout == 'Stack') {
      sb.writeln('  clipBehavior: Clip.none,');
    }
    sb.writeln('  children: [');

    for (WidgetConfig config in canvasItems) {
      if (rootLayout == 'Stack') {
        sb.writeln('    Positioned(');
        sb.writeln('      left: ${config.left.toStringAsFixed(1)},');
        sb.writeln('      top: ${config.top.toStringAsFixed(1)},');
        sb.writeln(
            '      child: ${(config.customCode ?? _generateWidgetString(config)).replaceAll('\n', '\n      ')},');
        sb.writeln('    ),');
      } else {
        sb.writeln(
            '    ${(config.customCode ?? _generateWidgetString(config)).replaceAll('\n', '\n    ')},');
      }
    }
    sb.writeln('  ],');
    sb.writeln(')');

    String code = sb.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Generated Flutter Code'),
          content: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.3))),
            child: SingleChildScrollView(
              child: SelectableText(code,
                  style:
                      const TextStyle(fontFamily: 'monospace', fontSize: 13)),
            ),
          ),
          actions: [
            ElevatedButton.icon(
              icon: const Icon(Icons.copy, size: 16),
              label: const Text('Copy Code'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: code));
                CustomToast.showToastSuccess(
                    context, "Code copied to clipboard!");
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showDeveloperGuide() {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final titleStyle = TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        );
        final subtitleStyle = TextStyle(
          color: isDark ? Colors.white70 : Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
        final bodyStyle = TextStyle(
          color: isDark ? Colors.white70 : Colors.black87,
          fontSize: 13,
          height: 1.4,
        );
        final codeBgColor = isDark ? Colors.black26 : Colors.grey[100];
        final codeBorderColor = isDark ? Colors.white10 : Colors.grey[300]!;

        Widget buildStepCard(String num, String title, List<Widget> children) {
          return Card(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[50],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: codeBorderColor),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF312E81),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          num,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: titleStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...children,
                ],
              ),
            ),
          );
        }

        Widget buildCodeBlock(String code) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: codeBgColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: codeBorderColor),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFFEC4899),
                ),
              ),
            ),
          );
        }

        return DefaultTabController(
          length: 2,
          child: Dialog(
            backgroundColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 850,
              height: 650,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.menu_book, color: Color(0xFFEC1B30), size: 28),
                      const SizedBox(width: 12),
                      const Text(
                        'Panduan Integrasi & Developer (Savoria Custom Widgets)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TabBar(
                    labelColor: const Color(0xFF312E81),
                    unselectedLabelColor: isDark ? Colors.white60 : Colors.black54,
                    indicatorColor: const Color(0xFFEC1B30),
                    tabs: const [
                      Tab(text: '📦 CARA INTEGRASI (PENGGUNA)'),
                      Tab(text: '🛠️ PANDUAN DEVELOPER (PENGEMBANG)'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab 1: Cara Integrasi
                        ListView(
                          padding: const EdgeInsets.all(8),
                          children: [
                            Text(
                              'Untuk menggunakan custom widget ini pada aplikasi Anda, ikuti langkah-langkah di bawah ini.',
                              style: bodyStyle,
                            ),
                            const SizedBox(height: 20),
                            Text('Langkah 1: Tambahkan Dependensi', style: subtitleStyle),
                            const SizedBox(height: 4),
                            Text(
                              'Tambahkan library ini ke berkas `pubspec.yaml` di project Flutter target:',
                              style: bodyStyle,
                            ),
                            buildCodeBlock(
                              'dependencies:\n'
                              '  custom_widget_savoria:\n'
                              '    git:\n'
                              '      url: https://github.com/spyroxy/custom_widget_savoria.git'
                            ),
                            const SizedBox(height: 20),
                            Text('Langkah 2: Impor di Kode Anda', style: subtitleStyle),
                            const SizedBox(height: 4),
                            Text(
                              'Gunakan import package berikut pada berkas Dart tempat Anda ingin memakai komponen UI Savoria:',
                              style: bodyStyle,
                            ),
                            buildCodeBlock(
                              'import \'package:custom_widget_savoria/custom_widget.dart\';'
                            ),
                            const SizedBox(height: 20),
                            Text('Contoh Penggunaan Komponen', style: subtitleStyle),
                            const SizedBox(height: 4),
                            Text(
                              'Berikut adalah contoh sederhana memanggil widget Savoria:',
                              style: bodyStyle,
                            ),
                            buildCodeBlock(
                              '// 1. Custom Button Standard\n'
                              'CustomButtonStandard(\n'
                              '  title: "Kirim Data",\n'
                              '  onTap: () {},\n'
                              ');\n\n'
                              '// 2. Glass Button\n'
                              'GlassButton(\n'
                              '  onPressed: () {},\n'
                              '  borderRadius: 8,\n'
                              '  color: Colors.blue,\n'
                              '  child: Text("Scan QR"),\n'
                              ');'
                            ),
                          ],
                        ),
                        // Tab 2: Panduan Developer
                        ListView(
                          padding: const EdgeInsets.all(8),
                          children: [
                            Text(
                              'Gunakan panduan berikut untuk mendaftarkan dan memprogram komponen widget baru di dalam Editor UI Builder (Workspace).',
                              style: bodyStyle,
                            ),
                            const SizedBox(height: 16),
                            buildStepCard(
                              '1',
                              'Daftarkan Nama Widget Baru',
                              [
                                Text(
                                  'Buka file `lib/editor_workbook.dart` dan tambahkan nama widget Anda ke list `availableWidgets`:',
                                  style: bodyStyle,
                                ),
                                buildCodeBlock(
                                  'final List<String> availableWidgets = [\n'
                                  '  \'Label\',\n'
                                  '  \'Logo Placeholder\',\n'
                                  '  // ...\n'
                                  '  \'NamaWidgetBaru Anda\' // <-- Tambahkan di sini\n'
                                  '];'
                                ),
                              ],
                            ),
                            buildStepCard(
                              '2',
                              'Definisikan Default Properties',
                              [
                                Text(
                                  'Definisikan default konfigurasi properti awal widget baru tersebut di method `_getDefaultProperties`:',
                                  style: bodyStyle,
                                ),
                                buildCodeBlock(
                                  'Map<String, dynamic> _getDefaultProperties(String type) {\n'
                                  '  switch (type) {\n'
                                  '    case \'NamaWidgetBaru\':\n'
                                  '      return {\n'
                                  '        \'title\': \'Klik Disini\',\n'
                                  '        \'color\': \'red\',\n'
                                  '      };\n'
                                  '    default:\n'
                                  '      return {};\n'
                                  '  }\n'
                                  '}'
                                ),
                              ],
                            ),
                            buildStepCard(
                              '3',
                              'Implementasikan Visual Preview di Canvas',
                              [
                                Text(
                                  'Tentukan rendering visual widget Anda di dalam method `_buildRealWidgetPreview`. (Wrapper ukuran otomatis SizedBox sudah terintegrasi di akhir method):',
                                  style: bodyStyle,
                                ),
                                buildCodeBlock(
                                  'Widget _buildRealWidgetPreview(WidgetConfig config) {\n'
                                  '  switch (config.type) {\n'
                                  '    case \'NamaWidgetBaru\':\n'
                                  '      return CustomWidgetBaru(\n'
                                  '        title: config.properties[\'title\'] ?? \'Button\',\n'
                                  '        color: config.properties[\'color\'] ?? \'red\',\n'
                                  '      );\n'
                                  '  }\n'
                                  '}'
                                ),
                              ],
                            ),
                            buildStepCard(
                              '4',
                              'Buat Code Generator (Ekspor Kode)',
                              [
                                Text(
                                  'Implementasikan logic export code Flutter Anda di method `_generateWidgetString`:',
                                  style: bodyStyle,
                                ),
                                buildCodeBlock(
                                  'String _generateWidgetString(WidgetConfig config) {\n'
                                  '  StringBuffer sb = StringBuffer();\n'
                                  '  switch (config.type) {\n'
                                  '    case \'NamaWidgetBaru\':\n'
                                  '      sb.writeln(\'CustomWidgetBaru(\');\n'
                                  '      sb.writeln(\'  title: "\${config.properties[\'title\']}",\');\n'
                                  '      sb.writeln(\'  color: "\${config.properties[\'color\']}",\');\n'
                                  '      sb.writeln(\')\');\n'
                                  '      break;\n'
                                  '  }\n'
                                  '  return sb.toString().replaceAll(\'\\n\', \'\\n    \');\n'
                                  '}'
                                ),
                              ],
                            ),
                            buildStepCard(
                              '5',
                              'Buat Regex Parser (Sinkronisasi Dua Arah)',
                              [
                                Text(
                                  'Lengkapi regex parser di method `_parsePropertiesFromCustomCode` agar editor visual ter-update otomatis ketika raw code diubah secara manual:',
                                  style: bodyStyle,
                                ),
                                buildCodeBlock(
                                  'void _parsePropertiesFromCustomCode(WidgetConfig config) {\n'
                                  '  final code = config.customCode;\n'
                                  '  if (code == null || code.isEmpty) return;\n\n'
                                  '  if (config.type == \'NamaWidgetBaru\') {\n'
                                  '    final title = parseStringProp(\'title\');\n'
                                  '    if (title != null) config.properties[\'title\'] = title;\n\n'
                                  '    final color = parseStringProp(\'color\');\n'
                                  '    if (color != null) config.properties[\'color\'] = color;\n'
                                  '  }\n'
                                  '}'
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PremiumAppLogo extends StatelessWidget {
  final double size;
  const PremiumAppLogo({Key? key, this.size = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The background shield
          ClipPath(
            clipper: ShieldClipper(),
            child: Container(
              width: size * 0.85,
              height: size * 0.85,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F3E76), Color(0xFF00224A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Shield golden/orange border
          CustomPaint(
            size: Size(size * 0.85, size * 0.85),
            painter: ShieldBorderPainter(),
          ),
          // Trophy and elements inside
          Positioned(
            top: size * 0.12,
            child: Icon(
              Icons.emoji_events, // Trophy icon
              color: Colors.white,
              size: size * 0.45,
            ),
          ),
          // Left side bag/money icon (or similar)
          Positioned(
            left: size * 0.1,
            bottom: size * 0.25,
            child: Icon(
              Icons.work,
              color: const Color(0xFF0075FF),
              size: size * 0.22,
            ),
          ),
          // Right-pointing orange arrow
          Positioned(
            right: size * 0.05,
            top: size * 0.12,
            child: Transform.rotate(
              angle: -0.4,
              child: Icon(
                Icons.trending_up,
                color: const Color(0xFFFF6B00),
                size: size * 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShieldClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0); // top center
    path.quadraticBezierTo(
        size.width, size.height * 0.1, size.width, size.height * 0.45);
    path.quadraticBezierTo(
        size.width, size.height * 0.85, size.width * 0.5, size.height);
    path.quadraticBezierTo(0, size.height * 0.85, 0, size.height * 0.45);
    path.quadraticBezierTo(0, size.height * 0.1, size.width * 0.5, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ShieldBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF8A00)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(
        size.width, size.height * 0.1, size.width, size.height * 0.45);
    path.quadraticBezierTo(
        size.width, size.height * 0.85, size.width * 0.5, size.height);
    path.quadraticBezierTo(0, size.height * 0.85, 0, size.height * 0.45);
    path.quadraticBezierTo(0, size.height * 0.1, size.width * 0.5, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SavoriaPillLogo extends StatelessWidget {
  final double width;
  final double height;
  const SavoriaPillLogo({Key? key, this.width = 70, this.height = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFEC1B30),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Text(
        'SAVORIA',
        style: TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class GonusaLogo extends StatelessWidget {
  const GonusaLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.autorenew,
            color: Colors.amber,
            size: 18,
          ),
        ),
        const SizedBox(width: 4),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GONUSA',
              style: TextStyle(
                color: Color(0xFF312E81),
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'PRIMA DISTRIBUSI',
              style: TextStyle(
                color: Color(0xFF312E81),
                fontSize: 5,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
