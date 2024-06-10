import React from "react";
import useRouter from "../hooks/useRouter";

const App: React.FC = () => {
  const { page } = useRouter();
  return <>{page}</>;
};

export default App;
