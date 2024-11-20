import PocketBase from "pocketbase";
import toast from "solid-toast";

type GetOneMessageArgs = {
  pb: PocketBase;
  id: string;
};

export const getAllMessages = async (pb: PocketBase) => {
  try {
    const result = await pb.collection("messages").getList();

    toast.success("Messages récupérés avec succès");

    return result.items;
  } catch (e) {
    toast.error("Erreur de récupération des messages");
  }
};

export const getOneMessage = async (args: GetOneMessageArgs) => {
  try {
    const result = await args.pb.collection("messages").getOne(args.id);

    return result;
  } catch (e) {
    toast.error("Erreur de récupération des messages");
  }
};
