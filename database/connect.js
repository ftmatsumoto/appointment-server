const sql = require('mysql');

let params;
if (process.env.RDS_HOSTNAME) {
  params = {
    host: process.env.RDS_HOSTNAME,
    user: process.env.RDS_USERNAME,
    password: process.env.RDS_PASSWORD,
    database : process.env.RDS_DATABASE
    // port: process.env.RDS_PORT,
  };
} else {
  params = require('../credential.js').mysql;
}

// const db = sql.createConnection(params);
// db.connect();

const db = sql.createPool(params);

module.exports = db;
