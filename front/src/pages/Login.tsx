import { Component } from "solid-js";
import LoginForm from "../components/LoginForm";

const Login: Component = () => {
  return (
    <div class="h-screen w-screen flex items-center justify-center bg-slate-800">
      
      <div class="flex gap-32 bg-slate-50 rounded-lg p-12 pt-24">
        <div class="flex flex-col gap-2">
          <h1 class="font-display uppercase text-primary text-4xl">{import.meta.env.VITE_APP_NAME}</h1>
          <p class="text-lg text-gray-500 w-64">{import.meta.env.VITE_APP_DESCRIPTION}</p>
        </div>

        <div class="p-12 pt-0">
          <LoginForm />
        </div>
      </div>

    </div>
  );
};

export default Login;
