const sql = require('mysql');
const credential = require('../credential.js');

let params;
if (process.env.RDS_HOSTNAME) {
  params = {
    host: process.env.RDS_HOSTNAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD,
    port: process.env.RDS_PORT,
    database : 'appointmentserver'
  };
} else {
  params = credential.mysql;
}

const db = sql.createConnection(params);
db.connect();

module.exports = db;
