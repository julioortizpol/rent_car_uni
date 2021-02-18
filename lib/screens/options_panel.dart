import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/Employee.dart';
import '../network/employee_service.dart';
import '../utilities/local_storage_web.dart';

class OptionsPanelScreen extends StatefulWidget {
  @override
  _OptionsPanelScreenState createState() => _OptionsPanelScreenState();
}

class _OptionsPanelScreenState extends State<OptionsPanelScreen> {
  Employee employee;

  getData() async {
    final employeeData =
        await getEmployee(await WebLocalStorage().get("employeeId"));
    employee = Employee.fromJson(employeeData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('RentCar'),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.white,
            tooltip: "Usuario",
            icon: Icon(Icons.account_circle_rounded),
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  child: Card(
                    elevation: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.account_circle_rounded,
                            size: 40,
                          ),
                          title: Text(employee.name),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Cerrar seccion'),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/');
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _CarouselCard(
              asset: const AssetImage(
                'bgrent.png',
              ),
              assetColor: const Color(0xFF344955),
              textColor: Colors.white,
              route: "/rent",
              title: "Renta",
            ),
            SizedBox(
              width: 20,
            ),
            _CarouselCard(
              asset: const AssetImage(
                'bgsetting.png',
              ),
              assetColor: const Color(0xFF344955),
              textColor: Colors.white,
              route: "/crud",
              title: "Administración",
            ),
            SizedBox(
              width: 20,
            ),
            _CarouselCard(
              asset: const AssetImage(
                'bgreport.png',
              ),
              assetColor: const Color(0xFF344955),
              textColor: Colors.white,
              route: "/report",
              title: "Reportes",
            ),
          ]),
        ),
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard(
      {Key key,
      this.asset,
      this.assetColor,
      this.textColor,
      this.route,
      this.title})
      : super(key: key);

  final ImageProvider asset;
  final Color assetColor;
  final String title;
  final Color textColor;
  final String route;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
    final asset = this.asset;
    final textColor = isDark ? Colors.white.withOpacity(0.87) : this.textColor;

    return Container(
      height: 250,
      width: 350,
      // Makes integration tests possible.
      margin: EdgeInsets.all(0),
      child: Material(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).restorablePushNamed(route);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (asset != null)
                FadeInImagePlaceholder(
                  image: asset,
                  child: Ink.image(
                    image: asset,
                    fit: BoxFit.cover,
                  ),
                  placeholder: Container(
                    color: assetColor,
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: textTheme.caption
                          .apply(color: textColor, fontSizeDelta: 15),
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeInImagePlaceholder extends StatelessWidget {
  const FadeInImagePlaceholder({
    Key key,
    @required this.image,
    @required this.placeholder,
    this.child,
    this.duration = const Duration(milliseconds: 500),
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.fit,
  })  : assert(placeholder != null),
        assert(image != null),
        super(key: key);

  /// The target image that we are loading into memory.
  final ImageProvider image;

  /// Widget displayed while the target [image] is loading.
  final Widget placeholder;

  /// What widget you want to display instead of [placeholder] after [image] is
  /// loaded.
  ///
  /// Defaults to display the [image].
  final Widget child;

  /// The duration for how long the fade out of the placeholder and
  /// fade in of [child] should take.
  final Duration duration;

  /// See [Image.excludeFromSemantics].
  final bool excludeFromSemantics;

  /// See [Image.width].
  final double width;

  /// See [Image.height].
  final double height;

  /// See [Image.fit].
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return this.child ?? child;
        } else {
          return AnimatedSwitcher(
            duration: duration,
            child: frame != null ? this.child ?? child : placeholder,
          );
        }
      },
    );
  }
}
