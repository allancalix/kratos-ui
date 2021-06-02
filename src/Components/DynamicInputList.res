@react.component
let make = (~fields: array<Kratos.inputField>) =>
  React.array(fields->Js.Array2.map((field) => {
    <DynamicInput field={field} />
  }))
