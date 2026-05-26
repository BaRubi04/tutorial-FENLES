'use strict';

const { filter } = require('../../../../config/middlewares');
const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::pub.pub', ({ strapi }) =>({
    
    async find(ctx){
        let result = await strapi.entityService?.findMany('api::pub.pub', { populate: '*'});
        return result;
    },

    async affordable(ctx) {
        const { maxPrice } = ctx.query;
        const result  = await strapi.service('api::pub.pub').getAffordablePubs(maxPrice);
        return result;
    },
    
}));