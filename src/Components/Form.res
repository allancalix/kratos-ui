@react.component
let make = (
  ~method: Kratos.supportedMethod,
  ~submitButtonLabel: string,
  ~children: React.element=React.null) =>
        <form className="mt-8 space-y-6" action={method.config.action} method={method.config.method}>
          <div className="mt-8 space-y-6">
            <DynamicInputList fields={method.config.fields}/>
          </div>
          <div className="flex items-center justify-between">
            <div className="text-sm">
              children
            </div>
          </div>
          <div>
            <button type_="submit" className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              {React.string(submitButtonLabel)}
            </button>
        </div>
      </form>
