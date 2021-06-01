// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Url from "../Url.bs.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as Js_dict from "rescript/lib/es6/js_dict.js";
import * as $$Promise from "reason-promise/src/js/promise.bs.js";
import * as Belt_Map from "rescript/lib/es6/belt_Map.js";
import * as KratosClient from "@ory/kratos-client";
import * as RescriptReactRouter from "@rescript/react/src/RescriptReactRouter.bs.js";

var selfServeEndpoint = "http://127.0.0.1:4433/self-service/login/browser";

var opts = {
  basePath: "http://127.0.0.1:4433"
};

var api = new KratosClient.PublicApi(new KratosClient.Configuration(opts));

function renderInputs(fields) {
  return fields.map(function (field) {
              return React.createElement(React.Fragment, undefined, React.createElement("label", {
                              key: field.name
                            }, field.type !== "hidden" ? field.name : "", React.createElement("input", {
                                  defaultValue: field.value,
                                  name: field.name,
                                  required: field.required,
                                  type: field.type
                                })), React.createElement("br", undefined));
            });
}

function renderMessages(messages) {
  if (messages !== undefined) {
    return messages;
  } else {
    return [];
  }
}

function Login(Props) {
  var url = RescriptReactRouter.useUrl(undefined, undefined);
  var match = React.useState(function () {
        return {};
      });
  var setMethods = match[1];
  React.useEffect((function () {
          var id = Belt_Map.get(Url.parseSearchParams(url), "flow");
          if (id !== undefined) {
            $$Promise.get($$Promise.Js.$$catch(api.getSelfServiceLoginFlow(id), (function (err) {
                        console.log(err);
                        RescriptReactRouter.push("/login");
                        return $$Promise.Js.rejected(err);
                      })), (function (res) {
                    if (res.status !== 200) {
                      RescriptReactRouter.push("/login");
                    }
                    return Curry._1(setMethods, (function (_prev) {
                                  return res.data.methods;
                                }));
                  }));
          } else {
            window.location.href = selfServeEndpoint;
          }
          
        }), []);
  var loginForms = Js_dict.values(match[0]).map(function (method) {
        var messages = method.config.messages;
        return React.createElement("div", undefined, React.createElement("div", undefined, (
                          messages !== undefined ? messages : []
                        ).map(function (m) {
                            return React.createElement("p", {
                                        key: String(m.id)
                                      }, m.text);
                          })), React.createElement("form", {
                        action: method.config.action,
                        method: method.config.method
                      }, React.createElement("p", undefined, "Config for method detected: " + method.method), renderInputs(method.config.fields), React.createElement("input", {
                            name: "submit",
                            type: "submit"
                          })));
      });
  return React.createElement("div", undefined, loginForms);
}

var make = Login;

export {
  selfServeEndpoint ,
  opts ,
  api ,
  renderInputs ,
  renderMessages ,
  make ,
  
}
/* api Not a pure module */
