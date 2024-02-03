import { setCookie } from 'typescript-cookie';
import Web3 from 'web3';

export const doLogin = async () => {
  if (!('ethereum' in window)) throw new Error('Carteira MetaMask não encontrada');
  const web3 = new Web3(window.ethereum as string);
  const accounts = await web3.eth.requestAccounts();
  if (!accounts.length) throw new Error('Carteira não encontrada/permitida');

  setCookie('user', accounts[0], { expires: 365 });
  return accounts[0];
};
