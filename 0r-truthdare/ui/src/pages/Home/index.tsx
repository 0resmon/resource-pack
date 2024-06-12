import "./index.sass";
import { useEffect } from "react";
import { useVisibility } from "../../hooks/useVisibility";
import { fetchNui } from "../../utils/fetchNui";
import useData from "../../hooks/useData";
import { Categories, TaskCards, TaskType } from "../../components/Home";
import classNames from "classnames";

export const Home: React.FC = () => {
  const { visible, setVisible } = useVisibility();
  const { SelectedCategory, SelectedTask, SelectedTaskType, theme } = useData();

  useEffect(() => {
    if (!visible) return;
    const keyHandler = (e: KeyboardEvent) => {
      if (["Escape"].includes(e.code)) {
        fetchNui("nui:hideFrame", true, true);
        setVisible(false);
      }
    };
    window.addEventListener("keydown", keyHandler);
    return () => window.removeEventListener("keydown", keyHandler);
  }, [visible, setVisible]);

  return (
    <div className={classNames("w-full h-full", theme)}>
      <>{!SelectedCategory && <Categories />}</>
      <>{SelectedCategory && !SelectedTaskType && <TaskType />}</>
      <>
        {SelectedCategory && SelectedTaskType && SelectedTask && <TaskCards />}
      </>
    </div>
  );
};
