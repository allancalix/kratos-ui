@val @scope(("process", "env")) @return(nullable) external basePath: option<string> = "KRATOS_API"

let opts: Kratos.options = {basePath: basePath -> Belt.Option.getWithDefault("")}
let api = opts |> Kratos.makeConfiguration |> Kratos.makePublicAPI

let recoverySelfServeEndpoint = `${opts.basePath}/self-service/recovery/browser`
let loginSelfServeEndpoint = `${opts.basePath}/self-service/login/browser`
let registrationSelfServeEndpoint = `${opts.basePath}/self-service/registration/browser`
let logoutSelfServeEndpoint = `${opts.basePath}/self-service/browser/flows/logout`
