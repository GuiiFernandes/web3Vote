import { setCookie } from 'typescript-cookie';

type Props = {
  setAcceptCookies: (value: boolean) => void;
};

export default function PopUp({ setAcceptCookies }: Props) {
  return (
    <div className="absolute w-full h-full flex-center bg-black/60">
      <div
        className={ 'bg-gray-200 w-80 h-80 rounded-3xl '
        + 'flex-center flex-col gap-6 text-black p-8' }
      >
        <p className="text-center">Este site precisa de cookies para funcionar</p>
        <button
          onClick={ () => {
            setAcceptCookies(true);
            setCookie('web3Vote', true, { expires: 365 });
          } }
          className="btn-login text-white m-0"
        >
          Eu aceito os cookies
        </button>
      </div>
    </div>
  );
}
