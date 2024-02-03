'use client';

import { FormEvent, useState } from 'react';
import { useRouter } from 'next/navigation';

import { doLogin } from '../../../services/web3';

const DESCRIPTION = 'Sistema de votação para simular uma urna eletrônica. '
+ 'Entre com sua carteira MetaMask, escolha uma eleição e vote.';

export default function BtnLogin() {
  const { push } = useRouter();
  const [message, setMessage] = useState('');

  const onLogin = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const account = await doLogin();
      setMessage(`Logado com sucesso: ${account}`);
    } catch (error) {
      const err = error as Error;
      setMessage(err.message);
    }
  };

  return (
    <form className="form-login" onSubmit={ onLogin }>
      <h1 className="text-5xl font-bold">
        Web3 Vote
      </h1>
      <p>
        { DESCRIPTION }
      </p>
      <div>
        <button className="btn-login">
          <img src="/Metamask-icon.svg" alt="metamask logo" className="w-12 h-12" />
          Conectar com MetaMask
        </button>
        <p className="text-gray-400 max-w-[400px] w-full m-auto pt-1 pr-1 h-7">
          { message }
        </p>
      </div>
    </form>
  );
}
