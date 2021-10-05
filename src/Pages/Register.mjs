// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Form from "../Components/Form.mjs";
import * as Curry from "rescript/lib/es6/curry.js";
import * as Route from "./Route.mjs";
import * as React from "react";
import * as $$Promise from "reason-promise/src/js/promise.mjs";
import * as Messages from "./Messages.mjs";
import * as KratosClient from "../KratosClient.mjs";
import * as ActionMessages from "../Components/ActionMessages.mjs";
import * as RescriptReactRouter from "@rescript/react/src/RescriptReactRouter.mjs";

function Register(Props) {
  var match = React.useState(function () {
        
      });
  var setMethods = match[1];
  var methods = match[0];
  React.useEffect((function () {
          $$Promise.get($$Promise.Js.toResult(KratosClient.api.initializeSelfServiceRegistrationFlowForBrowsers()), (function (res) {
                  if (res.TAG !== /* Ok */0) {
                    return RescriptReactRouter.push("/login");
                  }
                  var payload = res._0;
                  return Curry._1(setMethods, (function (_prev) {
                                return payload.data.ui;
                              }));
                }));
          
        }), []);
  if (methods !== undefined) {
    var m = methods.messages;
    return React.createElement("div", {
                className: "min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8"
              }, React.createElement("div", {
                    className: "max-w-md w-full space-y-8"
                  }, React.createElement("div", undefined, React.createElement("h2", {
                            className: "mt-6 text-center text-3xl font-extrabold text-gray-900"
                          }, Messages.Registration.title), React.createElement("p", {
                            className: "mt-2 text-center text-sm text-gray-600"
                          }, "Or ", React.createElement("a", {
                                className: "font-medium text-indigo-600 hover:text-indigo-500",
                                href: "#",
                                onClick: (function (param) {
                                    return RescriptReactRouter.push(Route.login);
                                  })
                              }, "login"))), m !== undefined ? React.createElement(ActionMessages.make, {
                          messages: m
                        }) : null, React.createElement(Form.make, {
                        ui: methods
                      })));
  } else {
    return null;
  }
}

var make = Register;

export {
  make ,
  
}
/* Form Not a pure module */
