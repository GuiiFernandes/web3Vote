import Link from 'next/link';
import { usePathname } from 'next/navigation';

export default function Header() {
  const pathname = usePathname();
  return (
    <header className="w-full flex justify-center py-2 fixed top-0">
      <nav className="flex gap-4 items-center max-w-[600px] w-[80%] justify-end">
        <Link
          href="/"
          className={ `${pathname === '/' ? 'active' : ''} nav-link` }
        >
          Home
        </Link>
        <Link
          href="/about"
          className={ `${pathname === '/about' ? 'active' : ''} nav-link` }
        >
          About
        </Link>
      </nav>
    </header>
  );
}
