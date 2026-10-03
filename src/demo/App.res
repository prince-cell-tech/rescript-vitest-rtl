@react.component
let make = () => {
  let (count, setCount) = React.useState(() => 0)
  let (name, setName) = React.useState(() => "")

  <div>
    <h1 dataTestId="app-heading" className="title"> {"ReScript + Vite + React"->React.string} </h1>
    <button onClick={_ => setCount(count => count + 1)}>
      {React.string(`count is ${count->Int.toString}`)}
    </button>
    <button onClick={_ => setCount(_ => 0)}> {"Reset"->React.string} </button>
    <div>
      <label htmlFor="name-input"> {"Name"->React.string} </label>
      <input
        id="name-input"
        placeholder="Type your name"
        value={name}
        onChange={e => setName(_ => ReactEvent.Form.target(e)["value"])}
      />
      <p> {React.string(`Hello, ${name}`)} </p>
    </div>
    <button disabled={name->String.trim == ""}> {"Submit"->React.string} </button>
    <p> {"Edit src/demo/App.res and save to test Fast Refresh."->React.string} </p>
  </div>
}
