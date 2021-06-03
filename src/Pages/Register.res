@val external window: {..} = "window"

let selfServeEndpoint = Kratos.registrationSelfServeEndpoint

let opts: Kratos.options = { basePath: Kratos.basePath}

let api = opts
|> Kratos.makeConfiguration
|> Kratos.makePublicAPI

let renderMessages = (messages: option<Kratos.messageList>) => {
  let messages = switch messages {
    | Some(m) => m
    | None => []
  }

  messages
}

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (methods, setMethods) = React.useState(_ => None);

  React.useEffect0(() => {
    switch url -> Url.parseSearchParams -> Belt.Map.get("flow") {
      | Some(id) => {
        api
        ->Kratos.getSelfServiceRegistrationFlow(id)
        -> Promise.Js.catch(err => {
          Js.log(err)
          RescriptReactRouter.push(Route.register)
          Promise.Js.rejected(err)
        })
        -> Promise.get(res => {
          Js.log(res)
          if res.status !== 200 {
            RescriptReactRouter.push(Route.login)
          }
          setMethods(_prev => Some(res.data.ui))
        })
      }
      | None => window["location"]["href"] = selfServeEndpoint
    }
    None
  })

  let loginForms = (container: Kratos.uiContainer) =>
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            {React.string(Messages.Registration.title)}
          </h2>
          <p className="mt-2 text-center text-sm text-gray-600">
            {React.string("Or ")}
            <a href="#" onClick={_ => RescriptReactRouter.push(Route.register)} className="font-medium text-indigo-600 hover:text-indigo-500">
              {React.string("register")}
            </a>
          </p>
        </div>
        {
          switch container.messages {
            | Some(m) =>
              React.array(m -> Js.Array2.map((m) => {
                <p key={m.id -> Belt.Int.toString}>{React.string(m.text)}</p>
              }))
            | None => React.null
          }
        }
        <Form ui={container} />
    </div>
  </div>

  switch methods {
    | Some(m) => loginForms(m)
    | None => React.null
  }
}
