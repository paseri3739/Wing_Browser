import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wing_browser/ui_components/common/square_icon_button.dart';
import 'package:wing_browser/webview/state/web_view_model.dart';

class UrlField extends ConsumerWidget {
  final double height; // 高さを指定するプロパティ

  const UrlField({
    super.key,
    this.height = 40.0, // デフォルトの高さ
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final WebUri? url = ref.watch(webViewProvider).url;

    // URLを反映
    if (url != null && controller.text != url.toString()) {
      controller.text = url.toString();
    }

    // アイコンを動的に設定
    IconData lockIcon = (url?.scheme == 'https') ? Icons.lock : Icons.lock_open;
    Color iconColor = (url?.scheme == 'https') ? Colors.green : Colors.red;

    return SizedBox(
      height: height, // ここでウィジェットの高さを設定してすべてに適用する
      child: Row(
        children: <Widget>[
          SquareIconButton(
            height: height,
            icon: lockIcon,
            color: iconColor,
          ),
          Expanded(
            child: SizedBox(
              height: height,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                onSubmitted: (string) {
                  // URL更新処理をここに記述
                  ref.read(webViewProvider.notifier).setUrl(WebUri(string));
                },
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  isDense: false,
                  contentPadding: const EdgeInsets.all(
                    2.0,
                  ), // マジックナンバー。縦の値に合わせて調整させたい
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: "Search For ...",
                  hintStyle: const TextStyle(color: Colors.black54, fontSize: 16.0), // これもマジックナンバー
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ),
          SquareIconButton(
            height: height,
            icon: Icons.refresh,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
