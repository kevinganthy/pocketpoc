import { Component, ParentProps } from "solid-js";
import { usePb } from "./context/PbContext";
import { Navigate } from "@solidjs/router";
import Header from "./Header";
import { Toaster } from "solid-toast";

const Layout: Component = ({ children }: ParentProps) => {
  const pb = usePb();

  if (!pb.authStore.isValid) {
    return <Navigate href="/login" />;
  }

  return (
    <div class="h-screen w-screen flex flex-col">
      <Toaster />
      <Header />
      <main class="flex flex-col grow w-full">{children}</main>
    </div>
  );
};

export default Layout;
