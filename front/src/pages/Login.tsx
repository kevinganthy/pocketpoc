import { Component } from "solid-js";
import LoginForm from "../components/LoginForm";

const Login: Component = () => {
  return (
    <div class="h-screen w-screen flex items-center justify-center bg-slate-800">
      
      <div class="flex flex-wrap lg:flex-nowrap w-11/12 max-w-3xl gap-4 lg:gap-16 bg-slate-50 rounded-lg p-4 lg:p-12 pt-8 lg:pt-24">
        <div class="flex flex-col gap-2 w-full">
          <h1 class="font-display uppercase text-primary text-4xl mt-2">{import.meta.env.VITE_APP_NAME}</h1>
          <p class="text-lg text-gray-500 grow">{import.meta.env.VITE_APP_DESCRIPTION}</p>
        </div>

        <div class="w-full p-4 pt-12 lg:p-12 lg:pt-0">
          <LoginForm />
        </div>
      </div>

    </div>
  );
};

export default Login;
