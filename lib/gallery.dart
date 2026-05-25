import 'package:custom_widget_savoria/custom_widget.dart';
import 'package:custom_widget_savoria/editor_workbook.dart';
import 'package:flutter/material.dart';

// Global notifier for the gallery theme state (default is dark: true)
final ValueNotifier<bool> galleryThemeNotifier = ValueNotifier(true);

// A wrapper to apply the selected theme dynamically
class GalleryThemeWrapper extends StatelessWidget {
  final Widget Function(BuildContext context) builder;
  const GalleryThemeWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: galleryThemeNotifier,
      builder: (context, isDark, _) {
        return Theme(
          data: isDark ? ThemeData.dark() : ThemeData.light(),
          child: Builder(
            builder: (innerContext) => builder(innerContext),
          ),
        );
      },
    );
  }
}

// Reusable toggle button for AppBars
Widget _buildThemeToggle() {
  return ValueListenableBuilder<bool>(
    valueListenable: galleryThemeNotifier,
    builder: (context, isDark, _) {
      return IconButton(
        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
        onPressed: () => galleryThemeNotifier.value = !isDark,
        tooltip: 'Toggle Theme',
      );
    },
  );
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryThemeWrapper(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Widget Workbook'),
          actions: [_buildThemeToggle()],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // _buildMenuCard(
            //     context, 'Buttons', Icons.touch_app, const ButtonsWorkbook()),
            // _buildMenuCard(context, 'Text Fields & Inputs', Icons.text_fields,
            //     const InputsWorkbook()),
            // _buildMenuCard(context, 'Dialogs, Modals & Toasts', Icons.message,
            //     const DialogsWorkbook()),
            _buildMenuCard(context, 'Glassmorphism V.1.0', Icons.blur_on,
                const GlassmorphismWorkbook()),
            // _buildMenuCard(context, 'Misc (Expand, DropDown)', Icons.more_horiz,
            //     const MiscWorkbook()),
            _buildMenuCard(
                context,
                'Playground Glassmorphism Widget (Drag & Drop) V.1.1',
                Icons.dashboard_customize,
                const EditorWorkbook()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading:
            Icon(icon, size: 30, color: Theme.of(context).colorScheme.primary),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
}

class ButtonsWorkbook extends StatefulWidget {
  const ButtonsWorkbook({super.key});
  @override
  State<ButtonsWorkbook> createState() => _ButtonsWorkbookState();
}

class _ButtonsWorkbookState extends State<ButtonsWorkbook> {
  bool isLoading = false;
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    return GalleryThemeWrapper(
      builder: (context) => LoadingOverlay(
        isBackground: true,
        isLoading: isLoading,
        opacity: opacity,
        widgetCenter: const Text('Loading...'),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Buttons'),
            actions: [_buildThemeToggle()],
          ),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text("1. CustomButtonStandard",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              CustomButtonStandard(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                    opacity = 1;
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() {
                    isLoading = false;
                    opacity = 0;
                  });
                },
                title: 'Tambah (With Loading)',
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              const Divider(height: 40),
              const Text("2. CustomButton",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              CustomButton(
                title: "Submit Data",
                onPressed: () {},
                color: Colors.blueAccent,
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 40),
              const Text("3. CustomCircleButton",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Center(
                child: CustomCircleButton(
                  icon: Icons.notifications,
                  text: "Notif",
                  onPressed: () {},
                  colorCircle: Colors.amber,
                  colorIcon: Colors.white,
                  heightCircle: 60,
                  widhtCircle: 60,
                  sizeIcon: 30,
                  notif: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputsWorkbook extends StatefulWidget {
  const InputsWorkbook({super.key});
  @override
  State<InputsWorkbook> createState() => _InputsWorkbookState();
}

class _InputsWorkbookState extends State<InputsWorkbook> {
  final TextEditingController txtSample = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GalleryThemeWrapper(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Text Fields & Inputs'),
          actions: [_buildThemeToggle()],
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text("1. CustomTextFieldStandard",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const CustomTextFieldStandard(
              hint: "you@savoria.co.id",
              label: "Username",
              icon: Icons.email,
            ),
            const SizedBox(height: 10),
            const CustomTextFieldStandard(
              hint: "password",
              label: "Password",
              icon: Icons.lock,
              colorObscure: Colors.purple,
              obscure: true,
            ),
            const Divider(height: 40),
            const Text("2. CustomSearchText",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            CustomSearchText(
              textEditingController: txtSample,
              hintText: "Search items...",
              onPressed: () {},
            ),
            const Divider(height: 40),
            const Text("3. CustomTextField",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: "Phone Number",
              textEditingController: txtSample,
              hintText: "Enter your phone number",
              keyboardNumber: true,
            ),
          ],
        ),
      ),
    );
  }
}

class DialogsWorkbook extends StatelessWidget {
  const DialogsWorkbook({super.key});

  @override
  Widget build(BuildContext context) {
    return GalleryThemeWrapper(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Dialogs & Toasts'),
          actions: [_buildThemeToggle()],
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text("1. Custom Toast (Snackbars)",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                    onPressed: () => CustomToast.showToastSuccess(
                        context, "This is a success message!"),
                    child: const Text("Success")),
                ElevatedButton(
                    onPressed: () => CustomToast.showToastError(
                        context, "This is an error message!"),
                    child: const Text("Error")),
                ElevatedButton(
                    onPressed: () => CustomToast.showToastInfo(
                        context, "This is an info message!"),
                    child: const Text("Info")),
              ],
            ),
            const Divider(height: 40),
            const Text("2. CustomDialogStandard",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  CustomDialogStandard(
                    context: context,
                    title: 'Warning',
                    content:
                        'Are you sure you want to proceed with this action?',
                    iconTitle: const Icon(Icons.warning,
                        size: 40, color: Colors.amber),
                    confirmText: 'Yes, Proceed',
                    showCancel: true,
                  );
                },
                child: const Text("Show Standard Dialog")),
          ],
        ),
      ),
    );
  }
}

class GlassmorphismWorkbook extends StatefulWidget {
  const GlassmorphismWorkbook({super.key});

  @override
  State<GlassmorphismWorkbook> createState() => _GlassmorphismWorkbookState();
}

class _GlassmorphismWorkbookState extends State<GlassmorphismWorkbook> {
  bool animateBackground = true;

  @override
  Widget build(BuildContext context) {
    return GalleryThemeWrapper(
      builder: (context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Glassmorphism',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              tooltip:
                  animateBackground ? 'Pause Background' : 'Play Background',
              icon: Icon(
                  animateBackground
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                  color: Colors.white),
              onPressed: () {
                setState(() {
                  animateBackground = !animateBackground;
                });
              },
            ),
            _buildThemeToggle()
          ],
        ),
        body: GlassBackground(
          animate: animateBackground,
          child: ListView(
            padding: EdgeInsets.only(
                top: kToolbarHeight + MediaQuery.of(context).padding.top + 24,
                left: 24,
                right: 24,
                bottom: 24),
            children: [
              const Text("1. GlassCard",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18)),
              const SizedBox(height: 10),
              const GlassCard(
                title: "Glassmorphism Card",
                subtitle:
                    "This is a beautiful glass effect over a gradient background.",
                icon: Icons.credit_card_outlined,
              ),
              const SizedBox(height: 40),
              const Text("2. GlassTextField",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18)),
              const SizedBox(height: 10),
              GlassTextField(
                controller: TextEditingController(),
                hintText: "Enter some text...",
                prefixIcon: Icons.search,
              ),
              const SizedBox(height: 40),
              const Text("3. GlassButton",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18)),
              const SizedBox(height: 10),
              Center(
                child: GlassButton(
                  onPressed: () {
                    CustomToast.showToastInfo(context, "Glass Button Pressed!");
                  },
                  child: const Text("Tap Me!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),
              const Text("4. GlassPrefixTextField",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18)),
              const SizedBox(height: 10),
              GlassPrefixTextField(
                controller: TextEditingController(),
                labelText: "Calendar",
                hintText: "dd/mm/yyyy",
                prefixIcon: Icons.calendar_month,
                prefixColor: const Color(0xFFE51C23),
              ),
              const SizedBox(height: 40),
              const Text("5. GlassListTile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18)),
              const SizedBox(height: 10),
              const GlassListTile(
                title: "DO12345678",
                status: "Ready",
                statusColor: Color(0xFF81C784),
                statusTextColor: Color(0xFF2E7D32),
                headerIcon: Icons.inventory_2,
                headerIconBgColor: Color(0xFF8B7EFE),
                name: "Nur Said",
                shop: "Toko Berkah Jaya",
                address:
                    "Jl. Jendral Sudirman Kav 10, RT 05 \\ RW 10, Jakarta Pusat, Indonesia",
                date: "2025-10-30",
                actionText: "Take Shipment",
                actionColor: Color(0xFF5F51E8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MiscWorkbook extends StatefulWidget {
  const MiscWorkbook({super.key});
  @override
  State<MiscWorkbook> createState() => _MiscWorkbookState();
}

class _MiscWorkbookState extends State<MiscWorkbook> {
  final TextEditingController txtSample = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GalleryThemeWrapper(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Misc Widgets'),
          actions: [_buildThemeToggle()],
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text("1. CustomDropDown",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            CustomDropDown(
              onTap: () {},
              labelText: "Select Item",
              textEditingController: txtSample,
              hintText: "Choose an option",
            ),
            const Divider(height: 40),
            const Text("2. CustomExpand",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const CustomExpand(
              title: Text("Expandable Title",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subTitle: Text("Tap to expand the content"),
              content: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    "Here is the detailed content of the expanded widget. It can contain any widget you want."),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
