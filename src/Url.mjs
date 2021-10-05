// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Belt_Id from "rescript/lib/es6/belt_Id.js";
import * as Belt_Map from "rescript/lib/es6/belt_Map.js";
import * as Caml_obj from "rescript/lib/es6/caml_obj.js";
import * as Caml_array from "rescript/lib/es6/caml_array.js";
import * as Caml_option from "rescript/lib/es6/caml_option.js";

var cmp = Caml_obj.caml_compare;

var SearchKeyCmp = Belt_Id.MakeComparable({
      cmp: cmp
    });

function parseSearchParams(url) {
  return url.search.split("&").filter(function (v) {
                return Caml_option.null_to_opt(v.match(/.*=.*/)) !== undefined;
              }).reduce((function (acc, item) {
                var kv = item.split("=");
                return Belt_Map.set(acc, Caml_array.get(kv, 0), Caml_array.get(kv, 1));
              }), Belt_Map.make(SearchKeyCmp));
}

function paramsFromSourceURL(url) {
  var params = parseSearchParams(url);
  return {
          params: {
            return_to: Belt_Map.getWithDefault(params, "return_to", "")
          }
        };
}

function forwardSearchParams(url) {
  if (url.search === "") {
    return url.search;
  } else {
    return "?" + url.search;
  }
}

export {
  SearchKeyCmp ,
  parseSearchParams ,
  paramsFromSourceURL ,
  forwardSearchParams ,
  
}
/* SearchKeyCmp Not a pure module */
