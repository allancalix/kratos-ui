module NonStandardProps = {
  @react.component
  let make = (~props, ~children) => React.cloneElement(children, props)
}

let defaultClasses = "appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
let submitClasses = "group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"

module InputField = {
  @react.component
  let make = (~attributes: Kratos.uiNodeInputAttributes, ~placeholder: string="", ~submitButtonLabel=?) => switch attributes.\"type" {
    | "submit" => <button
          className={submitClasses}
          name={attributes.name}
          value={attributes.value -> Belt.Option.getWithDefault("")}
          placeholder={placeholder}
          type_={attributes.\"type"}
          required={attributes.required -> Belt.Option.getWithDefault(false)}>
          {React.string(submitButtonLabel -> Belt.Option.getWithDefault("Submit"))}
          </button>
    | _ => <input
          className={defaultClasses}
          name={attributes.name}
          defaultValue={attributes.value -> Belt.Option.getWithDefault("")}
          placeholder={placeholder}
          type_={attributes.\"type"}
          required={attributes.required -> Belt.Option.getWithDefault(false)}/>
  }
}

@react.component
let make = (~node: Kratos.uiNode) => switch node.meta.label {
  | Some(label) => {
    <>
      <NonStandardProps props={"data-testid": "label"}>
        <label key={Js.Int.toString(label.id)} className="sr-only">
          {React.string(label.text)}
        </label>
      </NonStandardProps>
      <InputField attributes={node.attributes} placeholder={label.text} submitButtonLabel={label.text} />
    </>
  }
  | None => <InputField attributes={node.attributes} />
}
