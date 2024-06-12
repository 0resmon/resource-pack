import { useContext } from "react";
import { LocaleCtx } from "../providers/LocaleProvider";

const useLocales = () => {
  const localeContext = useContext(LocaleCtx);
  return localeContext;
};

export default useLocales;
