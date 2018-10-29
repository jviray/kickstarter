pragma solidity ^0.4.17;

contract CampaignFactory {
    address[] public deployedCampaigns;

    function createCampaign(uint _minimum) public {
        // msg.sender of this function will be the account responsible for gas
        // returns address
        address newCampaign = new Campaign(_minimum, msg.sender);
        deployedCampaigns.push(newCampaign);
    }

    function getDeployedCampaigns() public view returns (address[]) {
        return deployedCampaigns;
    }
}

contract Campaign {
    struct Request {
      string description;
      uint value;
      address recipient;
      bool complete;
      uint approvalCount;
      mapping(address => bool) hasApproved;
    }

    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public hasContributed;
    uint public contributionCount;

    modifier onlyManager() {
        require(msg.sender == manager);
        _;
    }

    function Campaign(uint _minimum, address _creator) public {
        // No longer user msg.sender. When a contract deploys another,
        // although the user is paying for gas, the factory contract will be the
        // 'msg.sender.' Therefore, we must pass the user's address as a parameter
        // so that we can properly assign to campaign's manager
        manager = _creator;
        minimumContribution = _minimum;
        contributionCount = 0;
    }

    function contribute() public payable {
        require(msg.value >= minimumContribution);
        hasContributed[msg.sender] = true;
        contributionCount++;
    }

    function createRequest(string _description, uint _value, address _recipient)
        public onlyManager
    {
        require(hasContributed[msg.sender]);
        Request memory newRequest = Request({
            description: _description,
            value: _value,
            recipient: _recipient,
            complete: false,
            approvalCount: 0
        });

        requests.push(newRequest);
    }

    function approveRequest(uint _index) public {
        Request storage request = requests[_index];

        require(hasContributed[msg.sender]);
        // Should return NOT true
        require(!request.hasApproved[msg.sender]);

        request.hasApproved[msg.sender] = true;
        request.approvalCount++;
    }

    // Sends the payment to the vendor once the majority has approved
    function finalizeRequest(uint _index) public onlyManager {
        Request storage request = requests[_index];

        require(request.approvalCount > (contributionCount / 2));
        require(!request.complete);

        request.recipient.transfer(request.value);
        request.complete = true;
    }

}
