import { createContext, ParentProps, useContext } from "solid-js";
import PocketBase from "pocketbase";

const PbContext = createContext();

export function PbProvider(props: ParentProps) {
  const pb = new PocketBase(import.meta.env.VITE_API_URL);

  return <PbContext.Provider value={pb}>{props.children}</PbContext.Provider>;
}

export function usePb() {
  return useContext(PbContext) as PocketBase;
}
