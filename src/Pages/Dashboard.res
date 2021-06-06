let signOut = url => {
  switch Window.redirect(KratosClient.logoutSelfServeEndpoint ++ Url.forwardSearchParams(url)) {
  | Ok(_) => Js.log("Window location set but page redirect failed.")
  | Error(e) =>
    switch e {
    | _ => Js.log(e)
    }
  }
}

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (identity, setIdentity) = React.useState(_ => None)

  React.useEffect0(() => {
    KratosClient.api
    ->Kratos.toSession(/* token= */ None, /* options= */ Some({withCredentials: true}))
    ->Promise.Js.toResult
    ->Promise.get(res => {
      Js.log(res)
      switch res {
      | Ok(payload) => setIdentity(_prev => Some(payload.data.identity))
      | Error(payload) => {
          if payload.response.status === 401 {
            RescriptReactRouter.push("/login")
          }

          Js.log(payload.response)
        }
      }
    })

    None
  })

  <div>
    {switch identity {
    | None => React.null
    | Some(i) =>
      <div
        className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-md w-full space-y-8">
          <DynamicInput.NonStandardProps props={"data-testid": "greeting"}>
            <h1 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
              {React.string("Hello " ++ i.traits.email ++ "!")}
            </h1>
          </DynamicInput.NonStandardProps>
        </div>
        <div className="mt-8 space-y-6">
          <button
            className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
            onClick={_event => signOut(url)}>
            {React.string("Sign out")}
          </button>
        </div>
      </div>
    }}
  </div>
}
