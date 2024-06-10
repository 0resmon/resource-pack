import { RxCross1 } from "react-icons/rx";
import useLocales from "../../../hooks/useLocales";
import useData from "../../../hooks/useData";
import { useEffect, useState } from "react";
import classNames from "classnames";
import { GiLion } from "react-icons/gi";
import { IoShieldCheckmarkSharp } from "react-icons/io5";

const TaskType = () => {
  const { onClickClearTaskCategory, onSelectTaskType } = useData();
  const { locale } = useLocales();
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    setIsVisible(true);
  }, []);

  const onClickCross = (e: React.MouseEvent<HTMLButtonElement>) => {
    e.preventDefault();
    onClickClearTaskCategory();
  };

  const divClasses = classNames(
    "absolute",
    "top-0",
    "left-0",
    "w-full",
    "h-full",
    "flex",
    "items-center",
    "justify-center",
    "bg-black/30",
    "transition-opacity",
    "duration-500",
    {
      "opacity-100": isVisible,
      "opacity-0": !isVisible,
    }
  );

  return (
    <>
      <div className="relative w-full h-full">
        <div className={divClasses}>
          <div>
            <div className="grid grid-flow-col gap-8 relative">
              <div className="flex flex-col gap-3 items-center justify-center bg-white/90 dark:bg-111111/90 rounded-3xl w-[242px] h-[300px] p-2">
                <div className="bg-3AD78E w-20 h-20 flex items-center justify-center rounded-2xl border-8 border-black/10 dark:border-black/40">
                  <IoShieldCheckmarkSharp className="w-full h-full p-3" />
                </div>
                <div className="text-center flex flex-col items-center justify-center">
                  <h1 className="first-letter:uppercase font-bold text-lg text-3AD78E">
                    {locale.text_truth}
                  </h1>
                  <h1 className="w-4/5 text-sm text-111B3B/50 dark:text-white/70">
                    {locale.desc_truth}
                  </h1>
                </div>
                <div>
                  <button
                    onClick={() => onSelectTaskType("truth")}
                    className="text-center bg-3AD78E p-1.5 px-10 rounded-3xl"
                  >
                    <h1 className="uppercase">{locale.text_truth}</h1>
                  </button>
                </div>
              </div>
              <div className="flex flex-col gap-3 items-center justify-center bg-white/90 dark:bg-111111/90 rounded-3xl w-[242px] h-[300px] p-2">
                <div className="bg-FF5151 w-20 h-20 flex items-center justify-center rounded-2xl border-8 border-black/10 dark:border-black/40">
                  <GiLion className="w-full h-full p-3" />
                </div>
                <div className="text-center flex flex-col items-center justify-center text-white">
                  <h1 className="first-letter:uppercase font-bold text-lg text-FF5151">
                    {locale.text_dare}
                  </h1>
                  <h1 className="w-4/5 text-sm text-111B3B/50  dark:text-white/70">
                    {locale.desc_dare}
                  </h1>
                </div>
                <div>
                  <button
                    onClick={() => onSelectTaskType("dare")}
                    className="text-center bg-FF5151 p-1.5 px-10 rounded-3xl"
                  >
                    <h1 className="uppercase">{locale.text_dare}</h1>
                  </button>
                </div>
              </div>
              <>
                <div className="absolute -top-12 -right-12">
                  <button
                    onClick={onClickCross}
                    className="p-1.5 rounded-full relative bg-white/50"
                  >
                    <RxCross1 className="text-111B3B" />
                  </button>
                </div>
              </>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default TaskType;
