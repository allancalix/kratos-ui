@val external window: {..} = "window"

let selfServeEndpoint = "http://127.0.0.1:4433/self-service/login/browser"

let opts: Kratos.options = { basePath: "http://127.0.0.1:4433"}

let api = opts
|> Kratos.makeConfiguration
|> Kratos.makePublicAPI

@react.component
let make = () => {
  React.useEffect0(() => {
    let url = RescriptReactRouter.useUrl()
    switch url -> Url.parseSearchParams -> Belt.Map.get("flow") {
      | Some(id) => {
        api
        ->Kratos.getSelfServiceLoginFlow(id)
        -> Promise.Js.catch(err => {
          Js.log(err)
          Promise.Js.rejected(err)
        })
        -> Promise.get(res => {
          let interestingConfig = res.data.methods -> Js.Dict.get("password")
          Js.log(interestingConfig)
        })
      }
      | None => window["location"]["href"] = selfServeEndpoint
    }
    None
  })

  <div>
    <LoginForm />
  </div>
}
