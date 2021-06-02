type request
type response

@bs.new external makeXMLHttpRequest: unit => request = "XMLHttpRequest"
@bs.send
external addEventListener: (request, string, unit => unit) => unit = "addEventListener"
@bs.get external response: request => response = "response"
@bs.send external open_: (request, string, string) => unit = "open"
@bs.send external send: request => unit = "send"
@bs.send external abort: request => unit = "abort"
@bs.set external withCredentials: (request, bool) => unit = "withCredentials"

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

type nameTrait = {
  first: string,
  last: string,
}

type traits = {
  email: string,
  name: nameTrait,
}

type user = {
  id: string,
  schema_id: string,
  schema_url: string,
  traits: traits,
}

type t = {
  active: bool,
  authenticated_at: string,
  expires_at: string,
  id: string,
  identity: user,
  issued_at: string,
  error: option<errorType>,
}

@bs.scope("JSON") @bs.val
external parseResponse: response => t = "parse"

@bs.scope("JSON") @bs.val
external parseError: response => et = "parse"

let whoami = (~onDone, ~onError, ()) => {
  let request = makeXMLHttpRequest()

  request->addEventListener("load", () =>
    onDone(request->response->parseResponse)
  )
  request->addEventListener("error", () => onError(request->response->parseError))


  request->withCredentials(true)
  request->open_(
    "GET",
    "http://127.0.0.1:4433/sessions/whoami",
  )
  request->send

  /* () => request->abort */
}
