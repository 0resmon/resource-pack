export type PageTypes = string;

export type RouterProviderProps = {
  router: PageTypes;
  setRouter: (router: PageTypes) => void;
  page: React.ReactNode;
};
