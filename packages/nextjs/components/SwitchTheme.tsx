"use client";

import { useEffect, useState } from "react";
import { useTheme } from "next-themes";
import { MoonIcon, SunIcon } from "@heroicons/react/24/outline";

export const SwitchTheme = ({ className }: { className?: string }) => {
  const { setTheme, resolvedTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  const isDarkMode = resolvedTheme === "dark";

  const handleToggle = () => {
    if (isDarkMode) {
      setTheme("light");
      return;
    }
    setTheme("dark");
  };

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) return null;

  return (
    <div className={`relative flex space-x-2 h-8 items-center justify-center text-sm ${className}`}>
      <input
        id="theme-toggle"
        type="checkbox"
        className="toggle toggle-secondary hover:bg-accent border-primary"
        onChange={handleToggle}
        checked={isDarkMode}
      />
      <label htmlFor="theme-toggle" className={`absolute swap swap-rotate ${!isDarkMode ? "swap-active" : ""}`}>
        <SunIcon className="swap-on h-3 w-3 -translate-x-4" />
        <MoonIcon className="swap-off h-3 w-3 translate-x-2" />
      </label>
    </div>
  );
};
