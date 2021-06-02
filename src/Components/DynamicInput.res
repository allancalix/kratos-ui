let shouldShowLabel = (t) => t !== "hidden"

@react.component
let make = (~field: Kratos.inputField) => <>
    {
      switch shouldShowLabel(field.\"type") {
        | false => React.null
        | true => {
          <label key={field.name} className="sr-only">
            {React.string(field.name)}
          </label>
        }
      }
    }
      <input
        className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
        name={field.name}
        defaultValue={field.value}
        placeholder={field.name}
        type_={field.\"type"}
        required={field.required}/>
</>
