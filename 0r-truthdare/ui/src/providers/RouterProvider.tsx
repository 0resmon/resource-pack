import React, { createContext, useEffect, useMemo, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { PageTypes, RouterProviderProps } from "../types/RouterProviderTypes";
import { Home } from "../pages/Home";

export const RouterCtx = createContext<RouterProviderProps>(
  {} as RouterProviderProps
);

export const RouterProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [router, setRouter] = useState<PageTypes>("home");
  const [page, setPage] = useState<React.ReactNode | null>(null);

  useNuiEvent("ui:setRouter", setRouter);

  useEffect(() => {
    if (router == "home") setPage(<Home />);
    else setPage(<Home />);
  }, [router]);

  const value = useMemo(() => {
    return {
      router,
      setRouter,
      page,
    };
  }, [router, page]);

  return <RouterCtx.Provider value={value}>{children}</RouterCtx.Provider>;
};

export default RouterProvider;
