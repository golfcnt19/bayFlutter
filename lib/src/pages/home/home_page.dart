import 'package:bay_flutter1/src/bloc/home/home_bloc.dart';
import 'package:bay_flutter1/src/bloc/login/login_bloc.dart';
import 'package:bay_flutter1/src/constants/asset.dart';
import 'package:bay_flutter1/src/models/product.dart';
import 'package:bay_flutter1/src/pages/home/widgets/dialog_barcode_image.dart';
import 'package:bay_flutter1/src/pages/home/widgets/dialog_qr_image.dart';
import 'package:bay_flutter1/src/pages/home/widgets/dialog_scan_qrcode.dart';
import 'package:bay_flutter1/src/pages/home/widgets/product_item.dart';
import 'package:bay_flutter1/src/widgets/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeEventFetch());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => context.read<HomeBloc>().add(HomeEventToggleDisplay()),
            icon: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return state.isGrid ? Icon(Icons.grid_3x3) : Icon(Icons.list);
              },
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<HomeBloc>().add(HomeEventFetch()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.isGrid ? _buildGridView(state.products, state.isGrid) : _buildListView(state.products, state.isGrid);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateManagementPage,
        child: const Icon(Icons.add),
      ),
    );
  }

  _navigateManagementPage([Product? product]) async {
    await Navigator.pushNamed(context, AppRoute.management, arguments: product);
    context.read<HomeBloc>().add(HomeEventFetch());
  }

  _buildGridView(List<Product> products, bool isGrid) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 0.7, // set height ratio -  (itemWidth / itemHeight)
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final item = products[index];
        return ProductItem(
          product: item,
          onTapAtPrice: () => CustomFlushbar.showSuccess(context, message: item.price.toString()),
          onTap: () => _navigateManagementPage(item),
          isGrid: isGrid,
        );
      },
    );
  }

  _buildListView(List<Product> products, bool isGrid) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final item = products[index];

        if (index == 0) {
          return Column(
            children: [
              _buildHeader(),
              SizedBox(
                height: 350,
                child: ProductItem(
                  product: item,
                  onTap: () {
                    CustomFlushbar.showSuccess(context, message: item.name);
                  },
                  isGrid: isGrid,
                ),
              ),
            ],
          );
        } else {
          return SizedBox(
            height: 350,
            child: ProductItem(
              product: item,
              onTap: () {
                CustomFlushbar.showSuccess(context, message: item.name);
              },
              isGrid: isGrid,
            ),
          );
        }
      },
    );
  }

  _buildHeader() {
    return Container(
        child: Image.asset(
      Asset.logoImage,
      height: 100,
      width: double.infinity,
    ));
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  void _showDialogBarcode(context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => const DialogBarcodeImage(
        'www.codemobiles.com',
      ),
    );
  }

  void _showDialogQRImage(context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => const DialogQRImage(
        'www.codemobiles.com',
        image: Asset.pinBikerImage,
      ),
    );
  }

  void _showScanQRCode(context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => DialogScanQRCode(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ListTile(
            onTap: () => _showDialogBarcode(context),
            title: const Text("BarCode"),
            leading: const Icon(Icons.bar_chart_outlined, color: Colors.deepOrange),
          ),
          ListTile(
            onTap: () => _showDialogQRImage(context),
            title: const Text("QRCode"),
            leading: const Icon(Icons.qr_code, color: Colors.green),
          ),
          ListTile(
            onTap: () => _showScanQRCode(context),
            title: const Text("Scanner"),
            leading: const Icon(Icons.qr_code_scanner, color: Colors.blueGrey),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, AppRoute.map),
            title: Text("Map"),
            leading: Icon(Icons.map_outlined, color: Colors.blue),
          ),
          const ListTile(
            // onTap: () => DatabaseService().runDemo(),
            title: Text("SQLite3"),
            leading: Icon(Icons.table_rows_sharp, color: Colors.blue),
          ),
          const Spacer(),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader _buildProfile() => UserAccountsDrawerHeader(
        currentAccountPicture: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            backgroundImage: AssetImage(Asset.cmLogoImage),
          ),
        ),
        accountName: const Text('CMDev'),
        accountEmail: const Text('support@codemobiles.com'),
      );

  Builder _buildLogoutButton() => Builder(
        builder: (context) => SafeArea(
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Log out'),
            onTap: () => context.read<LoginBloc>().add(LoginEventLogout()),
          ),
        ),
      );
}
