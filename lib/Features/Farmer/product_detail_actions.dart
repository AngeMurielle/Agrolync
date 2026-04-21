import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductDetailAppBarActions extends StatefulWidget {
  const ProductDetailAppBarActions({super.key});

  @override
  State<ProductDetailAppBarActions> createState() =>
      _ProductDetailAppBarActionsState();
}

class _ProductDetailAppBarActionsState
    extends State<ProductDetailAppBarActions> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(_isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        duration: const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleShare() async {
    await Clipboard.setData(const ClipboardData(
      text: 'Check out this product on AgroLync Marketplace!',
    ));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product details copied to clipboard'),
        duration: Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : Colors.black,
          ),
          onPressed: _toggleFavorite,
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.black),
          onPressed: _handleShare,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
