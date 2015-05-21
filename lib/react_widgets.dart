library react_widgets;

import 'dart:js';
import 'package:react/react.dart';
import 'package:react/react_client.dart' as reactClient;

JsObject _window = new JsObject.fromBrowserObject(context['window']);
JsObject _reactWidgets = _window['ReactWidgets'];
JsObject _reactDropdownList = _reactWidgets['DropdownList'];
JsObject _react = _window['React'];

reactClient.ReactComponentFactory dropdownList = _createDropdownList;

JsObject _createDropdownList(Map props, [dynamic children]) {

  if (props["data"] != null && props["data"] is List) {
    props["data"] = new JsArray.from(props["data"]);
  }

  var propsJs = reactClient.newJsMap(props);

  var element = _react.callMethod("createElement", [_reactDropdownList, propsJs, children]);
  return element;

}

JsObject dropdownList3({List data, String textField, Component valueComponentComponent, dynamic children}) {
  Props props = new Props();
  props.add("data", data);
  props.add("textField", textField);
  props.add("valueComponentComponent", valueComponentComponent);
  var propsJs = props.toJsMap();
  var element = _react.callMethod("createElement", [_reactDropdownList, propsJs, children]);
  return element;
}

class Props {

  Map _props = new Map();

  void add(String name, dynamic value) {
    if(value is List)
      value = new JsArray.from(value);
    if (value != null)
      _props[name] = value;
  }

  JsObject toJsMap() {
    return reactClient.newJsMap(_props);
  }

}


//class DropdownProps {
//
//  List data;
//  String textField;
//  Component valueComponentComponent;
//
//  DropdownProps({this.data, this.textField, this.valueComponentComponent});
//
//  Map toJson() {
//    return {
//      "data": data,
//      "textField": textField,
//      "valueComponentComponent": valueComponentComponent
//    };
//  }
//
//}
