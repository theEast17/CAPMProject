const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { worker } = this.entities;

    this.on('hike', async (req) => {
        console.log(req.data);
        const { ID } = req.data;

        if (!ID) {
            return req.reject(400, 'ID not found!');
        }
        console.log(`Received ID: ${ID}`);

        const tx = cds.transaction(req);
        try {
            const workers = await tx.read(worker).where({ ID });   // we will get array of worker []
            
            if (workers.length === 0) {
                return req.reject(404, 'ID not found');
            }

            console.log('Existing Worker Data:', JSON.stringify(workers));

            const currentSalary = workers[0].salaryAmount;
            console.log('Current Salary:', currentSalary);

            const result = await tx.update(worker)
                .set({ salaryAmount: currentSalary + 20000 })
                .where({ ID });
            // here if the update successfully we will get 1,  if it is unsuccessfull then we will get 0

            if (result === 0) {
                return req.reject(500, 'Failed to update salary');
            }

            console.log('Salary Hike Successful');

            // Fetch updated record
            const updatedWorker = await tx.read(worker).where({ ID });

            return { message: 'Incremented', worker: updatedWorker[0] };
        } catch (error) {
            console.error('Error during salary hike:', error);
            return req.reject(500, error.message);
        }
    });
});
