import { useContext } from "react";
import {
  VisibilityCtx,
  VisibilityProviderValue,
} from "../providers/VisibilityProvider";

export const useVisibility = (): VisibilityProviderValue =>
  useContext<VisibilityProviderValue>(VisibilityCtx);
