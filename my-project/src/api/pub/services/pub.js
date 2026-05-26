'use strict';

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::pub.pub', ({ strapi }) =>({
    async getAffordablePubs(maxPrice = 15) {
        const pub = await strapi.entityService.findMany('api::pub.pub',{
            filters:{
                avgPrice:{'$lte': maxPrice}
            },
            populate: '*',
        });
       // return pub;
    }
}));