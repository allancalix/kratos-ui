// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Curry = require("rescript/lib/js/curry.js");
var React = require("react");
var Kratos = require("../Bindings/Kratos.bs.js");
var $$Promise = require("reason-promise/src/js/promise.bs.js");
var KratosClient = require("@ory/kratos-client");
var RescriptReactRouter = require("@rescript/react/src/RescriptReactRouter.bs.js");

function signOut(param) {
  window.location.href = Kratos.logoutSelfServeEndpoint;
  
}

var opts = {
  basePath: Kratos.basePath
};

var api = new KratosClient.PublicApi(new KratosClient.Configuration(opts));

function Dashboard(Props) {
  var match = React.useState(function () {
        
      });
  var setIdentity = match[1];
  var identity = match[0];
  React.useEffect((function () {
          $$Promise.get($$Promise.Js.toResult(api.toSession(undefined, {
                        withCredentials: true
                      })), (function (res) {
                  if (res.TAG === /* Ok */0) {
                    var payload = res._0;
                    return Curry._1(setIdentity, (function (_prev) {
                                  return payload.data.identity;
                                }));
                  }
                  var payload$1 = res._0;
                  if (payload$1.response.status === 401) {
                    RescriptReactRouter.push("/login");
                  }
                  console.log(payload$1.response);
                  
                }));
          
        }), []);
  return React.createElement("div", undefined, identity !== undefined ? React.createElement("div", {
                    className: "min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8"
                  }, React.createElement("div", {
                        className: "max-w-md w-full space-y-8"
                      }, React.createElement("h1", {
                            className: "mt-6 text-center text-3xl font-extrabold text-gray-900"
                          }, "Hello " + identity.id + "!")), React.createElement("div", {
                        className: "mt-8 space-y-6"
                      }, React.createElement("button", {
                            className: "inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500",
                            onClick: (function (_event) {
                                return signOut(undefined);
                              })
                          }, "Sign out"))) : null);
}

var make = Dashboard;

exports.signOut = signOut;
exports.opts = opts;
exports.api = api;
exports.make = make;
/* api Not a pure module */
