"use client";

import Image from "next/image";
import darkBanner from "../asset/dark-homepage-banner.jpeg";
import lightBanner from "../asset/light-homepage-banner.jpg";
import type { NextPage } from "next";
import { useTheme } from "next-themes";

const Home: NextPage = () => {
  const { resolvedTheme } = useTheme();
  const homepageBanner = resolvedTheme === "dark" ? darkBanner : lightBanner;

  if (!resolvedTheme) {
    return <></>;
  }

  return (
    <>
      <div className="relative h-[600px]">
        <Image
          src={homepageBanner}
          alt="homepageBanner"
          className="absolute object-cover w-full h-full object-[0,10%]"
        />
        <div className="absolute h-full w-full bg-gradient-to-b from-transparent via-secondary/30 to-accent/60 backdrop-blur-md"></div>
        <div className="absolute flex flex-col justify-between w-full h-full">
          <div className="w-full flex-grow flex flex-col gap-2 items-center justify-center text-5xl whitespace-nowrap text-white font-semibold p-10 drop-shadow-[0_3px_3px_rgba(0,0,0,0.8)]">
            <div>Unveil the Mysteries, Own the Forgotten.</div>
            <div className="text-3xl">Discover the untold stories, one NFT at a time.</div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Home;
