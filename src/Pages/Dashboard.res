@val external window: {..} = "window"

let signOut = () => {
  window["location"]["href"] = "http://127.0.0.1:4433/self-service/browser/flows/logout";
}

@react.component
let make = () => {
  let ( identity, setIdentity ) = React.useState(_ => None)

  let handleUnauthorized = (err: XHR.errorType) => {
    err -> Js.log
    if err.code === 401 {
      RescriptReactRouter.push(Route.login)
    }
  }

  React.useEffect0(() => {
    XHR.whoami(~onDone=(res) => {
        switch res.error {
          | None => setIdentity(_prev => Some(res.identity))
          | Some(e) => handleUnauthorized(e)
        }
      },
      ~onError=(e) => e->Js.log,
      ())

    None
  });

  <div>
    {
      switch identity {
        | None => React.null
        | Some(i) => {
          <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
            <div className="max-w-md w-full space-y-8">
              <h1 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
                {React.string(`Hello ${i.traits.name.first}!`)}
              </h1>
            </div>
            <div className="mt-8 space-y-6">
              <button className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" onClick={(_event) => signOut()}>{React.string("Sign out")}</button>
            </div>
          </div>
        }
      }
    }
  </div>
}

