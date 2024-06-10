export type TypeQC = {
  icon: string;
  label: string;
  description: string;
  isAdult?: boolean;
};

export type TypeSC = TypeQC | null;

export type TypeQT = {
  [key: string]: {
    truth: string[];
    dare: string[];
  };
};
