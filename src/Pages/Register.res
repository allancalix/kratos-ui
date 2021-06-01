@val external window: {..} = "window"

let selfServeEndpoint = "http://127.0.0.1:4433/self-service/registration/browser"

let opts: Kratos.options = { basePath: "http://127.0.0.1:4433"}

let api = opts
|> Kratos.makeConfiguration
|> Kratos.makePublicAPI

let renderInputs = (fields: array<Kratos.inputField>) => {
  fields->Js.Array2.map((field) => {
      <>
        <label key={field.name}>
          {field.\"type" !== "hidden" ? React.string(field.name) : React.string("")}
          <input
            name={field.name}
            defaultValue={field.value}
            type_={field.\"type"}
            required={field.required}/>
        </label><br />
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
        ->Kratos.getSelfServiceRegistrationFlow(id)
        -> Promise.Js.catch(err => {
          Js.log(err)
          RescriptReactRouter.push("/register")
          Promise.Js.rejected(err)
        })
        -> Promise.get(res => {
          Js.log(res)
          if res.status !== 200 {
            RescriptReactRouter.push("/register")
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
      <form action={method.config.action} method={method.config.method}>
        <p>{React.string("Config for method detected: "++method.method)}</p>
        {React.array(renderInputs(method.config.fields))}
        <input type_="submit" name="submit" />
      </form>
    </div>
  })

  <div>
    <h1>{React.string("registration")}</h1>
    {React.array(loginForms)}
  </div>
}
