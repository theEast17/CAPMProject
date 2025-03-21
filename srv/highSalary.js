const cds = require('@sap/cds')

module.exports = srv => {
    srv.on('getHighestSalary', async () => {
        try {
            const { worker } = cds.entities('india.db.master');
            const highestSalaryWorker = await cds.run(SELECT.one`salaryAmount as highestSalary`.from(worker).orderBy`salaryAmount DESC`)
            console.log(highestSalaryWorker);
            if (highestSalaryWorker) {
                return highestSalaryWorker.highestSalary
            } else {
                return null;
            }
        } catch (error) {
            console.error('error occur', error)
            return null;
        }
    })
}