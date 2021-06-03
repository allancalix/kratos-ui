// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Url = require("../Url.bs.js");
var Form = require("../Components/Form.bs.js");
var Curry = require("rescript/lib/js/curry.js");
var Route = require("./Route.bs.js");
var React = require("react");
var Kratos = require("../Bindings/Kratos.bs.js");
var $$Promise = require("reason-promise/src/js/promise.bs.js");
var Belt_Map = require("rescript/lib/js/belt_Map.js");
var Messages = require("./Messages.bs.js");
var KratosClient = require("@ory/kratos-client");
var RescriptReactRouter = require("@rescript/react/src/RescriptReactRouter.bs.js");

var opts = {
  basePath: Kratos.basePath
};

var api = new KratosClient.PublicApi(new KratosClient.Configuration(opts));

function renderMessages(messages) {
  if (messages !== undefined) {
    return messages;
  } else {
    return [];
  }
}

function Register(Props) {
  var url = RescriptReactRouter.useUrl(undefined, undefined);
  var match = React.useState(function () {
        
      });
  var setMethods = match[1];
  var methods = match[0];
  React.useEffect((function () {
          var id = Belt_Map.get(Url.parseSearchParams(url), "flow");
          if (id !== undefined) {
            $$Promise.get($$Promise.Js.$$catch(api.getSelfServiceRegistrationFlow(id), (function (err) {
                        console.log(err);
                        RescriptReactRouter.push(Route.register);
                        return $$Promise.Js.rejected(err);
                      })), (function (res) {
                    console.log(res);
                    if (res.status !== 200) {
                      RescriptReactRouter.push(Route.login);
                    }
                    return Curry._1(setMethods, (function (_prev) {
                                  return res.data.ui;
                                }));
                  }));
          } else {
            window.location.href = Kratos.registrationSelfServeEndpoint;
          }
          
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
                                    return RescriptReactRouter.push(Route.register);
                                  })
                              }, "register"))), m !== undefined ? m.map(function (m) {
                          return React.createElement("p", {
                                      key: String(m.id)
                                    }, m.text);
                        }) : null, React.createElement(Form.make, {
                        ui: methods
                      })));
  } else {
    return null;
  }
}

var selfServeEndpoint = Kratos.registrationSelfServeEndpoint;

var make = Register;

exports.selfServeEndpoint = selfServeEndpoint;
exports.opts = opts;
exports.api = api;
exports.renderMessages = renderMessages;
exports.make = make;
/* api Not a pure module */
