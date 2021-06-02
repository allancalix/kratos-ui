// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Jest = require("@glennsl/bs-jest/src/jest.bs.js");
var Curry = require("rescript/lib/js/curry.js");
var React = require("react");
var JestDom = require("bs-jest-dom/src/JestDom.bs.js");
var DynamicInput = require("../../src/Components/DynamicInput.bs.js");
var ReactTestingLibrary = require("@rescriptbr/react-testing-library/src/ReactTestingLibrary.bs.js");

Jest.describe("DynamicInputComponent", (function (param) {
        var field = {
          name: "password",
          required: true,
          type: "password",
          value: ""
        };
        Jest.test("when type is not hidden type then matches expected", (function (param) {
                return Jest.Expect.toMatchSnapshot(Jest.Expect.expect(ReactTestingLibrary.render(undefined, undefined, undefined, undefined, undefined, React.createElement(DynamicInput.make, {
                                        field: field
                                      })).container));
              }));
        Jest.test("when type is hidden then matches snapshot", (function (param) {
                return Jest.Expect.toMatchSnapshot(Jest.Expect.expect(ReactTestingLibrary.render(undefined, undefined, undefined, undefined, undefined, React.createElement(DynamicInput.make, {
                                        field: {
                                          name: "password",
                                          required: true,
                                          type: "hidden",
                                          value: ""
                                        }
                                      })).container));
              }));
        return Jest.test("when type is not hidden then has visible label", (function (param) {
                      var partial_arg = {
                        NAME: "Str",
                        VAL: "password"
                      };
                      var arg = function (param) {
                        return JestDom.toHaveTextContent(partial_arg, param);
                      };
                      var partial_arg$1 = {
                        NAME: "Str",
                        VAL: "label"
                      };
                      var arg$1 = function (param, param$1) {
                        return ReactTestingLibrary.getByTestId(partial_arg$1, param, param$1);
                      };
                      return Curry._2(arg, undefined, expect(Curry._2(arg$1, undefined, ReactTestingLibrary.render(undefined, undefined, undefined, undefined, undefined, React.createElement(DynamicInput.make, {
                                                  field: field
                                                })))));
                    }));
      }));

/*  Not a pure module */
