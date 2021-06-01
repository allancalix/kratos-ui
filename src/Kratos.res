type options = {
  basePath: string,
}
type configuration
type publicAPI

type recoveryFlowResponse = {
  status: int,
}

type inputField = {
  name: string,
  required: bool,
  type_: string,
  value: string,
}

type loginTypeConfig = {
  action: string,
  method: string,
  fields: array<inputField>,
}

type loginPayload = {
  expires_at: string,
  forced: bool,
  id: string,
  issued_at: string,
  // This might not quite be right because this field is nullable.
  messages: array<string>,
  methods: Js.Dict.t<loginTypeConfig>,
  // messages omitted

}

type loginFlowResponse = {
  status: int,
  data: loginPayload,
}

@bs.new @module("@ory/kratos-client") external makeConfiguration: options => configuration = "Configuration"
@bs.new @module("@ory/kratos-client") external makePublicAPI: configuration => publicAPI = "PublicApi"
@bs.send external getSelfServiceRecoveryFlow: (publicAPI, string) =>
  Promise.t<recoveryFlowResponse> = "getSelfServiceRecoveryFlow"

@bs.send external getSelfServiceLoginFlow: (publicAPI, string) =>
  Promise.t<loginFlowResponse> = "getSelfServiceLoginFlow"
