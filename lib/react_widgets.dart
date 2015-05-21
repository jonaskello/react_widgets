library react_widgets;

import 'dart:js';

JsObject _window = new JsObject.fromBrowserObject(context['window']);
JsObject _react = _window['React'];
JsObject _Object = context['Object'];
JsObject _reactWidgets = _window['ReactWidgets'];
JsObject _dropdownList = _reactWidgets['DropdownList'];
JsObject _combobox = _reactWidgets['Combobox'];
JsObject _numberPicker = _reactWidgets['NumberPicker'];
JsObject _multiselect = _reactWidgets['Multiselect'];

JsObject dropdownList(Map props, [dynamic children]) => _proxy(_dropdownList, props, children);

JsObject combobox(Map props, [dynamic children]) => _proxy(_combobox, props, children);

JsObject numberPicker(Map props, [dynamic children]) => _proxy(_numberPicker, props, children);

JsObject multiselect(Map props, [dynamic children]) => _proxy(_multiselect, props, children);

JsObject _proxy(JsObject element, Map props, [dynamic children]) {
  var propsJs = _convertProps(props);
  var instance = _react.callMethod("createElement", [element, propsJs, children]);
  return instance;
}

JsObject _convertProps(Map map) {
  var JsMap = new JsObject(_Object);
  for (var key in map.keys) {
    if (map[key] is Map) {
      JsMap[key] = _convertProps(map[key]);
    } else if (map[key] is List) {
      JsMap[key] = new JsArray.from(map[key]);
    }
    else {
      JsMap[key] = map[key];
    }
  }
  return JsMap;
}
