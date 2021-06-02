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
      RescriptReactRouter.push("/login")
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
          <div>
            <header>
              <button onClick={(_event) => signOut()}>{React.string("Sign out")}</button>
            </header>
            <h1>{React.string(`Hello ${i.traits.name.first}!`)}</h1>
          </div>
        }
      }
    }
  </div>
}

