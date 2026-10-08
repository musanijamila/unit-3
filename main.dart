import 'package:flutter/material.dart';

import 'easy_1_names.dart';
import 'easy_2_listtile.dart';
import 'easy_3_color_grid.dart';
import 'easy_4_nav_push.dart';
import 'easy_5_named_routes.dart';
import 'easy_6_form_validate.dart';
import 'easy_7_counter.dart';
import 'easy_8_checkbox.dart';
import 'easy_9_change_notifier.dart';
import 'easy_10_read_watch.dart';

import 'mod_1_product_grid.dart';
import 'mod_2_search_filter.dart';
import 'mod_3_student_detail.dart';
import 'mod_4_pop_data.dart';
import 'mod_5_reg_form.dart';
import 'mod_6_login_form.dart';
import 'mod_7_todo.dart';
import 'mod_8_cart_provider.dart';
import 'mod_9_star_rating.dart';
import 'mod_10_star_pattern.dart';

import 'hard_1_step_wizard.dart';
import 'hard_2_ecommerce.dart';
import 'hard_3_todo_riverpod.dart';
import 'hard_4_counter_bloc.dart';
import 'hard_5_toggle_view.dart';
import 'hard_6_complex_form.dart';
import 'hard_7_theme_switcher.dart';
import 'hard_8_number_pyramid.dart';
import 'hard_9_nested_nav.dart';
import 'hard_10_multi_user_login.dart';

void main() {
  runApp(const MasterApp());
}

class MasterApp extends StatelessWidget {
  const MasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '30 Practical Programs Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class PracticalItem {
  final String no;
  final String title;
  final String description;
  final Widget targetWidget;

  PracticalItem({
    required this.no,
    required this.title,
    required this.description,
    required this.targetWidget,
  });
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  List<PracticalItem> get easyPracticals => [
        PracticalItem(
          no: '1',
          title: 'Fixed Names List',
          description: 'Create a List<String> of 10 fixed names and display them on screen using ListView.builder.',
          targetWidget: const Easy1NamesApp(),
        ),
        PracticalItem(
          no: '2',
          title: 'ListTile with Icon',
          description: 'In ListView.builder, create a ListTile with an Icon and text for each item.',
          targetWidget: const Easy2ListTileApp(),
        ),
        PracticalItem(
          no: '3',
          title: '2-Column Color Grid',
          description: 'Create a List of 6 colors and display colored boxes in 2 columns using GridView.builder.',
          targetWidget: const Easy3ColorGridApp(),
        ),
        PracticalItem(
          no: '4',
          title: 'Push / Pop Navigation',
          description: 'Create two simple screens - HomeScreen and SecondScreen - and navigate between them using Navigator.push()/pop().',
          targetWidget: const Easy4NavApp(),
        ),
        PracticalItem(
          no: '5',
          title: 'Named Routes',
          description: 'Create navigation between 3 screens (Home, About, Contact) using named routes.',
          targetWidget: const Easy5NamedRoutesApp(),
        ),
        PracticalItem(
          no: '6',
          title: 'Form Validation',
          description: 'Create a simple Form with one TextFormField that shows a Field required error when submitted empty.',
          targetWidget: const Easy6FormApp(),
        ),
        PracticalItem(
          no: '7',
          title: 'setState Counter',
          description: 'Build a simple counter app using setState() with + and - buttons.',
          targetWidget: const Easy7CounterApp(),
        ),
        PracticalItem(
          no: '8',
          title: 'Checkbox Toggle',
          description: 'Toggle a checkbox using setState() and display Checked/Unchecked text based on its state.',
          targetWidget: const Easy8CheckboxApp(),
        ),
        PracticalItem(
          no: '9',
          title: 'ChangeNotifier Consumer',
          description: 'Create a simple CounterModel using ChangeNotifier and display its value using a Consumer widget.',
          targetWidget: const Easy9NotifierApp(),
        ),
        PracticalItem(
          no: '10',
          title: 'read() vs watch()',
          description: 'Create a small Provider example with two separate buttons showing the difference between context.read() and context.watch().',
          targetWidget: const Easy10ReadWatchApp(),
        ),
      ];

  List<PracticalItem> get moderatePracticals => [
        PracticalItem(
          no: '1',
          title: 'Product Catalog Grid',
          description: 'Create a Product Catalog using GridView.builder (image placeholder, name, price) with 3 columns.',
          targetWidget: const Mod1ProductCatalogApp(),
        ),
        PracticalItem(
          no: '2',
          title: 'Search ListView Filter',
          description: 'Add search-based filtering to a ListView.builder - typing in a TextField should filter the list.',
          targetWidget: const Mod2SearchFilterApp(),
        ),
        PracticalItem(
          no: '3',
          title: 'Pass Student Object',
          description: 'Pass data with navigation: send a Student object (name, roll no, marks) from HomeScreen to DetailScreen and display it.',
          targetWidget: const Mod3StudentApp(),
        ),
        PracticalItem(
          no: '4',
          title: 'Return Data via Pop',
          description: 'Send data back from DetailScreen to HomeScreen using Navigator.pop(context, data) and display it in a SnackBar.',
          targetWidget: const Mod4PopDataApp(),
        ),
        PracticalItem(
          no: '5',
          title: 'Registration Form',
          description: 'Create a Registration Form (Name, Email, Password) that validates email format and password length.',
          targetWidget: const Mod5RegFormApp(),
        ),
        PracticalItem(
          no: '6',
          title: 'Login Form Credentials',
          description: 'Create a Login Form that shows an error message for wrong credentials and navigates to HomeScreen for correct ones.',
          targetWidget: const Mod6LoginFormApp(),
        ),
        PracticalItem(
          no: '7',
          title: 'To-Do List (setState)',
          description: 'Build a To-Do List app using setState() where items can be added and deleted.',
          targetWidget: const Mod7TodoApp(),
        ),
        PracticalItem(
          no: '8',
          title: 'Provider Shopping Cart',
          description: 'Create a Shopping Cart using Provider where the total price updates automatically as items are added/removed.',
          targetWidget: const Mod8CartApp(),
        ),
        PracticalItem(
          no: '9',
          title: 'Star Rating Widget',
          description: 'Build a star rating widget (1 to 5 stars) that updates the selected rating using setState().',
          targetWidget: const Mod9StarRatingApp(),
        ),
        PracticalItem(
          no: '10',
          title: 'Print Star Pattern',
          description: 'Create a Flutter screen that prints a * pattern - entering a number in a TextField should display that many rows of stars.',
          targetWidget: const Mod10StarPatternApp(),
        ),
      ];

  List<PracticalItem> get hardPracticals => [
        PracticalItem(
          no: '1',
          title: 'Multi-Step Form Wizard',
          description: 'Create a Multi-step Form Wizard (Personal Info, Address, Review) with Navigator allowing forward/backward movement & validation.',
          targetWidget: const Hard1StepWizardApp(),
        ),
        PracticalItem(
          no: '2',
          title: 'Mini E-Commerce App',
          description: 'Build a complete mini E-commerce app using Provider: Product List -> Cart -> Checkout Summary.',
          targetWidget: const Hard2EcommerceApp(),
        ),
        PracticalItem(
          no: '3',
          title: 'Riverpod Todo App',
          description: 'Build a Todo App using Riverpod where list management (add, remove, toggle) is done using StateNotifierProvider.',
          targetWidget: const Hard3RiverpodApp(),
        ),
        PracticalItem(
          no: '4',
          title: 'BLoC Counter App',
          description: 'Build a simple Counter App using the BLoC pattern (flutter_bloc) that handles Increment and Decrement Events.',
          targetWidget: const Hard4BlocApp(),
        ),
        PracticalItem(
          no: '5',
          title: 'Toggle List & Grid View',
          description: 'Create a layout where ListView.builder and GridView.builder can be toggled on the same screen using a button.',
          targetWidget: const Hard5ToggleViewApp(),
        ),
        PracticalItem(
          no: '6',
          title: 'Complex Form.save()',
          description: 'Create a complex Form with Dropdown, Checkbox, and TextFormField, using Form.save() to pass values to SummaryScreen.',
          targetWidget: const Hard6ComplexFormApp(),
        ),
        PracticalItem(
          no: '7',
          title: 'Theme Switcher Provider',
          description: 'Build a Dark Mode / Light Mode Theme Switcher using Provider that applies across the entire app.',
          targetWidget: const Hard7ThemeApp(),
        ),
        PracticalItem(
          no: '8',
          title: 'Number Pyramid Pattern',
          description: 'Pattern printing: take user input N and dynamically generate and display a pyramid pattern of numbers.',
          targetWidget: const Hard8PyramidApp(),
        ),
        PracticalItem(
          no: '9',
          title: 'Nested Navigation Tabs',
          description: 'Create Nested Navigation: each tab of a Bottom Navigation Bar has its own separate Navigator stack using IndexedStack.',
          targetWidget: const Hard9NestedNavApp(),
        ),
        PracticalItem(
          no: '10',
          title: 'Multi-User Login System',
          description: 'Build a Multi-user Login System using Provider and Form validation, storing List<User> in Provider.',
          targetWidget: const Hard10MultiUserApp(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter 30 Practicals Hub'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Easy (10)'),
              Tab(text: 'Moderate (10)'),
              Tab(text: 'Hard (10)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPracticalList(context, easyPracticals, Colors.green),
            _buildPracticalList(context, moderatePracticals, Colors.orange),
            _buildPracticalList(context, hardPracticals, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticalList(BuildContext context, List<PracticalItem> items, Color accentColor) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
              child: Text(item.no),
            ),
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.play_circle_fill, size: 30, color: Colors.indigo),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item.targetWidget),
              );
            },
          ),
        );
      },
    );
  }
}
