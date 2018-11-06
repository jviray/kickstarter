const routes = require('next-routes')(); // invokes function upon requiring

routes
  .add('/campaigns/new', '/campaigns/new')
  .add('/campaigns/:address', '/campaigns/show');

module.exports = routes;
