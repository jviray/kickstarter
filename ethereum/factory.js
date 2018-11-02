import web3 from "./web3";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(
  JSON.parse(CampaignFactory.interface),
  '0x9e6A626b2B771FAc9f6f40a5b51cAd19f682a765'
);

export default instance;
