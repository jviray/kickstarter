import React, { Component } from 'react';
import factory from '../ethereum/factory';

class CampaignIndex extends Component {

  static async getInitialProps() {
    const campaigns = await factory.methods.getDeployedCampaigns().call();

    // campaigns object is available on this component as props
    return { campaigns };
  }

  render() {
    return <div>{ this.props.campaigns[0] }</div>
  }
}

export default CampaignIndex;
