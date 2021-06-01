switch ReactDOM.querySelector("#root"){
  | None => ()
  | Some(element) =>
    ReactDOM.render(<App/>,element)
}
