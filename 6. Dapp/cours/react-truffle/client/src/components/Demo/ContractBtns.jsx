import { useState } from "react";
import useEth from "../../contexts/EthContext/useEth";

function ContractBtns({ setValue, setGreeter }) {
  const { state: { contract, accounts } } = useEth();
  const [inputValue, setInputValue] = useState("");
  const [inputGreeter, setInputGreeter] = useState("");

  const handleInputChange = e => {
    if (/^\d+$|^$/.test(e.target.value)) {
      setInputValue(e.target.value);
    }
  };

  const read = async () => {
    const value = await contract.methods.read().call({ from: accounts[0] });
    setValue(value);
  };

  const write = async e => {
    if (e.target.tagName === "INPUT") {
      return;
    }
    if (inputValue === "") {
      alert("Please enter a value to write.");
      return;
    }
    const newValue = parseInt(inputValue);
    await contract.methods.write(newValue).send({ from: accounts[0] });
  };

  const handleInputGreeterChange = e => {
    if (/[A-z]+/.test(e.target.value)) {
      setInputGreeter(e.target.value);
    }
  };

  const greeter = async () => {
    const value = await contract.methods.greeter().call({ from: accounts[0] });
    setGreeter(value);
  };

  const updateGreeter = async e => {
    if (e.target.tagName === "INPUT") {
      return;
    }
    if (inputGreeter === "") {
      alert("Please enter a value to greeter.");
      return;
    }
    const newValue = inputGreeter;
    await contract.methods.setGreeter(newValue).send({ from: accounts[0] });
  };

  return (
    <div className="btns">

      <button onClick={read}>
        read()
      </button>

      <div onClick={write} className="input-btn">
        write(<input
          type="text"
          placeholder="uint"
          value={inputValue}
          onChange={handleInputChange}
        />)
      </div>

      <button onClick={greeter}>
        getGreeter()
      </button>

      <div onClick={updateGreeter} className="input-btn">
        setGreeter(<input
          type="text"
          placeholder="string"
          value={inputGreeter}
          onChange={handleInputGreeterChange}
        />)
      </div>

    </div>
  );
}

export default ContractBtns;
