import { Component, createSignal, onMount, Show, For } from "solid-js";
import { useNavigate } from "@solidjs/router";
import { usePb } from "../components/context/PbContext";
import toast from "solid-toast";

interface Provider {
    authUrl :string;
    codeChallenge :string;
    codeChallengeMethod :string;
    codeVerifier :string;
    displayName :string;
    name :string;
    state :string;
}

const LoginOauth: Component = () => {
    const pb = usePb();
    const navigate = useNavigate();
    const [providers, setProviders] = createSignal<Provider[]>([]);

    onMount(async () => {
        const providers = await pb.collection('users').listAuthMethods();
        setProviders(providers.authProviders);
    });

    const oAuth2 = async (provider :string) => {
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
            <Show when={providers().length === 0}>
                <p>No provider set, go to Pocketbase in order to add one.</p>
            </Show>

            <For each={providers()}>{(provider) =>
                <button onClick={[oAuth2, provider.name]} class="btn btn-outline">
                    <i class={`ph ph-${provider.name}-logo`}></i> {provider.displayName}
                </button>
            }</For>
        </div>
    );
};

export default LoginOauth;
