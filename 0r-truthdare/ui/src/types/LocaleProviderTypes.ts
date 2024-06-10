export type LocaleProps = {
  [key: string]: string;
};

export type LocaleContextProps = {
  locale: LocaleProps;
  setLocale: (locales: LocaleProps) => void;
};
