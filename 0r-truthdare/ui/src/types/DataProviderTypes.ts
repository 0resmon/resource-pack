import { TypeQC, TypeQT, TypeSC } from "./BasicTypes";

export type DataContextProps = {
  theme: "light" | "dark";
  QuestionCategories: TypeQC[];
  CategoryTasks: TypeQT;
  SelectedCategory: TypeSC;
  SelectedTaskType: "truth" | "dare" | null;
  SelectedTask: string | null;
  onSelectCategory: (category: TypeSC) => void;
  onSelectTaskType: (type: "truth" | "dare") => void;
  onClickClearTaskCategory: () => void;
};
