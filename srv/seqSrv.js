const cds = require("@sap/cds");
const SequenceHelper = require("./lib/SequenceHelper");

module.exports = cds.service.impl(async (service) => {
	const db = await cds.connect.to("db");
	const { sequence } = service.entities;

	service.before("CREATE", sequence, async (context) => {
		const sequenceId = new SequenceHelper({
			db: db,
			sequence: "SEQ_EVENT_ID",
			table: "EVENTS",
			field: "ID"
		});

		context.data.ID = await sequenceId.getNextNumber();
	});
});