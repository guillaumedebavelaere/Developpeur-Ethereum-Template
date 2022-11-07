import { useRef, useEffect, useState } from "react";
import { useEth } from "../../contexts/EthContext";

function Contract({ value, greeter }) {
  const spanEle = useRef(null);
  const [oldEvents, setOldEvents] = useState();
  const [eventValue, setEventValue] = useState();
  const { state: { contract } } = useEth();

  useEffect(() => {
    (async function () {

      let oldEvents = await contract.getPastEvents('ValueChanged', {
        fromBlock: 0,
        toBlock: 'latest'
      });
      
      let oldies = [];
      oldEvents.forEach(event => {
        oldies.push(event.returnValues.value);
      });
      setOldEvents(oldies);

      await contract.events.ValueChanged({ fromBlock: "earliest" })
        .on('data', event => {
          console.log("Events " + event);
          let lesevents = event.returnValues.value;
          setEventValue(lesevents);
        })
        .on('changed', changed => console.log(changed))
        .on('error', err => console.log(err))
        .on('connected', str => console.log(str))
    })();
  }, [contract])

  return (
    <code>
      {`contract SimpleStorage {
  uint256 value = `}

      <span className="secondary-color" ref={spanEle}>
        <strong>{value}</strong>
      </span>

      {`;
      string greeter = `}
      <span className="secondary-color" ref={spanEle}>
        <strong>{greeter}</strong>
      </span>
      {`

function read() public view returns (uint256) {
  return value;
}

function write(uint256 newValue) public {
  value = newValue;
}
}

Events arriving: `} {eventValue} {`

Old events: `} {oldEvents}
    </code>
  );
}

export default Contract;
