import { Component } from "solid-js";
import { usePb } from "./context/PbContext";
import { action, redirect } from "@solidjs/router";

const Header: Component = () => {
  const pb = usePb();

  const logout = action(async () => {
    pb.authStore.clear();
    throw redirect("/login");
  });

  return (
    <header class="pb-8">
      <div class="navbar bg-base-100 shadow-lg">
        <div class="navbar-start">
          <a class="btn btn-ghost text-xl">{import.meta.env.VITE_APP_NAME}</a>
        </div>
        
        <div class="navbar-end">
          <form action={logout} method="post">
            <input type="submit" class="btn btn-sm" value="Déconnexion" />
          </form>
        </div>
      </div>
    </header>
  );
};

export default Header;
