import { createContext, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { LocaleContextProps, LocaleProps } from "../types/LocaleProviderTypes";
import { debugData } from "../utils/debugData";

debugData([
  {
    action: "ui:setLocale",
    data: {
      text_truth: "Truth",
      desc_truth: "The questions will be about truth.",
      text_dare: "Dare",
      desc_dare: "The questions will be about dare.",
    },
  },
]);

export const LocaleCtx = createContext<LocaleContextProps>(
  {} as LocaleContextProps
);

export const LocaleProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [locale, setLocale] = useState<LocaleProps>({} as LocaleProps);

  useNuiEvent("ui:setLocale", async (data: LocaleProps) => setLocale(data));

  const value = {
    locale,
    setLocale,
  };

  return <LocaleCtx.Provider value={value}>{children}</LocaleCtx.Provider>;
};

export default LocaleProvider;
