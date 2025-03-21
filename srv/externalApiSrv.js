const axios = require('axios');
const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { ExternalApi } = this.entities;

    this.on('READ', ExternalApi, async (req) => {
        try {
            const response = await axios.get('https://jsonplaceholder.typicode.com/posts');
            return response.data;
        } catch (error) {
            req.error(500, 'Failed to fetch external data');
        }
    })
})

