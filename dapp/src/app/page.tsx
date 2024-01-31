/* eslint-disable max-len */

'use client';

import Head from 'next/head';
import Footer from './components/Footer';
import Header from './components/Header';

export default function Home() {
  const onLogin = () => {
    console.log('Login');
  };

  return (
    <>
      <Head>
        <title>Web3 Vote | Login</title>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Head>
      <Header />
      <main className="w-[95%] flex justify-center">
        <form className="max-w-[600px] flex flex-col justify-center gap-10" onSubmit={ onLogin }>
          <h1 className="text-5xl font-bold">
            Web3 Vote
          </h1>
          <p>
            Sistema de votação para simular uma urna eletrônica. Entre com sua carteira MetaMask, escolha uma eleição e vote.
          </p>
          <button className="btn-login">
            <img src="/Metamask-icon.svg" alt="metamask logo" className="w-12 h-12" />
            Conectar com MetaMask
          </button>
        </form>
      </main>
      <Footer />
    </>
  );
}
