@react.component
let make = (~nodes: array<Kratos.uiNode>) =>
  React.array(nodes->Js.Array2.map((node) => {
    switch node.\"type" {
    | "input" => <DynamicInput node={node} />
    | _ => React.null
    }
  }))
