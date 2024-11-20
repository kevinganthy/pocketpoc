/* @refresh reload */
import { render } from 'solid-js/web'
import './index.css'

import { Route, Router } from "@solidjs/router";
import { PbProvider } from "./components/context/PbContext";
import Home from "./pages/Home";
import Layout from "./components/Layout";
import Login from "./pages/Login";
import NotFound from "./pages/NotFound";

const root = document.getElementById("root");

if (import.meta.env.DEV && !(root instanceof HTMLElement)) {
  throw new Error(
    "Root element not found. Did you forget to add it to your index.html? Or maybe the id attribute got misspelled?"
  );
}

render(
  () => (
    <PbProvider>
      <Router>
        <Route path="/" component={Layout}>
          <Route path="/home" component={Home} />
        </Route>

        <Route path="/login" component={Login} />

        <Route path="*404" component={NotFound} />
      </Router>
    </PbProvider>
  ),
  root!
);

