import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(Mas());
}

class Mas extends StatelessWidget {
  const Mas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: DismissibleTile()),
    );
  }
}

class DismissibleTile extends StatefulWidget {
  const DismissibleTile({super.key});

  @override
  _DismissibleTileState createState() => _DismissibleTileState();
}

class _DismissibleTileState extends State<DismissibleTile> {
  late List<Slidable> _items;

  @override
  void initState() {
    super.initState();

    // Dismissible setup
    final dismissal = DismissiblePane(
      onDismissed: () {
        _showSnackBar('Added to Favorites');
        setState(() {
          _items.removeAt(0); // Remove the item after swipe right
        });
      },
      // Optionally, add confirmDismiss if needed
      // confirmDismiss: () async {
      //   return await _confirmFavoriteAction();
      // },
    );

    // Create the Slidable item with only startActionPane for swipe right
    _items = [
      Slidable(
        key: const Key('dismissibleTile'),
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          dismissible: dismissal,
          children: [
            SlidableAction(
              label: 'Favorite',
              foregroundColor: Colors.green,
              icon: Icons.favorite,
              onPressed: (_) => _showSnackBar('Added to Favorites'),
            ),
          ],
        ),
        child: const ListTile(
          leading: Icon(Icons.swap_horiz),
          title: Text('Swipe right to add to Favorites'),
          subtitle: Text('Swipe right only'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: _items);
  }

  // Helper function to show snackbar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Confirmation dialog to confirm action
  Future<bool?> _confirmFavoriteAction() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add to Favorites'),
          content: const Text(
              'Are you sure you want to add this item to favorites?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
