import { EthProvider } from "./contexts/EthContext";
import "./App.css";
import Button from "./components/Button";
import Address from "./components/Address";

function App() {
  return (
    <EthProvider>
      <div id="App" >
        <div className="container">
          <Address/>
          <hr />
          <Button />
        </div>
      </div>
    </EthProvider>
  );
}

export default App;
