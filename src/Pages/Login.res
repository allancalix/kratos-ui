@val external window: {..} = "window"

let selfServeEndpoint = "http://127.0.0.1:4433/self-service/login/browser"

let opts: Kratos.options = { basePath: "http://127.0.0.1:4433"}

let api = opts
|> Kratos.makeConfiguration
|> Kratos.makePublicAPI

let renderInputs = (fields: array<Kratos.inputField>) => {
  fields->Js.Array2.map((field) => {
      <>
        <label key={field.name} className="sr-only">
          {field.\"type" !== "hidden" ? React.string(field.name) : React.string("")}
        </label>
          <input
            className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
            name={field.name}
            defaultValue={field.value}
            placeholder={field.name}
            type_={field.\"type"}
            required={field.required}/>
      </>
  })
}

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
        ->Kratos.getSelfServiceLoginFlow(id)
        -> Promise.Js.catch(err => {
          Js.log(err)
          RescriptReactRouter.push(Route.login)
          Promise.Js.rejected(err)
        })
        -> Promise.get(res => {
          if res.status !== 200 {
            RescriptReactRouter.push(Route.login)
          }
          setMethods(_prev => res.data.methods)
        })
      }
      | None => window["location"]["href"] = selfServeEndpoint
    }
    None
  })

  let loginForms = methods->Js.Dict.values->Js.Array2.map((method) => {
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            {React.string("Sign in")}
          </h2>
          <p className="mt-2 text-center text-sm text-gray-600">
            {React.string("Or ")}
            <a href="#" onClick={_ => RescriptReactRouter.push(Route.register)} className="font-medium text-indigo-600 hover:text-indigo-500">
              {React.string("register")}
            </a>
          </p>
        </div>
        {
          React.array(method.config.messages -> renderMessages -> Js.Array2.map((m) => {
            <p key={m.id -> Belt.Int.toString}>{React.string(m.text)}</p>
          }))
        }
        <form className="mt-8 space-y-6" action={method.config.action} method={method.config.method}>
          <div className="mt-8 space-y-6">
            {React.array(renderInputs(method.config.fields))}
          </div>
          <div className="flex items-center justify-between">
            <div className="text-sm">
              <a className="font-medium text-indigo-600 hover:text-indigo-500">
                {React.string("Forgot your password?")}
              </a>
            </div>
          </div>
          <div>
            <button type_="submit" className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              {React.string("Sign in")}
            </button>
        </div>
      </form>
    </div>
  </div>
  })

  <div>
    {React.array(loginForms)}
  </div>
}
