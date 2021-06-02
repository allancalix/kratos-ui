// Generated by ReScript, PLEASE EDIT WITH CARE

import * as XHR from "../XHR.bs.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as Route from "./Route.bs.js";
import * as React from "react";
import * as RescriptReactRouter from "@rescript/react/src/RescriptReactRouter.bs.js";

function signOut(param) {
  window.location.href = "http://127.0.0.1:4433/self-service/browser/flows/logout";
  
}

function Dashboard(Props) {
  var match = React.useState(function () {
        
      });
  var setIdentity = match[1];
  var identity = match[0];
  React.useEffect((function () {
          XHR.whoami((function (res) {
                  var e = res.error;
                  if (e !== undefined) {
                    console.log(e);
                    if (e.code === 401) {
                      return RescriptReactRouter.push(Route.login);
                    } else {
                      return ;
                    }
                  } else {
                    return Curry._1(setIdentity, (function (_prev) {
                                  return res.identity;
                                }));
                  }
                }), (function (e) {
                  console.log(e);
                  
                }), undefined);
          
        }), []);
  return React.createElement("div", undefined, identity !== undefined ? React.createElement("div", undefined, React.createElement("header", undefined, React.createElement("button", {
                            onClick: (function (_event) {
                                return signOut(undefined);
                              })
                          }, "Sign out")), React.createElement("h1", undefined, "Hello " + identity.traits.name.first + "!")) : null);
}

var make = Dashboard;

export {
  signOut ,
  make ,
  
}
/* react Not a pure module */
