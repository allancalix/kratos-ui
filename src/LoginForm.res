@react.component
let make = () => {
  <form>
    <label>
      {React.string("Email")}
      <input type_="text" name="email" />
    </label>
    <label>
      {React.string("Password")}
      <input type_="text" name="password" />
    </label>
    <input type_="submit" value="Submit"/>
  </form>
}
