import React, { createContext, useState } from "react";
import { DataContextProps } from "../types/DataProviderTypes";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";
import { TypeQC, TypeQT, TypeSC } from "../types/BasicTypes";
import { fetchNui } from "../utils/fetchNui";
import { useVisibility } from "../hooks/useVisibility";

debugData([
  {
    action: "ui:setQuestionCategories",
    data: [
      {
        label: "Star",
        description: "Lorem ipsum dolor sit amet",
        icon: "star.png",
      },
      {
        label: "Fire",
        description: "Lorem ipsum dolor sit amet",
        icon: "fire.png",
        isAdult: true,
      },
      {
        label: "Kiss",
        description: "Lorem ipsum dolor sit amet",
        icon: "kiss.png",
        isAdult: true,
      },
      {
        label: "Couple",
        description: "Lorem ipsum dolor sit amet",
        icon: "couple.png",
      },
      {
        label: "Party",
        description: "Lorem ipsum dolor sit amet",
        icon: "party.png",
      },
      {
        label: "Crazy",
        description: "Lorem ipsum dolor sit amet",
        icon: "crazy.png",
      },
      {
        label: "General",
        description: "Lorem ipsum dolor sit amet",
        icon: "general.png",
      },
    ] as TypeQC[],
  },
]);

debugData([
  {
    action: "ui:setCategoryTasks",
    data: {
      STAR: {
        truth: ["Truth: Name the person you last had a crush on."],
        dare: ["Dare: Name the person you last had a crush on."],
      },
    } as TypeQT,
  },
]);

export const DataCtx = createContext<DataContextProps>({} as DataContextProps);

export const DataProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const { setVisible } = useVisibility();
  const [theme, setTheme] = useState<"dark" | "light">("dark");
  const [QuestionCategories, setQC] = useState<TypeQC[]>([]);
  const [CategoryTasks, setQT] = useState<TypeQT>({});
  const [SelectedCategory, setSC] = useState<TypeSC>(null);
  const [SelectedTaskType, setTT] = useState<"truth" | "dare" | null>(null);
  const [SelectedTask, setST] = useState<string | null>(null);

  useNuiEvent("ui:PlayerChoosesTask", (data) => {
    setSC(data.category);
    setTT(data.type);
    setST(data.task);
    setVisible(true);
    setTimeout(() => {
      setSC(null);
      setTT(null);
      setST(null);
      setVisible(false);
    }, 8000);
  });
  useNuiEvent("ui:setTheme", setTheme);
  useNuiEvent("ui:clearSelects", () => {
    setSC(null);
    setTT(null);
    setST(null);
  });
  useNuiEvent("ui:setQuestionCategories", setQC);
  useNuiEvent("ui:setCategoryTasks", (data) => {
    const _setQT = Object.entries(data).reduce((acc, [key, value]) => {
      const lowercaseKey: string = key.toLowerCase();
      acc[lowercaseKey] = value as any;
      return acc;
    }, {} as TypeQT);
    setQT(_setQT);
  });

  const onSelectCategory = (category: TypeSC) => {
    if (!category) return;
    const _CategoryTasks = CategoryTasks[category.label.toLowerCase()];
    if (!_CategoryTasks) return;
    if (_CategoryTasks.dare.length == 0 || _CategoryTasks.truth.length == 0)
      return;
    setSC(category);
  };

  const SendToPeopleNearby = (category: TypeQC, type: string, task: string) => {
    fetchNui("nui:SendToPeopleNearby", {
      category: category,
      type: type,
      task: task,
    });
  };

  const onSelectTaskType = (type: "truth" | "dare") => {
    const category = SelectedCategory;
    if (!category) return;
    setTT(type);
    const _CategoryTasks = CategoryTasks[category.label.toLowerCase()][type];
    const selectedTask =
      _CategoryTasks[Math.floor(Math.random() * _CategoryTasks.length)];
    setST(selectedTask);
    SendToPeopleNearby(category, type, selectedTask);
  };

  const onClickClearTaskCategory = () => {
    fetchNui("nui:hideFrame");
  };

  const value = {
    theme,
    QuestionCategories,
    CategoryTasks,
    SelectedCategory,
    SelectedTaskType,
    SelectedTask,
    onSelectCategory,
    onSelectTaskType,
    onClickClearTaskCategory,
  };

  return <DataCtx.Provider value={value}>{children}</DataCtx.Provider>;
};
