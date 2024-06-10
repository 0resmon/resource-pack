import { useContext } from "react";
import { DataCtx } from "../providers/DataProvider";

const useData = () => {
  const dataContext = useContext(DataCtx);
  return dataContext;
};

export default useData;
