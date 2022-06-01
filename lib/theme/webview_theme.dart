import 'package:flutter/material.dart';
import '../../shared/extensions/color_extensions.dart';

String getWebviewTheme(BuildContext context) {
  return '''

  [role="banner"] {
    background-color: rgba(${Theme.of(context).appBarTheme.backgroundColor?.toRGBA()}) !important;
  }

  body {
    background-color: rgba(${Theme.of(context).canvasColor.toRGBA()}) !important;
  }

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  #title {
    color: rgba(${Theme.of(context).textTheme.headline1?.color?.toRGBA()}) !important;
  }

  button {
    background-color: rgba(${Theme.of(context).buttonTheme.colorScheme?.background.toRGBA()}) !important;
    color: rgba(${Theme.of(context).textTheme.subtitle2?.color?.toRGBA()}) !important
  }
  
''';
}
