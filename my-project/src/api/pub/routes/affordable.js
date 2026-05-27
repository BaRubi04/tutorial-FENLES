const { createCoreRouter } = require('@strapi/strapi').factories;
module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/pubs/affordable',
      handler: 'pub.affordable',
      config: {auth:false},
    },
  ],
};