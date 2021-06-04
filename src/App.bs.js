// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Login = require("./Pages/Login.bs.js");
var React = require("react");
var NotFound = require("./Pages/NotFound.bs.js");
var Recovery = require("./Pages/Recovery.bs.js");
var Register = require("./Pages/Register.bs.js");
var Dashboard = require("./Pages/Dashboard.bs.js");
var RescriptReactRouter = require("@rescript/react/src/RescriptReactRouter.bs.js");

function App(Props) {
  var url = RescriptReactRouter.useUrl(undefined, undefined);
  var match = url.path;
  if (!match) {
    return React.createElement(Dashboard.make, {});
  }
  switch (match.hd) {
    case "login" :
        if (!match.tl) {
          return React.createElement(Login.make, {});
        }
        break;
    case "recovery" :
        if (!match.tl) {
          return React.createElement(Recovery.make, {});
        }
        break;
    case "register" :
        if (!match.tl) {
          return React.createElement(Register.make, {});
        }
        break;
    default:
      
  }
  return React.createElement(NotFound.make, {});
}

var make = App;

exports.make = make;
/* Login Not a pure module */
