import React from "react";
import Image from "next/image";
import Link from "next/link";
import { hardhat } from "viem/chains";
import { CurrencyDollarIcon } from "@heroicons/react/24/outline";
import { SwitchTheme } from "~~/components/SwitchTheme";
import { useTargetNetwork } from "~~/hooks/scaffold-eth/useTargetNetwork";
import { useGlobalState } from "~~/services/store/store";

/**
 * Site footer
 */
export const Footer = () => {
  const nativeCurrencyPrice = useGlobalState(state => state.nativeCurrencyPrice);
  const { targetNetwork } = useTargetNetwork();
  const isLocalNetwork = targetNetwork.id === hardhat.id;

  return (
    <div className="min-h-0 py-5 px-1 mb-11 lg:mb-0">
      <div className="flex flex-row justify-between mx-5">
        <div className="flex gap-4 items-center">
          <Image className="h-9 w-9" src="./logo.png" alt="ForgottenLands" />
          <span className="font-semibold text-lg tracking-tight text-secondary">Forgotten Lands</span>
        </div>
        <div className="font-semibold text-lg tracking-tight text-accent">
          <span>Collection was created and is being maintained by: </span>
          <Link href="https://www.linkedin.com/in/ivan-oberemok/" target="_blank">
            @YaTut1901
          </Link>
        </div>
      </div>
      <div className="fixed flex justify-between items-center w-full z-10 p-4 bottom-0 left-0 pointer-events-none">
        <div className="flex flex-col md:flex-row gap-2 pointer-events-auto">
          {nativeCurrencyPrice > 0 && (
            <div className="btn btn-primary text-secondary border border-secondary hover:border-accent hover:text-accent btn-sm font-normal gap-1 cursor-auto">
              <CurrencyDollarIcon className="h-4 w-4" />
              <span>{nativeCurrencyPrice.toFixed(2)}</span>
            </div>
          )}
        </div>
        <SwitchTheme className={`pointer-events-auto text-primary ${isLocalNetwork ? "self-end md:self-auto" : ""}`} />
      </div>
    </div>
  );
};
