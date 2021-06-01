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

type loginFlowResponse = {
  status: int,
  data: payload,
}

type registrationFlowResponse = {
  status: int,
  data: payload,
}

@bs.new @module("@ory/kratos-client") external makeConfiguration: options => configuration = "Configuration"
@bs.new @module("@ory/kratos-client") external makePublicAPI: configuration => publicAPI = "PublicApi"
@bs.send external getSelfServiceRecoveryFlow: (publicAPI, string) =>
  Promise.t<recoveryFlowResponse> = "getSelfServiceRecoveryFlow"

@bs.send external getSelfServiceLoginFlow: (publicAPI, string) =>
  Promise.t<loginFlowResponse> = "getSelfServiceLoginFlow"

@bs.send external getSelfServiceRegistrationFlow: (publicAPI, string) =>
  Promise.t<registrationFlowResponse> = "getSelfServiceRegistrationFlow"
