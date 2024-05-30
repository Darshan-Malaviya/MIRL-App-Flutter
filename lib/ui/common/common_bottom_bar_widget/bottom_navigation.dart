
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/common_bottom_bar_widget/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.onSelectTab,
    required this.tabs,
  });

  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: tabs
          .map(
            (e) => _buildItem(index: e.getIndex(), icon: const Icon(Icons.home)),
          )
          .toList(),
      onTap: (index) => onSelectTab(
        index,
      ),
    );
  }

  BottomNavigationBarItem _buildItem({int? index, required Widget icon}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: "",
    );
  }

  Widget showIndicator(bool show) {
    return show
        ? const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.brightness_1, size: 10, color: Colors.orange),
          )
        : const SizedBox();
  }
}
