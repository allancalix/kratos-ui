open Jest
open JestDom

describe("DynamicInputComponent", () => {
    open ReactTestingLibrary

    let attrs: Kratos.uiNodeInputAttributes = {
      name: "password",
      required: Some(true),
      \"type": "password",
      value: None,
      disabled: false,
      pattern: None,
      label: None,
    }

    let node: Kratos.uiNode = {
      attributes: attrs,
      group: "password",
      message: [],
      meta: {
        label: None
      },
      \"type": "input",
    }

    let label: Kratos.uiText = {
      context: None,
      id: 10,
      text: "Cool Label",
      \"type": "info",
    }

    let metaWithLabel: Kratos.meta = {
      label: Some(label),
    }

    test("when label is provided then matches expected", () =>
      <DynamicInput node={{...node, meta: metaWithLabel}} />
        -> render
        |> container
        |> Expect.expect
        |> Expect.toMatchSnapshot
    )

    test("when no label is provided then matches snapshot", () =>
      <DynamicInput node={node} />
        -> render
        |> container
        |> Expect.expect
        |> Expect.toMatchSnapshot
    )

    test("when label is provided then has visible label", () =>
      <DynamicInput node={{...node, meta: metaWithLabel}} />
        |> render
        |> getByTestId(~matcher=#Str("label"))
        |> expect
        |> toHaveTextContent(#Str("Cool Label"))
    )
})
