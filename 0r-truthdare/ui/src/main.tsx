import ReactDOM from "react-dom/client";
import App from "./components/App";
import { VisibilityProvider } from "./providers/VisibilityProvider";
import RouterProvider from "./providers/RouterProvider";
import LocaleProvider from "./providers/LocaleProvider";
import { DataProvider } from "./providers/DataProvider";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <>
    <VisibilityProvider>
      <LocaleProvider>
        <DataProvider>
          <RouterProvider>
            <App />
          </RouterProvider>
        </DataProvider>
      </LocaleProvider>
    </VisibilityProvider>
  </>
);
