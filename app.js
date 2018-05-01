
const express = require("express");
const hbs = require('hbs');
var body_parser = require("body-parser");
var app = express();


app.set('view engine', 'hbs');
app.use(express.static(__dirname + "/public"));
app.use(body_parser());
app.use(body_parser.urlencoded({ extended: true}));

app.use('/js', express.static(__dirname + '/node_modules/bootstrap/dist/js'));
app.use('/js', express.static(__dirname + '/node_modules/jquery/dist'));
app.use('/css', express.static(__dirname + '/node_modules/bootstrap/dist/css'));

hbs.registerPartials(__dirname + '/views/partials');

hbs.registerHelper("math", function(lvalue, operator, rvalue, options) {
    lvalue = parseFloat(lvalue);
    rvalue = parseFloat(rvalue);

    return {
        "+": lvalue + rvalue,
        "-": lvalue - rvalue,
        "*": lvalue * rvalue,
        "/": lvalue / rvalue,
        "%": lvalue % rvalue
    }[operator];
});

hbs.registerHelper('fullname', function(person) {
    return person.firstname + " " + person.lastname;
});

var mysql = require('mysql')
var connection = mysql.createConnection({
  multipleStatements: true,
  host     : 'localhost',
  user     : 'root',
  password : '@Bla2210',
  database : 'dating'

});

connection.connect();

app.get('/', (req,res) =>{
    res.redirect('home.html');
});





/*
Managers gets
*/
app.get('/homepage-manager.hbs', (req,res)=>{
    connection.query("SELECT *, DATE_FORMAT(date_of_last_act, '%Y-%m-%d %T') as date_of_last_act FROM user, person WHERE user.ssn = person.ssn", function(error, user, fields){
        res.render('./homepage-manager.hbs',{
            users : user
        });
    });
});

app.get('/homepage-manager-employee.hbs', (req,res)=>{
    connection.query('SELECT *,   DATE_FORMAT(start_date, "%Y-%m-%d") as start_date FROM employee, person WHERE role != "Manager" AND employee.ssn = person.ssn', function(error, employee, fields){
        res.render('homepage-manager-employee.hbs',{
            employees : employee
        });
    });
});

app.get('/homepage-manager-dates.hbs', (req,res)=>{
    connection.query("SELECT *, DATE_FORMAT(date_time, '%Y-%m-%d %T') as date_time FROM date", function(error, date, fields){
        res.render('homepage-manager-dates.hbs',{
            dates : date
        });
    });
});

app.get('/homepage-manager-count.hbs', (req,res)=>{
    connection.query("SELECT * FROM most_active", function(error, count, fields){
        res.render('homepage-manager-count.hbs',{
            counts : count
        });
    });
});

app.get('/homepage-manager-revenue-cust.hbs', (req,res)=>{
    var db_revenue_cust = 'SELECT customer, revenue FROM all_revenue';
    connection.query(db_revenue_cust, function(error, revenue_cust, fields){
        res.render('homepage-manager-revenue-cust.hbs',{
            revenue_custs : revenue_cust
        });
    });
});

app.get('/homepage-manager-revenue-custrep.hbs', (req,res)=>{
    var db_revenue_cust = 'SELECT * FROM total_revenue';
    connection.query(db_revenue_cust, function(error, revenue_custrep, fields){
        res.render('homepage-manager-revenue-custrep.hbs',{
            revenue_custreps : revenue_custrep
        });
    });
});

app.get('/add-user.hbs', (req,res) =>{

    res.render('add-user.hbs');
});

app.get('/add-employee.hbs', (req,res)=>{
    res.render('add-employee.hbs');
});


app.get('/add-date.hbs', (req,res)=>{
    connection.query("SELECT * FROM profile", function(error, user, fields){
        connection.query("SELECT * FROM employee", function(error, reps, fields){
            console.log(user);
            res.render('add-date.hbs',{
                users : user,
                reps : reps
            });
        });
    });
});

app.get('/edit-user/:ssn', (req,res)=>{
    connection.query("SELECT ssn, ppp,rating, DATE_FORMAT(date_of_last_act, '%Y-%m-%d %T') as date_of_last_act FROM user WHERE ssn ='"+req.params.ssn +"'", function(err,user){
        res.render('edit-user.hbs', {
            users: user
        });
    });
});

app.get('/edit-employee/:ssn', (req,res)=>{
    connection.query("SELECT *, DATE_FORMAT(start_date, '%Y-%m-%d') as start_date FROM employee WHERE ssn ='"+req.params.ssn +"'", function(err,employee){
        console.log(employee);
        res.render('edit-employee.hbs', {
            employees: employee
        });
    });
});

app.get('/employee-mail-list/:ssn', (req,res)=>{
    var query = "SELECT profile_a as profile_id FROM date where cust_rep ='"+req.params.ssn +"' " +
                "UNION " + 
                "SELECT profile_b as profile_id FROM date where cust_rep ='"+req.params.ssn +"';"
    connection.query(query, function(err, dates){
        var id_list = dates.map(a => a.profile_id);

        var subquery = "SELECT owner_ssn as ssn FROM profile WHERE profile_id IN ( '" + id_list.join("','") + "')";
        var query = "SELECT * FROM person WHERE ssn IN ("+ subquery +");";

        connection.query(query, function(err, users){
            res.render('employee-mail-list.hbs', {
                users: users
            });
        });
    });
});


app.get('/delete-user/:ssn', (req,res)=>{

    connection.query("DELETE FROM user WHERE ssn ='"+req.params.ssn +"'", function(err,user){
        if(err){
            res.status(500).send({ error: err });
        }
        else{
            res.redirect("../homepage-manager-dates.hbs");
        }

    });
});

app.get('/delete-date', (req,res)=>{
    console.log(req.query);
    connection.query("DELETE FROM date WHERE profile_a ='" + req.query.profile_a + "' AND "
        + "profile_b ='" + req.query.profile_b + "' AND "
        + "date_time ='" + req.query.date_time + "';", function(err, user){
        if(err){
            res.status(500).send({ error: err });
        }
        else{
            res.redirect("../homepage-manager.hbs");
        }
    });
});

app.get('/delete-employee/:ssn', (req,res)=>{

    connection.query("DELETE FROM employee WHERE ssn ='"+req.params.ssn +"'", function(err,user){
        if(err){
            res.status(500).send({ error: err });
        }
        else{
            res.redirect("../homepage-manager-employee.hbs");
        }

    });
});


/*
Managers post
*/
app.post("/sign-in.html", function(req,res){
    var db_email = 'SELECT email FROM person WHERE email = ' + connection.escape(req.body.email);
    connection.query(db_email, function(error, email, fields){
        if(email.length == 1){
            var db_password = 'SELECT password FROM person WHERE email = ' + connection.escape(email[0].email);
            connection.query(db_password, function(error, password, fields){
                if(password[0].password.trim() == req.body.password){
                    //Matching email & Password
                    //Check if the login is user/custrep/manager
                    var db_ssn = 'SELECT ssn FROM person WHERE email = ' + connection.escape(email[0].email);
                    connection.query(db_ssn, function(error, ssn, fields){
                        var db_user_ssn = 'SELECT ssn FROM user WHERE ssn = ' + connection.escape(ssn[0].ssn);
                        connection.query(db_user_ssn, function(error, user_ssn, fields){
                            if(user_ssn.length == 1 ){
                                //Is a user
                                res.render('homepage-user.hbs', {
                                    username: email[0].email
                                });
                            }
                            else{
                                //Is a custrep/manager
                                var db_employee_ssn = 'SELECT ssn FROM employee WHERE role = "CustRep" AND ssn= ' + connection.escape(ssn[0].ssn);
                                connection.query(db_employee_ssn, function(error, employee_ssn, fields){
                                    if(employee_ssn.length >=1){
                                        //Is a cust rep
                                        console.log("custrep login");
                                    }
                                    else{
                                        //is a manager
                                        var db_employee_ssn = 'SELECT ssn FROM employee WHERE ssn = ' + connection.escape(ssn[0].ssn);
                                        connection.query(db_employee_ssn, function(error, employee_ssn, fields){
                                            connection.query("SELECT *, DATE_FORMAT(date_of_last_act, '%Y-%m-%d %T') as date_of_last_act FROM user, person WHERE user.ssn = person.ssn", function(error, user, fields){
                                                res.render('./homepage-manager.hbs',{
                                                    users : user
                                                });
                                            });
                                        });//end connection db_employee)ssn
                                    }//end else

                                });//end connection db_employee)ssn
                                //res.send("Custrep/manager");
                            }
                        });//end connection db_user_ssn
                    });//end connection db_ssn
                }//end if(password)
                else{
                    //res.send(connection.escape(req.body.password));
                    res.write("Wrong password!\n");
                    res.end();
                }
            });//end connection db_password
        }//end if(email)
        else res.send("Email does not exist");
    });//end connection db_email
});

app.post("/sign-up.html", function(req,res){
    console.log("Sign up page");
});

app.post('/add-user.hbs', function(req,res){

    var sql = "INSERT INTO user (ssn, ppp, rating, date_of_last_act) VALUES (";
    var cur_date = new Date().toLocaleString();

    sql += "'" + req.body.ssn + "',";
    sql += "'" + req.body.ppp + "',";
    sql += "'" + req.body.rating + "',";
    sql += "'" + cur_date +"')";

    connection.query(sql, function(err, result){
        if (err){
            res.status(500).send({ error: err })
        }
        connection.query("SELECT * FROM user, person WHERE user.ssn = person.ssn", function(error, user, fields){
            res.redirect("../homepage-manager.hbs");
        });

    });
});

app.post('/add-employee.hbs', function(req,res){
    var sql = "INSERT INTO employee (ssn, role, start_date, hourly_rate) VALUES (";

    sql += "'" + req.body.ssn + "',";
    sql += "'" + req.body.role + "',";
    sql += "'" + req.body.start_date + "',";
    sql += "'" + req.body.hourly_rate +"')";

    //console.log(sql);

    connection.query(sql, function(err, result){
        if (err){
            res.status(500).send({ error: err })
        }
        connection.query('SELECT *,  DATE_FORMAT(start_date, "%Y-%m-%d") as start_date FROM employee, person WHERE role != "Manager" AND employee.ssn = person.ssn', function(error, employee, fields){
            res.render('homepage-manager-employee.hbs',{
                employees : employee
            });
        });

    });


});

app.post('/add-date.hbs', function(req,res){
    var sql = "INSERT INTO date (date_time, profile_a, profile_b, cust_rep, location, comments, user1_rating, user2_rating, booking_fee) VALUES (";

    sql += "'" + req.body.date_time + "',";
    sql += "'" + req.body.profile_a + "',";
    sql += "'" + req.body.profile_b + "',";
    sql += "'" + req.body.cust_rep + "',";
    sql += "'" + req.body.location + "',";
    sql += "'" + req.body.comments + "',";
    sql += "'" + req.body.user1_rating + "',";
    sql += "'" + req.body.user2_rating + "',";
    sql += "'" + req.body.booking_fee +"')";

    connection.query(sql, function(err, result){
        if (err){
            res.status(500).send({ error: err })
        }
        res.redirect("../homepage-manager-dates.hbs");
    });
});

app.post('/edit-user/:ssn', (req,res)=>{
    var sql = "UPDATE user SET";
    sql += " ppp='"                      +req.body.ppp+"',";
    sql += " rating='"                   +req.body.rating+"',";
    sql += " date_of_last_act='"         +req.body.time+"'";
    sql += " WHERE user.ssn ='"          +req.params.ssn +"'";

    connection.query(sql, function(err,user){
        if(err){
            res.status(500).send({ error: err });
        }
        else{
            res.redirect("../homepage-manager.hbs");
        }
    });
});

app.post('/edit-employee/:ssn', (req,res)=>{
    var sql = "UPDATE employee SET";
    sql += " role='"                         +req.body.role+"',";
    sql += " start_date='"                   +req.body.start_date+"',";
    sql += " hourly_rate='"                  +req.body.hourly_rate+"'";
    sql += " WHERE employee.ssn ='"          +req.params.ssn +"'";

    connection.query(sql, function(err,user){
        if(err){
            res.status(500).send({ error: err });
        }
        else{
            res.redirect("../homepage-manager-employee.hbs");
        }
    });


});

app.listen(9000, () => {
    console.log("Server running at port 9000");
});
