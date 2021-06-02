@react.component
let make = () => {
  let ( identity, setIdentity ) = React.useState(_ => None)

  React.useEffect0(() => {
    XHR.whoami(~onDone=(res) => setIdentity(_prev => Some(res.identity)), ~onError=(err) => Js.log(err), ())

    None
  });

  {
    switch identity {
      | None => React.null
      | Some(i) => <h1>{React.string(`Hello ${i.traits.name.first}!`)}</h1>
    }
  }
}

