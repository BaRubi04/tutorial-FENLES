const { createCoreRouter } = require('@strapi/strapi').factories;
module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/pub/affordable',
      handler: 'pub.affordable',
      config: {auth:false},
    },
  ],
};