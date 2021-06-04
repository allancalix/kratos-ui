let selfServeEndpoint = Kratos.recoverySelfServeEndpoint

let opts: Kratos.options = {basePath: Kratos.basePath}

let api = opts |> Kratos.makeConfiguration |> Kratos.makePublicAPI

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (methods, setMethods) = React.useState(_ => None)

  React.useEffect0(() => {
    switch url->Url.parseSearchParams->Belt.Map.get("flow") {
    | Some(id) =>
      api
      ->Kratos.getSelfServiceRecoveryFlow(id)
      ->Promise.Js.toResult
      ->Promise.get(res => {
        switch res {
        | Ok(payload) => setMethods(_prev => Some(payload.data.ui))
        | Error(payload) => {
            Js.log(payload.response)
            if payload.response.status !== 200 {
              RescriptReactRouter.push("/login")
            }
          }
        }
      })
    | None =>
      switch Window.redirect(selfServeEndpoint) {
      | Ok(_) => Js.log("Window location set but page redirect failed.")
      | Error(e) =>
        switch e {
        | _ => Js.log(e)
        }
      }
    }

    None
  })
  let loginForms = (container: Kratos.uiContainer) =>
    <div
      className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            {React.string(Messages.Recovery.title)}
          </h2>
        </div>
        {switch container.messages {
        | Some(m) =>
          React.array(
            m->Js.Array2.map(m => {
              <p key={m.id->Belt.Int.toString}> {React.string(m.text)} </p>
            }),
          )
        | None => React.null
        }}
        <Form ui={container} />
      </div>
    </div>

  <div>
    {switch methods {
    | Some(m) => loginForms(m)
    | None => React.null
    }}
  </div>
}