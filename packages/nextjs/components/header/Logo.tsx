import Image from "next/image";
import Link from "next/link";
import { useGlobalState } from "~~/services/store/store";

const Logo = () => {
  const { color_1 } = useGlobalState();
  return (
    <Link href="/" passHref className="hidden lg:flex items-center gap-2 ml-4 mr-6 shrink-0">
      <div className="flex relative w-10 h-10">
        <Image alt="logo" className="cursor-pointer" fill src="/logo.png" />
      </div>
      <div className="flex flex-col" style={{ color: color_1 }}>
        <span className="font-bold leading-tight">Forgotten Lands</span>
        <span className="text-xs">NFT Collection</span>
      </div>
    </Link>
  );
};

export default Logo;
