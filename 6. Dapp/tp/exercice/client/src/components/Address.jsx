import { useEffect, useState } from "react";
import useEth from "../contexts/EthContext/useEth";

function Address() {
    const { state: { contract, accounts, web3 } } = useEth();
    const [balance, setBalance] = useState(0);

    useEffect(() => {
        (async () => {
            if (accounts != undefined) {
                const balance = await contract.methods.balanceOf(accounts[0]).call();
                setBalance(web3.utils.fromWei(balance));
            }
        })();
    }, [contract]);

    const displayBalance = () => {
        return <>
            {balance} MTR
        </>
    } 

    return <>
        Connected Address: {accounts != undefined ? accounts[0] : 0} {balance > 0 && displayBalance}
    </>
}

export default Address;