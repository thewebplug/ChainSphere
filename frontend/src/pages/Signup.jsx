import Web3 from "web3";
import Web3Modal from "web3modal";
import {useNavigate} from 'react-router-dom';
import { createWeb3Modal, defaultConfig } from "@web3modal/ethers/react";
import { useWeb3Modal } from "@web3modal/ethers/react";
import {
  useWeb3ModalProvider,
  useWeb3ModalAccount,
} from "@web3modal/ethers/react";
import { BrowserProvider, Contract, formatUnits } from "ethers";
import { useEffect } from "react";


export default function Signup() {
  const navigate = useNavigate();

  const projectId = "14f5df1eed8d25d690e259ace4b1f2ca";

  const mainnet = {
    chainId: 1,
    name: "Ethereum",
    currency: "ETH",
    explorerUrl: "https://etherscan.io",
    rpcUrl: "https://cloudflare-eth.com",
  };

  const metadata = {
    name: "My Website",
    description: "My Website description",
    url: "https://chainsphere.netlify.app",
    icons: ["https://avatars.mywebsite.com/"],
  };

  const ethersConfig = defaultConfig({
    metadata,
    enableEIP6963: true,
    enableInjected: true,
    enableCoinbase: true,
    rpcUrl: "...",
    defaultChainId: 1,
  });

  createWeb3Modal({
    ethersConfig,
    chains: [mainnet],
    projectId,
    enableAnalytics: true, // Optional - defaults to your Cloud configuration
  });

  const { open } = useWeb3Modal();

  const { address, chainId, isConnected } = useWeb3ModalAccount();
  const { walletProvider } = useWeb3ModalProvider();



  useEffect(() => {
    if (address) {
      console.log('address', address);
    }
  }, [address]);
   
    return (
      <main className="auth">
        <div className="auth__card1">
          <div className="auth__card1__logo">
            Chainsphere Logo
          </div>
  
          <h1 className="auth__card1__title">Let’s sign you up!</h1>
  
          <div className="auth__card1__form">
            <input
              type="text"
              className="auth__card1__form__input"
              placeholder="Enter Full Name"
            />
            <input
              type="email"
              className="auth__card1__form__input"
              placeholder="Email"
            />
            <input
              type="text"
              className="auth__card1__form__input"
              placeholder="username"
            />

<div className="auth__card1__form__input-group">
  <input type="text" className="auth__card1__form__input-group__input" value={address} />
  <button className="auth__card1__form__input-group__button"
 onClick={() => open()} 
  >Connect wallet</button>
  </div>            
            <input
              type="text"
              className="auth__card1__form__input"
              placeholder="Password"
            />
            <input
              type="text"
              className="auth__card1__form__input"
              placeholder="Confirm Password"
            />
  
           
  
            <button className="auth__card1__form__button">Sign up</button>
  
            <h3 className="auth__card1__form__login">
            Already have an account? <span className="pointer" onClick={() => navigate("/login")}>Login</span>
            </h3>
          </div>
        </div>
        <div className="auth__card2">
        <div className="auth__card2__carousel">
        <h2 className="auth__card2__carousel__title">
        Experiencing the World of Decentralized social media with <br /> <span>Chainsphere</span>
          </h2>
      
  
  </div>
        </div>
      </main>
    );
  }
  