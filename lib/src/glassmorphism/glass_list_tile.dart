import 'package:flutter/material.dart';
import 'glass_container.dart';

class GlassListTile extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final IconData headerIcon;
  final Color headerIconColor;
  final Color headerIconBgColor;
  final String name;
  final String shop;
  final String address;
  final String date;
  final String actionText;
  final Color actionColor;
  final VoidCallback? onActionTap;
  final double blur;
  final Color color;
  final double opacity;
  final Color textColor;
  final Color subTextColor;

  const GlassListTile({
    Key? key,
    required this.title,
    this.status = '',
    this.statusColor = const Color(0xFF81C784),
    this.statusTextColor = const Color(0xFF2E7D32),
    this.headerIcon = Icons.inventory_2,
    this.headerIconColor = Colors.white,
    this.headerIconBgColor = const Color(0xFF8B7EFE),
    this.name = '',
    this.shop = '',
    this.address = '',
    this.date = '',
    this.actionText = '',
    this.actionColor = const Color(0xFF5F51E8),
    this.onActionTap,
    this.blur = 10.0,
    this.color = const Color(0xFFFFFFFF),
    this.opacity = 0.2,
    this.textColor = Colors.white,
    this.subTextColor = const Color(0xB3FFFFFF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: 24,
      color: color,
      opacity: opacity,
      blur: blur,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: headerIconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  headerIcon,
                  color: headerIconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (status.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Body Rows
          if (name.isNotEmpty) ...[
            _buildBodyRow(Icons.person, name),
            const SizedBox(height: 8),
          ],
          if (shop.isNotEmpty) ...[
            _buildBodyRow(Icons.storefront, shop),
            const SizedBox(height: 8),
          ],
          if (address.isNotEmpty) ...[
            _buildBodyRow(Icons.location_on, address),
          ],
          const SizedBox(height: 16),

          // Divider
          Divider(
            height: 1,
            color: textColor.withOpacity(0.15),
          ),
          const SizedBox(height: 12),

          // Footer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: subTextColor,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              if (actionText.isNotEmpty)
                InkWell(
                  onTap: onActionTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          actionText,
                          style: TextStyle(
                            color: actionColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          color: actionColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: subTextColor,
          size: 18,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
