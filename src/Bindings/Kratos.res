type configuration

type publicAPI

type options = {basePath: string}

type uiText = {
  // TODO(allancalix): Not sure about this.
  context: option<Js.Dict.t<string>>,
  id: int,
  text: string,
  \"type": string,
}

type meta = {label: option<uiText>}

// TODO(allancalix): Not sure yet how to parse values into variants reliably.
type uiNodeInputAttributesValue = string
/* | Bool(bool) */
/* | Int(int) */
/* | String(string); */

type uiNodeInputAttributes = {
  disabled: bool,
  label: option<uiText>,
  name: string,
  pattern: option<string>,
  required: option<bool>,
  \"type": string,
  value: option<uiNodeInputAttributesValue>,
}

type testUiNodeAttributes =
  | UiNodeInputAttributes(uiNodeInputAttributes)
  | UiNodeAnchorAttributes
  | UiNodeImageAttributes
  | UiNodeTextAttributes
  | UiNodeNotRecognized

type uiNodeAttributes = uiNodeInputAttributes

type uiNode = {
  group: string,
  messages: Js.Nullable.t<array<uiText>>,
  meta: meta,
  \"type": string,
}

type attributes
@get external attributes: uiNode => attributes = "attributes"
@get external disabled: attributes => bool = "disabled"
@get external label: attributes => option<uiText> = "label"
@get external name: attributes => string = "name"
@get external pattern: attributes => option<string> = "pattern"
@get external required: attributes => option<bool> = "required"
@get external \"type": attributes => string = "type"
@get external value: attributes => option<uiNodeInputAttributesValue> = "value"

let parseAttrs = node =>
  switch node.\"type" {
  | "input" =>
    UiNodeInputAttributes({
      disabled: node->attributes->disabled,
      label: node->attributes->label,
      name: node->attributes->name,
      pattern: node->attributes->pattern,
      required: node->attributes->required,
      \"type": node->attributes->\"type",
      value: node->attributes->value,
    })
  | _ => UiNodeNotRecognized
  }

type uiContainer = {
  action: string,
  messages: option<array<uiText>>,
  method: string,
  nodes: array<uiNode>,
}

type loginFlow = {
  active: option<string>,
  created_at: option<string>,
  expires_at: string,
  forced: option<bool>,
  id: string,
  issued_at: string,
  request_url: string,
  \"type": string,
  ui: uiContainer,
  updated_at: option<string>,
}

type registrationFlow = {
  active: option<string>,
  expires_at: string,
  id: string,
  issued_at: string,
  request_url: string,
  \"type": string,
  ui: uiContainer,
}

type recoveryAddress = {
  created_at: option<string>,
  id: string,
  updated_at: option<string>,
  value: string,
  via: string,
}

type verifiableIdentityAddress = {
  created_at: option<string>,
  id: string,
  status: string,
  updated_at: option<string>,
  value: string,
  verified: bool,
  verified_at: option<string>,
  via: string,
}

type nameTrait = {
  first: string,
  last: string,
}

// TODO(allancalix): This is a dynamic trait that is set depending on the
// schema. Hard coding this to the default schema for now.
type traits = {
  email: string,
  name: Js.Nullable.t<nameTrait>,
}

type identity = {
  created_at: option<string>,
  id: string,
  recovery_addresses: option<array<recoveryAddress>>,
  schema_id: string,
  schema_url: string,
  traits: traits,
  updated_at: option<string>,
  verifiable_addresses: option<array<verifiableIdentityAddress>>,
}

type recoveryFlow = {
  active: option<bool>,
  authenticated_at: string,
  expires_at: string,
  id: string,
  request_url: string,
  identity: identity,
  state: string,
  \"type": option<string>,
  issued_at: string,
  ui: uiContainer,
}

type session = {
  active: option<bool>,
  authenticated_at: string,
  expires_at: string,
  id: string,
  identity: identity,
  issued_at: string,
}

type response<'a> = {
  // `data` is the response that was provided by the server
  data: 'a,
  // `status` is the HTTP status code from the server response
  status: int,
  // `statusText` is the HTTP status message from the server response
  statusText: string,

  // TODO(allancalix): Define headers type.
  // `headers` the HTTP headers that the server responded with
  // All header names are lower cased and can be accessed using the bracket notation.
  // Example: `response.headers['content-type']`
  // headers: Js.t<{..}>,

  // TODO(allancalix): Define config type.
  // `config` is the config that was provided to `axios` for the request
  // config: {},

  // TODO(allancalix): Define request type.
  // `request` is the request that generated this response
  // It is the last ClientRequest instance in node.js (in redirects)
  // and an XMLHttpRequest instance in the browser
  // request: {}
}

// TODO(allancalix): This should probably be optional.
type requestOpts = {withCredentials: bool}

type error = {
  code: int,
  message: string,
  reason: string,
  status: string,
}

type responseErr = {response: response<error>}

@new @module("@ory/kratos-client")
external makeConfiguration: options => configuration = "Configuration"
@new @module("@ory/kratos-client") external makePublicAPI: configuration => publicAPI = "PublicApi"

@send
external getSelfServiceRecoveryFlow: (
  publicAPI,
  string,
) => Promise.Js.t<response<recoveryFlow>, responseErr> = "getSelfServiceRecoveryFlow"

@send
external getSelfServiceLoginFlow: (
  publicAPI,
  string,
) => Promise.Js.t<response<loginFlow>, responseErr> = "getSelfServiceLoginFlow"

@send
external getSelfServiceRegistrationFlow: (
  publicAPI,
  string,
) => Promise.Js.t<response<registrationFlow>, responseErr> = "getSelfServiceRegistrationFlow"

@send
external toSession: (
  publicAPI,
  option<string>,
  option<requestOpts>,
) => Promise.Js.t<response<session>, responseErr> = "toSession"
