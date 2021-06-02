// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var React = require("react");

function shouldShowLabel(t) {
  return t !== "hidden";
}

function DynamicInput$NonStandardProps(Props) {
  return React.cloneElement(Props.children, Props.props);
}

var NonStandardProps = {
  make: DynamicInput$NonStandardProps
};

function DynamicInput(Props) {
  var field = Props.field;
  return React.createElement(React.Fragment, undefined, field.type !== "hidden" ? React.createElement(DynamicInput$NonStandardProps, {
                    props: {
                      "data-testid": "label"
                    },
                    children: React.createElement("label", {
                          key: field.name,
                          className: "sr-only"
                        }, field.name)
                  }) : null, React.createElement("input", {
                  defaultValue: field.value,
                  className: "appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm",
                  name: field.name,
                  placeholder: field.name,
                  required: field.required,
                  type: field.type
                }));
}

var make = DynamicInput;

exports.shouldShowLabel = shouldShowLabel;
exports.NonStandardProps = NonStandardProps;
exports.make = make;
/* react Not a pure module */
