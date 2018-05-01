
const express = require("express");
const hbs = require('hbs');
var body_parser = require("body-parser");
var cookieParser = require('cookie-parser');
var session = require('express-session');
var morgan = require('morgan');
var app = express();


app.set('view engine', 'hbs');
app.use(express.static(__dirname + "/public"));
app.use(body_parser());
app.use(body_parser.urlencoded({ extended: true}));

// set morgan to log info about our requests for development use.
app.use(morgan('dev'));

// initialize cookie-parser to allow us access the cookies stored in the browser. 
app.use(cookieParser());

// initialize express-session to allow us track the logged-in user across sessions.
app.use(session({
    key: 'user_sid',
    secret: 'somerandonstuffs',
    resave: false,
    saveUninitialized: false,
    cookie: {
        expires: 600000
    }
}));

// This middleware will check if user's cookie is still saved in browser and user is not set, then automatically log the user out.
// This usually happens when you stop your express server after login, your cookie still remains saved in the browser.
app.use((req, res, next) => {
    if (req.cookies.user_sid && !req.session.user) {
        res.clearCookie('user_sid');        
    }
    next();
});

// middleware function to check for logged-in users
var sessionChecker = (req, res, next) => {
    if (req.session.user && req.cookies.user_sid) {
        next();
    } else {
        res.redirect('/');
    }    
};

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
    if (req.session.user && req.cookies.user_sid) {
        res.redirect('/homepage-manager.hbs');
    } else {
        res.sendFile(__dirname + '/public/home.html');
    } 
});





/*
Managers gets
*/
app.get('/homepage-manager.hbs', sessionChecker, (req,res)=>{
    connection.query("SELECT *, DATE_FORMAT(date_of_last_act, '%Y-%m-%d %T') as date_of_last_act FROM user, person WHERE user.ssn = person.ssn", function(error, user, fields){
        res.render('./homepage-manager.hbs',{
            users : user
        });
    });
});

app.get('/homepage-manager-employee.hbs', sessionChecker, (req,res)=>{
    connection.query('SELECT *,   DATE_FORMAT(start_date, "%Y-%m-%d") as start_date FROM employee, person WHERE role != "Manager" AND employee.ssn = person.ssn', function(error, employee, fields){
        res.render('homepage-manager-employee.hbs',{
            employees : employee
        });
    });
});

app.get('/homepage-manager-dates.hbs', sessionChecker, (req,res)=>{
    connection.query("SELECT *, DATE_FORMAT(date_time, '%Y-%m-%d %T') as date_time FROM date", function(error, date, fields){
        res.render('homepage-manager-dates.hbs',{
            dates : date
        });
    });
});

app.get('/homepage-manager-count.hbs', sessionChecker, (req,res)=>{
    connection.query("SELECT * FROM most_active", function(error, count, fields){
        res.render('homepage-manager-count.hbs',{
            counts : count
        });
    });
});

app.get('/homepage-manager-revenue-cust.hbs', sessionChecker, (req,res)=>{
    var db_revenue_cust = 'SELECT customer, revenue FROM all_revenue';
    connection.query(db_revenue_cust, function(error, revenue_cust, fields){
        res.render('homepage-manager-revenue-cust.hbs',{
            revenue_custs : revenue_cust
        });
    });
});

app.get('/homepage-manager-revenue-custrep.hbs', sessionChecker, (req,res)=>{
    var db_revenue_cust = 'SELECT * FROM total_revenue';
    connection.query(db_revenue_cust, function(error, revenue_custrep, fields){
        res.render('homepage-manager-revenue-custrep.hbs',{
            revenue_custreps : revenue_custrep
        });
    });
});

app.get('/add-user.hbs', sessionChecker, (req,res) =>{

    res.render('add-user.hbs');
});

app.get('/add-employee.hbs', sessionChecker, (req,res)=>{
    res.render('add-employee.hbs');
});


app.get('/add-date.hbs', sessionChecker, (req,res)=>{
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

app.get('/edit-user/:ssn', sessionChecker, (req,res)=>{
    connection.query("SELECT ssn, ppp,rating, DATE_FORMAT(date_of_last_act, '%Y-%m-%d %T') as date_of_last_act FROM user WHERE ssn ='"+req.params.ssn +"'", function(err,user){
        res.render('edit-user.hbs', {
            users: user
        });
    });
});

app.get('/edit-employee/:ssn', sessionChecker, (req,res)=>{
    connection.query("SELECT *, DATE_FORMAT(start_date, '%Y-%m-%d') as start_date FROM employee WHERE ssn ='"+req.params.ssn +"'", function(err,employee){
        console.log(employee);
        res.render('edit-employee.hbs', {
            employees: employee
        });
    });
});

app.get('/employee-mail-list/:ssn', sessionChecker, (req,res)=>{
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


app.get('/delete-user/:ssn', sessionChecker, (req,res)=>{

    connection.query("DELETE FROM user WHERE ssn ='"+req.params.ssn +"'", function(err,user){
        if(err){
            res.status(500).send({ error: err });
        }
        else{
            res.redirect("/homepage-manager-dates.hbs");
        }

    });
});

app.get('/delete-date', sessionChecker, (req,res)=>{
    console.log(req.query);
    connection.query("DELETE FROM date WHERE profile_a ='" + req.query.profile_a + "' AND "
        + "profile_b ='" + req.query.profile_b + "' AND "
        + "date_time ='" + req.query.date_time + "';", function(err, user){
        if(err){
            res.status(500).send({ error: err });
        }
        else{
            res.redirect("/homepage-manager.hbs");
        }
    });
});

app.get('/delete-employee/:ssn', sessionChecker, (req,res)=>{

    connection.query("DELETE FROM employee WHERE ssn ='"+req.params.ssn +"'", function(err,user){
        if(err){
            res.status(500).send({ error: err });
        }
        else{
            res.redirect("/homepage-manager-employee.hbs");
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
            var db_password = 'SELECT * FROM person WHERE email = ' + connection.escape(email[0].email);
            connection.query(db_password, function(error, person){
                person = person[0];
                if(person.password.trim() == req.body.password){
                    //Matching email & Password
                    //Check if the login is user/custrep/manager
                    var db_user_ssn = 'SELECT * FROM user WHERE ssn = ' + connection.escape(person.ssn);
                    connection.query(db_user_ssn, function(error, user, fields){
                        user = user[0];
                        if (user) {
                                //Is a user
                            req.session.role = "User";
                            req.session.user = user;
                            req.session.person = person;
                            res.redirect('/');
                            }
                            else{
                                //Is a custrep/manager
                            var db_employee_ssn = 'SELECT * FROM employee WHERE ssn= ' + connection.escape(person.ssn);
                            connection.query(db_employee_ssn, function(error, employee, fields){
                                // role = "CustRep"
                                employee = employee[0];
                                if (employee.role == "CustRep") {
                                    console.log("CustRep login");
                                    req.session.employee = employee;
                                    req.session.user = employee;
                                    req.session.person = person;
                                    req.session.role = "CustRep";
                                }
                                else if (employee.role == "Manager") {
                                    console.log("Manager login");
                                    req.session.employee = employee;
                                    req.session.user = employee;
                                    req.session.person = person;
                                    req.session.role = "Manager";
                                    }
                                res.redirect('/');
                                });//end connection db_employee)ssn
                                //res.send("Custrep/manager");
                            }
                        });//end connection db_user_ssn
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

// route for user logout
app.get('/logout', sessionChecker, (req, res) => {
    res.clearCookie('user_sid');
    res.redirect('/');
});

app.post("/sign-up.html", function(req,res){
    console.log("Sign up page");
});

app.post('/add-user.hbs', sessionChecker, function(req,res){

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
            res.redirect("/homepage-manager.hbs");
        });

    });
});

app.post('/add-employee.hbs', sessionChecker, function(req,res){
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

app.post('/add-date.hbs', sessionChecker, function(req,res){
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

app.post('/edit-user/:ssn', sessionChecker, (req,res)=>{
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

app.post('/edit-employee/:ssn', sessionChecker, (req,res)=>{
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
