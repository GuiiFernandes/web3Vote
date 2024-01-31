'use client';

import Head from 'next/head';

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
      <main>
        <form className="m-w-[95%]" onSubmit={ onLogin }>
          <h1>Web3 Vote</h1>
          <button className="btn-login">
            Entrar com Metamask
            <img src="/Metamask-icon.svg" alt="metamask logo" className="w-10 h-10" />
          </button>
        </form>
      </main>
    </>
  );
}
