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
  let (methods, setMethods) = React.useState(_ => Js.Dict.empty());

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
            RescriptReactRouter.push(Route.register)
          }
          setMethods(_prev => res.data.methods)
        })
      }
      | None => window["location"]["href"] = selfServeEndpoint
    }
    None
  })

  let loginForms = methods->Js.Dict.values->Js.Array2.map((method) => {
    <div>
      <div>
      {
        React.array(method.config.messages -> renderMessages -> Js.Array2.map((m) => {
          <p key={m.id -> Belt.Int.toString}>{React.string(m.text)}</p>
        }))
      }
      </ div>
      <form className="mt-8 space-y-6" action={method.config.action} method={method.config.method}>
        <DynamicInputList fields={method.config.fields} />
        <button type_="submit" className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          {React.string("Register")}
        </button>
      </form>
    </div>
  })

  <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
    <div className="max-w-md w-full space-y-8">
      <div>
        <h1 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
          {React.string("Registration")}
        </h1>
      </div>
      {React.array(loginForms)}
    </div>
  </div>
}
