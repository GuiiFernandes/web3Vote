/* eslint-disable react-hooks/exhaustive-deps */

'use client';

import { useEffect, useState } from 'react';
import Head from 'next/head';
import { getCookie } from 'typescript-cookie';

import Footer from './components/Footer';
import Header from './components/Header';
import FormLogin from './components/FormLogin';
import PopUp from './components/PopUp';

export default function Home() {
  const [acceptCookies, setAcceptCookies] = useState<boolean>(false);
  useEffect(() => {
    if (acceptCookies) return;
    const accept = !!getCookie('web3Vote');
    setAcceptCookies(accept);
  }, []);

  return (
    <>
      <Head>
        <title>Web3 Vote | Login</title>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Head>
      <Header />
      <main className="w-[95%] flex justify-center">
        <FormLogin />
      </main>
      <Footer />
      { !acceptCookies && <PopUp setAcceptCookies={ setAcceptCookies } />}
    </>
  );
}
