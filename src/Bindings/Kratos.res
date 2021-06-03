@val external process: {..} = "process"

let basePath = process["env"]["KRATOS_API"]

let loginSelfServeEndpoint = `${basePath}/self-service/login/browser`

let registrationSelfServeEndpoint = `${basePath}/self-service/registration/browser`

let logoutSelfServeEndpoint = `${basePath}/self-service/browser/flows/logout`

let whoamiEndpoint = `${basePath}/sessions/whoami`

type options = {
  basePath: string,
}
type configuration
type publicAPI

type message = {
  id: int,
  text: string,
}

type messageList = array<message>

type recoveryFlowResponse = {
  status: int,
}

type inputField = {
  name: string,
  required: bool,
  \"type": string,
  value: string,
}

type loginTypeConfig = {
  action: string,
  method: string,
  fields: array<inputField>,
  messages: option<messageList>,
}

type supportedMethod = {
  config: loginTypeConfig,
  method: string,
  messages: array<string>,
}

type payload = {
  expires_at: string,
  forced: bool,
  id: string,
  issued_at: string,
  // This might not quite be right because this field is nullable.
  messages: array<string>,
  methods: Js.Dict.t<supportedMethod>,

}

type uiText = {
  // TODO(allancalix): Not sure about this.
  context: option<Js.Dict.t<string>>,
  id: int,
  text: string,
  \"type": string,
}

type meta = {
  label: option<uiText>,
}

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

// TODO(allancalix): Implement the other types.
/* type UiNodeAttributes = UiNodeAnchorAttributes | UiNodeImageAttributes | UiNodeInputAttributes | UiNodeTextAttributes; */
type uiNodeAttributes = uiNodeInputAttributes

/* let readAttributes = (uiNodeAttributes) => */
/*   | UiNodeInputAttributes(uiNodeInputAttributes) */

type uiNode = {
  attributes: uiNodeAttributes,
  group: string,
  message: array<uiText>,
  meta: meta,
  \"type": string,
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

type identity = {
  created_at: option<string>,
  id: string,
  recovery_addresses: option<array<recoveryAddress>>,
  schema_id: string,
  schema_url: string,
  // traits: option<{..}>,
  updated_at: option<string>,
  verifiable_addresses: option<array<verifiableIdentityAddress>>,
}

type session = {
  active: option<bool>,
  authenticated_at: string,
  expires_at: string,
  id: string,
  \"identity": identity,
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
type requestOpts = {
  withCredentials: bool,
}

type error = {
  code: int,
  message: string,
  reason: string,
  status: string,
}

type responseErr = {
  response: response<error>,
}

@bs.new @module("@ory/kratos-client") external makeConfiguration: options => configuration = "Configuration"
@bs.new @module("@ory/kratos-client") external makePublicAPI: configuration => publicAPI = "PublicApi"
@bs.send external getSelfServiceRecoveryFlow: (publicAPI, string) =>
  Promise.t<recoveryFlowResponse> = "getSelfServiceRecoveryFlow"

@bs.send external getSelfServiceLoginFlow: (publicAPI, string) =>
  Promise.t<response<loginFlow>> = "getSelfServiceLoginFlow"

@bs.send external getSelfServiceRegistrationFlow: (publicAPI, string) =>
  Promise.t<response<registrationFlow>> = "getSelfServiceRegistrationFlow"

@bs.send
external toSession: (publicAPI, option<string>, option<requestOpts>) =>
  Promise.Js.t<response<session>, responseErr> = "toSession"
