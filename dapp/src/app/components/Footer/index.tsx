/* eslint-disable jsx-a11y/control-has-associated-label */
import { FaGithub, FaLinkedinIn } from 'react-icons/fa';
import { HiHome } from 'react-icons/hi';

export default function Footer() {
  return (
    <footer className="text-center fixed bottom-0 w-full">
      <p className="flex-center gap-2 py-4 border-t-[1px] border-[rgba(255,255,255,0.1)]">
        &copy; 2024
        {' '}
        <strong>Gui Fernandes</strong>
        <a
          href="https://github.com/GuiiFernandes"
          target="_blank"
          rel="noopener noreferrer"
          className="hover:text-green-400"
        >
          <FaGithub size="20px" />
        </a>
        <a
          href="https://www.linkedin.com/in/guifernandesdev/"
          target="_blank"
          rel="noopener noreferrer"
          className="hover:text-green-400"
        >
          <FaLinkedinIn size="20px" />
        </a>
        <a
          href="https://guiifernandes.github.io/"
          target="_blank"
          rel="noopener noreferrer"
          className="hover:text-green-400"
        >
          <HiHome size="20px" />
        </a>
      </p>
    </footer>
  );
}
