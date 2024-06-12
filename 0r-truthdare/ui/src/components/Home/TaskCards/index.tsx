import { RxCross1 } from "react-icons/rx";
import useData from "../../../hooks/useData";

const TaskCards = () => {
  const { SelectedCategory, SelectedTask, onClickClearTaskCategory } =
    useData();

  const onClickCross = (e: React.MouseEvent<HTMLButtonElement>) => {
    e.preventDefault();
    onClickClearTaskCategory();
  };

  return (
    <>
      <div className="absolute right-12 bottom-12 z-10">
        <div className="w-[242px] bg-fef1f7/95 dark:bg-111111/95 px-4 py-12 rounded-3xl relative min-h-[310px]">
          <>
            <div className="absolute w-full h-full bg-F156A1/90 top-1.5 -left-1 -z-10 rounded-3xl rotate-[-7deg]"></div>
            <div className="absolute bottom-0 right-0">
              <img className="w-20" src="images/letter.png" alt="letter" />
            </div>
            <div className="absolute top-2 left-2">
              <img
                className="w-16"
                src="images/little-hearts.png"
                alt="letter"
              />
            </div>
            <div className="absolute top-2 right-2">
              <button
                onClick={onClickCross}
                className="p-1 relative border border-F156A1 rounded-full"
              >
                <RxCross1 className="text-F156A1" />
              </button>
            </div>
          </>
          <>
            <div className="text-center mb-8 mt-4">
              <h1 className="font-bold text-111B3B dark:text-white uppercase overflow-hidden text-ellipsis">
                {SelectedCategory?.label}
              </h1>
            </div>
            <div className="text-center mb-12">
              <h1 className="font-medium text-111B3B dark:text-white">
                {SelectedTask}
              </h1>
            </div>
          </>
        </div>
      </div>
    </>
  );
};

export default TaskCards;
