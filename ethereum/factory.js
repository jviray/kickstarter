import web3 from "./web3";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(
  JSON.parse(CampaignFactory.interface),
  '0xa32ded29D95A326F43D739CF86Ae69EC26AF1319'
);

export default instance;
