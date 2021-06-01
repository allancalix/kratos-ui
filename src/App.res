@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
    | list{} => <h1>{React.string("Dashboard Home")}</h1>
    | list{"login"} => <Login/>
    | _ => <NotFound/>
  }
}

