# Custom Widget Savoria

<img src="https://www.savoria.co.id/images/logo/savoria-splash.png" alt="Logo Savoria" width="200"/>

Savoria custom widget untuk berbagai komponen UI internal Flutter project, dilengkapi dengan UI Builder (Drag & Drop) workspace untuk merancang antarmuka secara visual dan mengekspornya menjadi kode Flutter.

---

## 📦 Instalasi & Cara Pakai

Tambahkan ke `pubspec.yaml`:

```yaml
dependencies:
  custom_widget_savoria:
    git:
      url: https://github.com/spyroxy/custom_widget_savoria.git
```

Impor package di kode Flutter Anda:

```dart
import 'package:custom_widget_savoria/custom_widget.dart';

// Contoh penggunaan custom button
CustomButtonStandard(
  title: "Kirim",
  onTap: () {},
);
```

---

## 🛠️ Panduan Developer: Menambahkan Widget Baru ke UI Builder

Untuk menambahkan widget baru agar dapat di-drag, diatur ukurannya, dan diedit kodenya di **UI Builder Workspace** (`lib/editor_workbook.dart`), ikuti 5 langkah mudah berikut:

### Langkah 1: Daftarkan Nama Widget
Buka `lib/editor_workbook.dart` dan tambahkan nama widget baru Anda ke dalam list `availableWidgets` di dalam state `_EditorWorkbookState`:

```dart
final List<String> availableWidgets = [
  'Label',
  'Logo Placeholder',
  // ...
  'NamaWidgetBaru Anda' // <-- Tambahkan di sini
];
```

### Langkah 2: Definisikan Default Properties
Berikan konfigurasi properti awal (default) untuk widget baru tersebut di dalam method `_getDefaultProperties`:

```dart
Map<String, dynamic> _getDefaultProperties(String type) {
  switch (type) {
    case 'Label':
      return {'text': 'Default Text', 'fontSize': '24'};
    case 'NamaWidgetBaru Anda':
      return {
        'title': 'Klik Disini',
        'color': 'red',
        // 'width' dan 'height' opsional jika ingin mendukung drag-to-resize dengan wrapper SizedBox
      };
    default:
      return {};
  }
}
```

### Langkah 3: Implementasikan Visual Preview di Canvas
Tambahkan instruksi *rendering* widget di dalam method `_buildRealWidgetPreview`. Ini menentukan bagaimana widget akan digambar pada Canvas:

```dart
Widget _buildRealWidgetPreview(WidgetConfig config) {
  Widget child;
  switch (config.type) {
    case 'Label':
      child = Text(config.properties['text'] ?? '');
      break;
      
    case 'NamaWidgetBaru Anda':
      child = CustomWidgetBaru(
        title: config.properties['title'] ?? 'Button',
        color: config.properties['color'] ?? 'red',
      );
      break;
      
    default:
      child = Text(config.type);
  }

  // NOTE: Di akhir method ini sudah ada wrapper otomatis untuk sizing:
  // Jika config.properties['width'] atau ['height'] tidak null,
  // widget akan otomatis dibungkus dengan SizedBox oleh editor.
  
  return child;
}
```

### Langkah 4: Buat Code Generator (Ekspor Kode)
Implementasikan kode penghasil *string code* Flutter di dalam method `_generateWidgetString`. Kode inilah yang akan diekspor dan ditampilkan di editor kode sebelah kanan:

```dart
String _generateWidgetString(WidgetConfig config) {
  StringBuffer sb = StringBuffer();
  switch (config.type) {
    case 'Label':
      sb.writeln('Text("${config.properties['text']}")');
      break;

    case 'NamaWidgetBaru Anda':
      sb.writeln('CustomWidgetBaru(');
      sb.writeln('  title: "${config.properties['title']}",');
      sb.writeln('  color: "${config.properties['color']}",');
      sb.writeln(')');
      break;
  }
  
  // NOTE: Di akhir method ini sudah ada wrapper otomatis:
  // Jika widget Anda digeser ukurannya (resize), editor akan otomatis 
  // membungkus output kodenya dengan SizedBox(width: ..., height: ..., child: ...)
  
  return sb.toString().replaceAll('\n', '\n    ');
}
```

### Langkah 5: Buat Regex Parser (Sinkronisasi Dua Arah dari Kode ke Visual)
Agar ketika developer mengedit raw code di panel kanan, visual di Canvas bisa ikut ter-update secara *real-time*, tambahkan *pattern matching* (RegExp) di dalam method `_parsePropertiesFromCustomCode`:

```dart
void _parsePropertiesFromCustomCode(WidgetConfig config) {
  final code = config.customCode;
  if (code == null || code.isEmpty) return;

  // Gunakan helper yang sudah tersedia:
  // parseStringProp('properti') -> untuk String
  // parseNumberProp('properti') -> untuk Double/Integer
  // parseBoolProp('properti')   -> untuk Boolean

  if (config.type == 'Label') {
    final textReg = RegExp(r'''Text\(\s*['"]([^'"]*)['"]''');
    final textMatch = textReg.firstMatch(code);
    if (textMatch != null) config.properties['text'] = textMatch.group(1);
    
  } else if (config.type == 'NamaWidgetBaru Anda') {
    final title = parseStringProp('title');
    if (title != null) config.properties['title'] = title;

    final color = parseStringProp('color');
    if (color != null) config.properties['color'] = color;
  }
}
```

---

## 📐 Fitur Resize dengan Drag & Drop
- Setiap kali Anda mengklik widget di Canvas, penanda seleksi berwarna biru akan muncul.
- Di pojok kanan bawah seleksi tersebut terdapat **tombol bundar berwarna biru** (Resize Handle).
- Menarik handle tersebut akan mengubah nilai `width` dan `height` dari properti widget secara langsung.
- Secara otomatis, widget tersebut akan dibungkus dengan `SizedBox` pada hasil ekspor kodenya agar ukurannya presisi sesuai dengan yang Anda tarik di Canvas.
