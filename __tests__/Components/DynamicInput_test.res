open Jest

describe("DynamicInputComponent", () => {
    open Expect
    open ReactTestingLibrary

    let field: Kratos.inputField = {
      name: "password",
      required: true,
      \"type": "password",
      value: "",
    }

    test("snapshot to match expected", () =>
      <DynamicInput field={field} />
        -> render
        |> container
        |> expect
        |> toMatchSnapshot
    )

    test("snapshot to match expected", () =>
      <DynamicInput field={{...field, \"type": "hidden"}} />
        -> render
        |> container
        |> expect
        |> toMatchSnapshot
    )
})
