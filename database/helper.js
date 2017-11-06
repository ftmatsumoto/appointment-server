const db = require('./connect');
const Promise = require('bluebird');

module.exports = {
  user: {                   // ARGUMENTS
    add: addUser           // (username:string, email:string, firstname:string, lastname:string, location_id:integer)
  },
  location: {
    add: addLocation       // (address:string, addressnumber:integer, zipcode:string, phone:string, addresscomp:string)
  }
};

function addUser(username, email, firstname, lastname, locationid) {
  return new Promise((resolve, reject) => {
    db.getConnection((err, connection) => {
      connection.query(`INSERT INTO user_account (username, email, first_name, last_name, location_id, time_created)
                VALUES ('${username}', '${email}', '${firstname}', '${lastname}','${locationid}', NOW());`,
        (error, result) => {
          connection.release();
          if (error) {
            reject(error);
          } else {
            resolve(result);
          }
        }
      );
    });
  });
}

function addLocation(address, addressnumber, zipcode, phone, addresscomp) {
  return new Promise((resolve, reject) => {
    db.getConnection((err, connection) => {
      connection.query(`INSERT INTO location (address, address_number, zipcode, phone, address_comp)
                VALUES ('${address}', '${addressnumber}', '${zipcode}', '${phone}','${addresscomp}');`,
        (error, result) => {
          connection.release();
          if (error) {
            reject(error);
          } else {
            resolve(result);
          }
        }
      );
    });
  });
}


addLocation('Rua Dr Eduardo Amaro', 99, '04104080', '11976086655', 'apt 913');
addUser('test','felipetmatsumoto@yahoo.com.br','Felipe','Matsumoto',1);
