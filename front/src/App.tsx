import './App.css'

function App() {

  return (
    <>
      <h1>{import.meta.env.VITE_APP_NAME ?? "Application"}</h1>
    </>
  )
}

export default App
