import Web3 from 'web3';

let web3;

if (typeof window !== 'undefined' && typeof window.web3 !== 'undefined') {
  // We are in the browser and Metamask is running
  web3 = new Web3(window.web3.currentProvider);
} else {
  // We are on the server or the user is not running Metamask
  // Will setup our own provider that o Rinkeby network through Infura

  const provider = new Web3.providers.HttpProvider(
    'https://rinkeby.infura.io/v3/c58307de419b44e2a42cd272d47a08e3'
  );

  web3 = new Web3(provider);
}

export default web3;
