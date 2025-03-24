const cds = require('@sap/cds');
const { worker } = cds.entities("india.db.master");

const NewCQLService = function (srv) {
    srv.on('READ', 'readworker', async (req, res) => {
  
        let results = [];
        // results = await cds.tx(req).run(SELECT.from(worker).where({'firstName':'Saurabh'}))
        results = await cds.tx(req).run(SELECT.from(worker))
        return results;
    })

    srv.on('CREATE', 'insertworker', async (req) => {
        try {
            let result = await cds.transaction(req).run([
                INSERT.into(worker).entries([req.data])
            ]);
            if (result && result.length > 0) {
                return req.data;
            } else {
                req.error(500, 'Insert operation failed!');
            }
        } catch (err) {
            req.error(500, 'Error occurred: ' + err.toString());
        }
    });
    
    srv.on('UPDATE', 'updateworker', async (req) => {
        let returnData = await cds.transaction(req).run([
            UPDATE(worker)
                // .set({
                //     firstName: req.data.firstName,
                //     lastName: req.data.lastName
                // })
                .set(req.data)
                .where({ ID: req.data.ID })
        ]).then((resolve) => {
            if (resolve) {
                return req.data;
            } else {
                req.error(500, 'There was an error!');
            }
        }).catch((err) => {
            req.error(500, 'Below error occurred! ' + err.toString());
        });
    
        return returnData;
    });
    

    srv.on('DELETE', 'deleteworker', async (req, res) => {
        let returnData = await cds.transaction(req).run([
            DELETE.from(worker).where(req.data)
        ]).then((resolve, reject) => {
            if (typeof (resolve) !== undefined) {
                return req.data;
            } else {
                req.error(500, 'There was an error!')
            }
        }).catch((err) => {
            req.error(500, 'Below error occured!' + err.toString())
        })
        return returnData;
    })


}

module.exports = NewCQLService; 