@react.component
let make = (~nodes: array<Kratos.uiNode>) =>
  React.array(
    nodes->Js.Array2.map(node => {
      switch node->Kratos.parseAttrs {
      | Kratos.UiNodeInputAttributes(attrs) =>
        <DynamicInput
          name={attrs.name}
          \"type"={attrs.\"type"}
          label=?node.meta.label
          value=?attrs.value
          required={attrs.required->Belt.Option.getWithDefault(false)}
        />
      | _ => React.null
      }
    }),
  )
