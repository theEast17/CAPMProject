const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { worker } = this.entities;
    this.on('hike', async (req) => {
        console.log(req.data)
        const { ID } = req.data;

        if (!ID ) {
            return req.reject(400, 'Id not found!');
        }
        console.log(`Recived ${ID}`);

        const tx = cds.transaction(req);
        try {
            const workers = await tx.read(worker).where({ ID: ID })
            if (!workers) {
                await tx.rollback()
                return req.reject(404, 'Not found Id');
            }
            console.log(JSON.stringify({...workers}))
            const currentsalary = workers[0].salaryAmount;
            console.log('Current Salary: ' + currentsalary)

            const result = await tx.update(worker).set({ salaryAmount: currentsalary + 20000 }).where({ ID: ID })
            console.log('Hike Salary'+result);


            if (result === 0) {
                await tx.rollback()
                return req.reject(500, 'failed to update salary');
            }
            await tx.commit();
            console.log('Updated Successfully');
            return req.reply({ message: 'Incremented', worker: result[0] })
        } catch (error) {
            console.error('Error during hike', error);
            try {
                await tx.rollback()
            } catch (rollbackError) {
                console.error('Rollback failed', rollbackError)
            }
            return req.reject(500, error.message)
        }
    })
})