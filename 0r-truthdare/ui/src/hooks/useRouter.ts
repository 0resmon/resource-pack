import { useContext } from "react";
import { RouterCtx } from "../providers/RouterProvider";
import { RouterProviderProps } from "../types/RouterProviderTypes";

const useRouter = (): RouterProviderProps => {
  const routerContext = useContext(RouterCtx);
  return routerContext;
};

export default useRouter;
