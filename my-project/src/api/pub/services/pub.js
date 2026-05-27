'use strict';

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::pub.pub', ({ strapi }) =>({
    async getAffordablePubs(maxPrice) {
        const pubs = await strapi.entityService.findMany('api::pub.pub',{
            filters:{
                avgPrice:{'$lte': maxPrice}
            },
            populate: '*',
        });
        return pubs;
    }
}));