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
    <>
      <Toaster />
      <Header />
      <main class="container mx-auto">{children}</main>
    </>
  );
};

export default Layout;
