// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as KratosClient from "@ory/kratos-client";

var opts_basePath = Belt_Option.getWithDefault(Caml_option.nullable_to_opt(process.env.KRATOS_API), "");

var opts_baseOptions = {
  withCredentials: true,
  timeout: undefined
};

var opts = {
  basePath: opts_basePath,
  baseOptions: opts_baseOptions
};

var api = new KratosClient.V0alpha2Api(new KratosClient.Configuration(opts));

export {
  opts ,
  api ,
  
}
/* opts Not a pure module */
