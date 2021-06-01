type request
type response

@bs.new external makeXMLHttpRequest: unit => request = "XMLHttpRequest"
@bs.send
external addEventListener: (request, string, unit => unit) => unit = "addEventListener"
@bs.get external response: request => response = "response"
@bs.send external open_: (request, string, string) => unit = "open"
@bs.send external send: request => unit = "send"
@bs.send external abort: request => unit = "abort"

@bs.get external status: request => int = "status"

type errorType = {
  code: int,
  message: string,
  reason: string,
  status: string,
}

type et = {
  error: errorType,
}

/* @bs.scope("JSON") @bs.val */
/* external parseResponse: response => array<t> = "parse" */

/* type t = { */
/*   row_id: float, */
/*   receiver: option<string>, */
/*   sender: string, */
/*   fee: float, */
/*   volume: float, */
/*   time: string, */
/* } */

@bs.scope("JSON") @bs.val
external parseError: response => array<et> = "parse"

/* let testQuery = (~onDone, ~onError, ()) => { */
/*   let request = makeXMLHttpRequest() */
/*  */
/*   request->addEventListener("load", () => */
/*     onDone(request->response->parseResponse) */
/*   ) */
/*   request->addEventListener("error", () => onError(request->response->parseError)) */
/*  */
/*   request->open_( */
/*     "GET", */
/*     "http://127.0.0.1:4433/sessions/whoami", */
/*   ) */
/*   request->send */
/*  */
/*   /* () => request->abort */ */
/* } */
