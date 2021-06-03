let shouldShowLabel = (t) => t !== "hidden"

module NonStandardProps = {
  @react.component
  let make = (~props, ~children) => React.cloneElement(children, props)
}

let defaultClasses = "appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
let submitClasses = "group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"

module InputField = {
  @react.component
  let make = (~attributes: Kratos.uiNodeInputAttributes) => switch attributes.\"type" {
    | "submit" => <button
          className={submitClasses}
          name={attributes.name}
          value={attributes.value -> Belt.Option.getWithDefault("")}
          placeholder={attributes.name}
          type_={attributes.\"type"}
          required={attributes.required -> Belt.Option.getWithDefault(false)}>
          {React.string("Submit")}
          </button>
    | _ => <input
          className={defaultClasses}
          name={attributes.name}
          defaultValue={attributes.value -> Belt.Option.getWithDefault("")}
          placeholder={attributes.name}
          type_={attributes.\"type"}
          required={attributes.required -> Belt.Option.getWithDefault(false)}/>
  }
}

@react.component
let make = (~attributes: Kratos.uiNodeInputAttributes) => <>
    {
      switch shouldShowLabel(attributes.\"type") {
        | false => React.null
        | true => {
          <NonStandardProps props={"data-testid": "label"}>
            <label key={attributes.name} className="sr-only" >
              {React.string(attributes.name)}
            </label>
          </NonStandardProps>
        }
      }
    }
    <InputField attributes={attributes} />
</>
