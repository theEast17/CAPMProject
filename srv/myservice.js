const myserv = (srv) => {
    srv.on('myFunc', (req, res) => {
        return "welcome" + req.data.msg;
    })
}

module.exports = myserv;