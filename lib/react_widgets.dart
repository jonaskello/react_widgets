library react_widgets;

import 'dart:js';
import 'package:intl/intl.dart';

JsObject _window = new JsObject.fromBrowserObject(context['window']);
JsObject _react = _window['React'];
JsObject _Object = context['Object'];
JsObject _reactWidgets = _window['ReactWidgets'];
JsObject _dropdownList = _reactWidgets['DropdownList'];
JsObject _combobox = _reactWidgets['Combobox'];
JsObject _numberPicker = _reactWidgets['NumberPicker'];
JsObject _multiselect = _reactWidgets['Multiselect'];
JsObject _selectList = _reactWidgets['SelectList'];
JsObject _calendar = _reactWidgets['Calendar'];
JsObject _dateTimePicker = _reactWidgets['DateTimePicker'];

void init() {
  _patchGlobalize();
  Intl.defaultLocale = 'en_US';
}

JsObject dropdownList(Map props, [dynamic children]) => _proxy(_dropdownList, props, children);

JsObject combobox(Map props, [dynamic children]) => _proxy(_combobox, props, children);

JsObject numberPicker(Map props, [dynamic children]) => _proxy(_numberPicker, props, children);

JsObject multiselect(Map props, [dynamic children]) => _proxy(_multiselect, props, children);

JsObject selectList(Map props, [dynamic children]) => _proxy(_selectList, props, children);

JsObject calendar(Map props, [dynamic children]) {

//  var headerFormat = new DateFormat("MMMM yyyy", Intl.defaultLocale);
//  var format = new DateFormat.yMd("ar");
//  var dateString = format.format(new DateTime.now());

  _defaultProp("culture", "en-US", props);
//  _defaultProp("headerFormat", (DateTime date, c) => headerFormat.format(date), props);
  _defaultProp("headerFormat", (DateTime date, c) => date.toString(), props);
  _defaultProp("footerFormat", (DateTime date, c) => date.toString(), props);
  _defaultProp("dayFormat", (int dayOfTheWeek, c) => dayOfTheWeek.toString(), props);
  _defaultProp("dateFormat", (DateTime date, c) => date.day.toString(), props);
  _defaultProp("monthFormat", (DateTime date, c) => date.month.toString(), props);
  _defaultProp("yearFormat", (DateTime date, c) => date.year.toString(), props);
  _defaultProp("decadeFormat", (DateTime date, c) => "decade", props);
  _defaultProp("centuryFormat", (DateTime date, c) => "centuryFormat", props);

  return _proxy(_calendar, props, children);
}

JsObject dateTimePicker(Map props, [dynamic children]) => _proxy(_dateTimePicker, props, children);

void _defaultProp(String name, dynamic value, Map props) {
  if (props[name] == null)
    props[name] = value;
}

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

void _patchGlobalize() {

  // Patch gloablize, it has the following functions:
  var globalize = new JsObject(_Object);
//  // Globalize.addCultureInfo( cultureName, extendCultureName, info )
//  globalize["addCultureInfo"] = (cultureName, extendCultureName, info) {
//  };
//  // A mapping of culture codes to culture objects.
//  globalize["cultures"] = new JsObject(_Object)
//    ..["en-US"] = new JsObject(_Object)..["calendar"] = new JsObject(_Object);
//  // Globalize.culture( selector )
//  globalize["culture"] = () => "en-US";
  // Globalize.findClosestCulture( selector )
  globalize["findClosestCulture"] = (selector) => new JsObject(_Object);
//  // Globalize.format( value, format, culture )
//  globalize["format"] = (value, format, culture) {
//  };
//  // Globalize.localize( key, culture )
//  globalize["localize"] = (key, culture) => key;
//  // Globalize.parseInt( value, radix, culture )
//  globalize["parseInt"] = (value, radix, culture) => value;
//  // Globalize.parseFloat( value, radix, culture )
//  globalize["parseFloat"] = (value, radix, culture) => value;
//  // Globalize.parseDate( value, formats, culture )
//  globalize["parseDate"] = (value, formats, culture) => value;

  // Configure to use out globalize
  _reactWidgets["configure"].callMethod("setGlobalizeInstance", [globalize]);
}