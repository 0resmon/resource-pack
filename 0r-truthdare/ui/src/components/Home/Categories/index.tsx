import { RxCross1 } from "react-icons/rx";
import { categoryColors } from "../../../utils/misc";
import useData from "../../../hooks/useData";
import classNames from "classnames";
import { useEffect, useState } from "react";
import { TypeSC } from "../../../types/BasicTypes";
import { useVisibility } from "../../../hooks/useVisibility";

const Categories = () => {
  const { visible } = useVisibility();
  const { QuestionCategories, onSelectCategory, onClickClearTaskCategory } =
    useData();
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    if (!visible) return;
    setIsVisible(true);
    return () => {
      setIsVisible(false);
    };
  }, [visible]);

  const handleClickCategorySelect = (
    e: React.MouseEvent<HTMLButtonElement>,
    data: TypeSC
  ) => {
    e.preventDefault();
    onSelectCategory(data);
  };

  return (
    <div className="relative w-full h-full">
      <div
        className={classNames(
          "absolute bottom-12 right-12 transition-transform duration-500",
          {
            "transform translate-y-0": isVisible,
            "transform translate-y-full": !isVisible,
          }
        )}
      >
        <div className="w-[22rem] h-[520px] bg-white dark:bg-111111 shadow-2xl rounded-xl">
          <div className="relative w-full h-full">
            <div
              id="header"
              className="w-full flex items-center justify-between py-4 px-6 absolute h-[60px] border-b border-black/10 dark:border-white/10 bg-white dark:bg-111111 rounded-t-xl"
            >
              <h1 className="text-F156A1 font-semibold text-lg">
                Truth or Dare
              </h1>
              <button
                onClick={onClickClearTaskCategory}
                className="border p-1.5 rounded-full relative border-F156A1"
              >
                <RxCross1 className="text-F156A1" />
              </button>
            </div>
            <div className="w-full h-full overflow-auto scrollbar-hide">
              <div className="mt-[60px] p-6">
                <div className="flex flex-col gap-3">
                  {QuestionCategories.map((data, index) => (
                    <div className="w-full h-12" key={index}>
                      <div className="flex items-center w-full h-full gap-3">
                        <div
                          className="w-12 h-12 min-w-12 min-h-12 rounded-xl flex items-center justify-center"
                          style={{
                            backgroundColor:
                              categoryColors[index % categoryColors.length],
                          }}
                        >
                          <img
                            className="w-6 h-6"
                            src={`images/icons/${data.icon}`}
                            alt="icon"
                          />
                        </div>
                        <div className="w-full overflow-hidden">
                          <div className="flex items-center gap-1">
                            <h1 className="text-111111 dark:text-white font-medium whitespace-nowrap text-ellipsis overflow-hidden">
                              {data.label}
                            </h1>
                            {data.isAdult && (
                              <img
                                className="w-4"
                                src="images/icons/18.png"
                                alt="adult"
                              />
                            )}
                          </div>
                          <h1 className="text-111111/80 dark:text-white/80 whitespace-nowrap text-ellipsis overflow-hidden">
                            {data.description}
                          </h1>
                        </div>
                        <button
                          onClick={(e) => handleClickCategorySelect(e, data)}
                          className="py-1 px-4 rounded-3xl bg-white dark:bg-111111 border-2 border-F156A1 hover:bg-F156A1 text-F156A1 hover:text-white"
                        >
                          Select
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Categories;
