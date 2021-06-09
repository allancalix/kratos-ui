@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (methods, setMethods) = React.useState(_ => None)
  let (flowID, setFlowID) = React.useState(_ => url->Url.parseSearchParams->Belt.Map.get("flow"))

  React.useEffect1(() => {
    switch url->Url.parseSearchParams->Belt.Map.get("flow") {
    | Some(id) =>
      KratosClient.api
      ->Kratos.getSelfServiceRegistrationFlow(id)
      ->Promise.Js.toResult
      ->Promise.get(res => {
        Js.log(res)
        switch res {
        | Ok(payload) => setMethods(_prev => Some(payload.data.ui))
        | Error(payload) => switch payload.response.status {
              // 410: Gone. This means the flow id is expired and this process
              // should repeat.
              | 410 => setFlowID(_prev => None)
              | _ => RescriptReactRouter.push("/login")
          }
        }
      })
    | None =>
      switch Window.redirect(
        KratosClient.registrationSelfServeEndpoint ++ Url.forwardSearchParams(url),
      ) {
      | Ok(_) => Js.log("Window location set but page redirect failed.")
      | Error(e) =>
        switch e {
        | _ => Js.log(e)
        }
      }
    }
    None
  }, [flowID])

  let loginForms = (container: Kratos.uiContainer) =>
    <div
      className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            {React.string(Messages.Registration.title)}
          </h2>
          <p className="mt-2 text-center text-sm text-gray-600">
            {React.string("Or ")}
            <a
              href="#"
              onClick={_ => RescriptReactRouter.push(Route.login)}
              className="font-medium text-indigo-600 hover:text-indigo-500">
              {React.string("login")}
            </a>
          </p>
        </div>
        {switch container.messages {
        | Some(m) => <ActionMessages messages={m} />
        | None => React.null
        }}
        <Form ui={container} />
      </div>
    </div>

  switch methods {
  | Some(m) => loginForms(m)
  | None => React.null
  }
}
