"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { MagnifyingGlassIcon } from "@heroicons/react/24/outline";

export const SearchBar = () => {
  const [searchTerm, setSearchTerm] = useState("");
  const router = useRouter();

  const handleSearch = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      e.preventDefault();
      router.push(searchTerm ? `/explore?query=${searchTerm}` : "/explore");
    }
  };

  return (
    <form className="lg:flex hidden">
      <div className="relative flex items-center">
        <MagnifyingGlassIcon className="w-6 h-6 absolute ml-2 text-secondary" />
        <input
          type="search"
          onChange={e => setSearchTerm(e.target.value)}
          onKeyDown={handleSearch}
          className="block text-accent w-80 p-1.5 ps-10 text-sm rounded-lg outline-none border-secondary border transition duration-300 placeholder:focus:opacity-40 placeholder:text-secondary"
          placeholder="Search by owner`s address or token ID"
        ></input>
      </div>
    </form>
  );
};
