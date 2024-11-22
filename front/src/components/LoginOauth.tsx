import { Component } from "solid-js";
import { useNavigate } from "@solidjs/router";
import { usePb } from "../components/context/PbContext";
import toast from "solid-toast";


const LoginOauth: Component = () => {
    const pb = usePb();
    const navigate = useNavigate();

    const oAuth2 = async (provider :string) => {
        if ( ["apple"].indexOf(provider) !== -1 ) {
            toast.error("Provider non implémenté");
            return;
        }

        try {
            await pb.collection('users').authWithOAuth2({ provider: provider });
        } catch (e) {
            toast.error("Identifiants invalides");
            return;
        }

        if (pb.authStore.isValid) {
            navigate("/home", { replace: true });
            toast.success("Connecté avec succès");
        }
    }

      
    return (
        <div class="flex flex-col gap-4 ">
            <button onClick={[oAuth2, "github"]} class="btn btn-primary">
              <i class="ph ph-github-logo"></i> Github
            </button>
            <button onClick={[oAuth2, "google"]} class="btn btn-outline">
              <i class="ph ph-google-logo"></i> Google
            </button>
            <button onClick={[oAuth2, "apple"]} class="btn btn-outline">
              <i class="ph ph-apple-logo"></i> Apple
            </button>
        </div>
    );
};

export default LoginOauth;
