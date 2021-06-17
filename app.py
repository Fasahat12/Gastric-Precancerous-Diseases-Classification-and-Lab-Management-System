from flask import Flask,render_template,flash,redirect,url_for,session,request,logging, make_response
#to import Articles function from data.py
from flask_mysqldb import MySQL
from wtforms import Form,StringField, TextAreaField, PasswordField, validators
from flask_wtf.file import FileField, FileRequired
from wtforms.fields.html5 import EmailField
from passlib.hash import sha256_crypt
from functools import wraps
import smtplib
import uuid
import datetime
import os
from tensorflow.keras import models
import numpy as np
from PIL import Image
import string
import random
from tensorflow.keras.preprocessing import image as i1
import cv2
import pdfkit
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


#create an instance of the flask app
app = Flask(__name__)



# Config MYSQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'GPDC'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
app.config['INITIAL_FILE_UPLOADS'] = 'static/img/uploads'

# Loading model
model = models.load_model('static/model/gpdc_model.h5')


#initialize MySQL
mysql = MySQL(app)



ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg'])

def allowed_file(filename):
 return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


#function to classify images
def predict_label(img_path):
	i = i1.load_img(img_path, target_size=(32,32))
	i=cv2.imread(img_path)
	resized=cv2.resize(i,(32,32))
	i = i1.img_to_array(i)/255.0
	i = i.reshape(1, 32,32,3)
	result = model.predict(i)
	ind = np.argmax(result)
	classes = ['Erosion','Polyp','Ulcer']
	return classes[ind]



# Index
#the route is mapped to the index function
@app.route('/')
def index():
    return render_template('home.html')


#the route is mapped to the about function
@app.route('/about')
def about():
    return render_template('about.html')





# User Registration Form Class
class RegisterForm(Form):
    name = StringField('Full Name')
    speciality = StringField('Speciality')
    cnic = StringField('CNIC')
    username = StringField('Username')
    email = StringField('Email Address')
    password = PasswordField('Passwords')
    confirm = PasswordField('Confirm Password')




# Forgot Password Form Class
class ForgotForm(Form):
    email = EmailField('Email Address',[validators.DataRequired(),validators.Email()])


class PasswordResetForm(Form):
    password = PasswordField('Passwords',[validators.DataRequired(),validators.Length(min=6,max=50),
                                        validators.EqualTo('confirm',message='Passwords do not match')])

    confirm = PasswordField('Confirm Password',[validators.DataRequired()])



# user register
# by default all other routes  accept GET request but this route needs to accept POST request
#as we have to submit our form through it
@app.route('/register',methods=['GET','POST'])
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        name = form.name.data
        email = form.email.data
        username = form.username.data
        speciality = form.speciality.data
        cnic = form.cnic.data
        password = sha256_crypt.encrypt(str(form.password.data))


        # Create cursor
        cur = mysql.connection.cursor()

        result1 = cur.execute("SELECT username FROM user WHERE username=%s",[username])

        result2 = cur.execute("SELECT email FROM user WHERE email=%s",[email])

        result3 = cur.execute("SELECT cnic FROM user WHERE cnic=%s",[cnic])


        if result1 > 0:

            # only initialized flash message
            flash("Username already exists",'danger')

            return render_template('register.html',form=form)

        elif result2 > 0:

            # only initialized flash message
            flash("An account with this email already exists",'danger')

            return render_template('register.html',form=form)

        elif result3 > 0:

            # only initialized flash message
            flash("An account with this CNIC already exists",'danger')

            return render_template('register.html',form=form)

        else:
            # Execute query
            cur.execute("INSERT INTO user(name,cnic,speciality,email,username,password) VALUES(%s,%s,%s,%s,%s,%s)",(name,cnic,speciality,email,username,password))

            #Commit to DB
            mysql.connection.commit()

            #Close connection
            cur.close()

            # only initialized flash message
            flash("You're registration request has been sent",'success')

            return redirect(url_for('login'))

    return render_template('register.html',form=form)

# User Login
@app.route('/login',methods=['GET','POST'])
def login():
    if request.method == 'POST':
        # Get Form Fields
        username = request.form['username']
        password_candidate = request.form['password']

        # Create cursor
        cur = mysql.connection.cursor()

        # Get user by Username
        result = cur.execute("SELECT * from user WHERE username = %s ",[username])

        if result > 0:
            # Get stored hash
            # In Order to get the first username from the database
            data = cur.fetchone()
            password = data['password']

            # Compare Passwords
            if sha256_crypt.verify(password_candidate,password):

                if data['user_type'] == 1:
                    # Allow Login
                    session['logged_in'] = True
                    session['username'] = username
                    session['user_type'] = 1
                    session['id'] = data['id']
                    app.logger.info(session['id'])

                    flash('You are now logged in','success')
                    return redirect(url_for('admin'))
                elif data['user_type'] == 0:
                    # Allow Login
                    session['logged_in'] = True
                    session['username'] = username
                    session['user_type'] = 0
                    session['id'] = data['id']

                    flash('You are now logged in','success')
                    return redirect(url_for('dashboard'))
                elif data['user_type'] == -1:
                    error = "Request hasn't been accepted yet"
                    return render_template('login.html',error=error)
            else:
                error = 'Invalid Login'
                return render_template('login.html',error=error)
            cur.close()
        else:
            error = 'Username not found'
            return render_template('login.html',error=error)
    return render_template('login.html')


# Check if user logged in
def is_logged_in(f):
    @wraps(f)
    def wrap(*args,**kwargs):
        if 'logged_in' in session:
            return f(*args,**kwargs)
        else:
            flash('Unauthorized, Please login','danger')
            return redirect(url_for('login'))
    return wrap

#Profile Route
@app.route('/profile')
@is_logged_in
def profile():
    #Create Cursor
    cur = mysql.connection.cursor()

    id = session['id']
    #Get Users
    result = cur.execute("SELECT * FROM user WHERE id=%s",[id])

    user = cur.fetchall()

    if result > 0:
        return render_template('profile.html', user=user)

    else:
        msg = "No User Found"
        return render_template('profile.html' , msg=msg)

    #Close Connection
    cur.close()




# Logout
@app.route('/logout')
@is_logged_in
def logout():
    session.clear()
    flash('You are now logged out','success')
    return redirect(url_for('login'))

# Dashboard
@app.route('/dashboard')
@is_logged_in
def dashboard():
    return render_template('dashboard.html')

#Patients Route
@app.route('/patients')
@is_logged_in
def patients():
    #Create Cursor
    cur = mysql.connection.cursor()

    id = session['id']
    #Get Patients
    result = cur.execute("SELECT * FROM patients WHERE user_id=%s",[id])

    patients = cur.fetchall()

    if result > 0:
        return render_template('patients.html', patients=patients)

    else:
        msg = "No Patients Found"
        return render_template('patients.html' , msg=msg)

    #Close Connection
    cur.close()


# Patient Form Class
class PatientForm(Form):
    p_name = StringField('Full Name',[validators.Length(min=1,max=50)])
    p_dob = StringField('Date of Birth',[validators.Length(min=1,max=50)])
    p_age = StringField('Age',[validators.Length(min=1,max=50)])
    p_docname = StringField('Doctor Name',[validators.Length(min=1,max=50)])
    p_gender = StringField('Gender',[validators.Length(min=1,max=50)])

#Add Patient Route
@app.route('/add_patient',methods = ['GET', 'POST'])
@is_logged_in
def add_patient():
    form = PatientForm(request.form)
    if request.method == 'POST' and form.validate():
        p_name = form.p_name.data
        p_dob = form.p_dob.data
        p_age = form.p_age.data
        p_docname = form.p_docname.data
        p_gender = form.p_gender.data

        #Create cursor
        cur = mysql.connection.cursor()

        #Execute
        cur.execute("INSERT INTO patients(p_name, user_id, p_dob, p_age,p_docname,p_gender) VALUES(%s,%s,%s,%s,%s,%s)", (p_name, session['id'], p_dob,p_age,p_docname,p_gender))

        #commit to DB
        mysql.connection.commit()

        #close connection
        cur.close()

        flash('Patient Added','success')
        return redirect(url_for('patients'))
    return render_template('add_patient.html',form=form)


#Edit Patient Route
@app.route('/edit_patient/<string:id>',methods = ['GET', 'POST'])
@is_logged_in
def edit_patient(id):

    #Create Cursor
    cur = mysql.connection.cursor()

    #Get Patients by id
    result = cur.execute("SELECT * FROM patients WHERE p_id=%s", [id])

    patient = cur.fetchone()


    #Get form
    form = PatientForm(request.form)

    #populate patient form fields
    form.p_name.data = patient['p_name']
    form.p_dob.data = patient['p_dob']
    form.p_age.data = patient['p_age']
    form.p_docname.data = patient['p_docname']
    form.p_gender.data = patient['p_gender']

    if request.method == 'POST' and form.validate():
        p_name = request.form['p_name']
        p_dob = request.form['p_dob']
        p_age = request.form['p_age']
        p_docname = request.form['p_docname']
        p_gender = request.form['p_gender']

        #Create cursor
        cur = mysql.connection.cursor()

        #Execute
        cur.execute("UPDATE patients SET p_name=%s, p_dob=%s, p_age=%s, p_docname=%s, p_gender=%s WHERE p_id = %s", (p_name,p_dob,p_age,p_docname,p_gender, id))

        #commit to DB
        mysql.connection.commit()

        #close connection
        cur.close()

        flash('Patient Edited','success')
        return redirect(url_for('patients'))
    return render_template('edit_patient.html',form=form)


#Delete Patient Route
@app.route('/delete_patient/<string:id>', methods=['POST'])
@is_logged_in
def delete_patient(id):
    #Create Cursor
    cur = mysql.connection.cursor()

    #Execute
    cur.execute("DELETE FROM patients WHERE p_id= %s", [id])

    #commit to DB
    mysql.connection.commit()

    #close connection
    cur.close()

    flash('Patient Deleted','success')
    return redirect(url_for('patients'))


#Admin Dashboard Route
@app.route('/admin')
@is_logged_in
def admin():
    return render_template('admin_dashboard.html')


# User Requests
@app.route('/user_requests')
@is_logged_in
def userRequests():

    # Create cursor
    cur = mysql.connection.cursor()

    result = cur.execute("SELECT * FROM user WHERE user_type='-1'")

    #Get Records in Tuple Format
    users = cur.fetchall()

    if result > 0:
        # Close Connection
        cur.close()
        return render_template('user_requests.html',users=users)
    else:
        # Close Connection
        cur.close()
        msg = 'No User Requests Found'
        return render_template('user_requests.html',msg=msg)


#Users Route for admin
@app.route('/user')
@is_logged_in
def user():
    #Create Cursor
    cur = mysql.connection.cursor()

    #Get User
    result = cur.execute("SELECT * FROM user WHERE user_type='0'")

    user = cur.fetchall()

    if result > 0:
        return render_template('users.html', user=user)

    else:
        msg = "No Users Found"
        return render_template('users.html' , msg=msg)

    #Close Connection
    cur.close()



# Delete User
@app.route('/delete_user_request/<string:id>',methods=['POST'])
@is_logged_in
def deleteUserRequest(id):
    # Create cursor
    cur = mysql.connection.cursor()

    # Execute
    cur.execute("DELETE from user WHERE id=%s",[id])

    # Commit to DB
    mysql.connection.commit()

    # Close Connection
    cur.close()

    flash('Request Deleted','success')

    return redirect(url_for('userRequests'))


#Delete User Route
@app.route('/delete_user/<string:id>', methods=['POST'])
@is_logged_in
def delete_user(id):
    #Create Cursor
    cur = mysql.connection.cursor()

    #Execute
    cur.execute("DELETE FROM user WHERE id= %s", [id])

    #commit to DB
    mysql.connection.commit()

    #close connection
    cur.close()

    flash('User Deleted','success')
    return redirect(url_for('user'))



# Accept User
@app.route('/user_requests/<string:id>',methods=['GET','POST'])
@is_logged_in
def acceptUser(id):

    if request.method == 'POST':
        # Create cursor
        cur = mysql.connection.cursor()
        # execute query
        result = cur.execute("SELECT email from user WHERE id=%s",[id])

        data = cur.fetchone()

        email = data['email']

        TEXT = "You're sign up request has been accepted"

        SUBJECT = "GPDC Application"

        message = 'Subject: {}\n\n{}'.format(SUBJECT, TEXT)
        #define gmail server
        server = smtplib.SMTP("smtp.gmail.com",587)
        #starts up server
        server.starttls()
        #app.logger.info(os.environ.get('Email'))
        server.login("fasahatkhan52@gmail.com","pqurfblbvmbepfvo")
        server.sendmail("fasahatkhan52@gmail.com",email,message)

        # execute query
        cur.execute("UPDATE user SET user_type='0' WHERE id=%s",[id])

        # Commit to DB
        mysql.connection.commit()

        # Close Connection
        cur.close()

        flash('Request Accepted','success')

        return redirect(url_for('userRequests'))


# Forgot Password
@app.route('/forgot',methods=['GET','POST'])
def forgot():
    form = ForgotForm(request.form)

    if request.method == 'POST' and form.validate():
        email = form.email.data
        # Create cursor
        cur = mysql.connection.cursor()
        # execute query
        result = cur.execute("SELECT * from user where email=%s",[email])

        data = cur.fetchone()

        if result > 0:

            token = str(uuid.uuid4())

            # execute query
            cur.execute("UPDATE user SET token=%s WHERE email=%s",(token,email))

            #commit to DB
            mysql.connection.commit()

            TEXT = "We received a request reset your password \n\n To reset your password, please click on this link:\n http://127.0.0.1:5000/reset/"+token

            SUBJECT = "Password reset request"

            message = 'Subject: {}\n\n{}'.format(SUBJECT, TEXT)
            #define gmail server
            server = smtplib.SMTP("smtp.gmail.com",587)
            #starts up server
            server.starttls()

            server.login("fasahatkhan52@gmail.com","pqurfblbvmbepfvo")
            server.sendmail("fasahatkhan52@gmail.com",email,message)
            # Close connection
            cur.close()
            msg = "You have received a password reset email"
            return render_template('forgot.html',form=form,msg=msg)
        else:
            # Close connection
            cur.close()
            error = "A user account with this email doesn't exist"
            return render_template('forgot.html',form=form,error=error)

    return render_template('forgot.html',form=form)

# reset Password
@app.route('/reset/<string:token>',methods=['GET','POST'])
def resetPassword(token):

    form = PasswordResetForm(request.form)

    # Start Connection
    cur = mysql.connection.cursor()

    # Execute query
    result = cur.execute("SELECT * from user WHERE token=%s",[token])

    if result > 0:
        if request.method == 'POST' and form.validate():
            # new password
            password = sha256_crypt.encrypt(str(form.password.data))

            # Execute query
            cur.execute("UPDATE user SET password=%s, token='' WHERE token=%s",(password,token))

            # commit to DB
            mysql.connection.commit()

            # close Connection
            cur.close()

            #send success message
            flash('Password successfully changed','success')

            return redirect(url_for('login'))
        return render_template('reset_password.html',form=form)

    else:
        # send danger message
        flash('Your token is invalid','danger')
        return redirect(url_for('login'))


# Patient List for Image Classification Route
@app.route('/classify')
@is_logged_in
def classify():
    #Create Cursor
    cur = mysql.connection.cursor()

    id = session['id']
    #Get Patients
    result = cur.execute("SELECT * FROM patients WHERE user_id=%s",[id])

    patients = cur.fetchall()

    if result > 0:
        return render_template('classify.html', patients=patients)

    else:
        msg = "No Patients Found"
        return render_template('classify.html' , msg=msg)

    #Close Connection
    cur.close()


#Classify Image Route
@app.route('/classify_image/<string:id>',methods = ['GET', 'POST'])
@is_logged_in
def classify_image(id):

    user_id = session['id']
    # Create cursor
    cur = mysql.connection.cursor()

    # execute query
    result = cur.execute("SELECT * FROM patients WHERE p_id=%s AND user_id=%s",(id,user_id))

    data = cur.fetchone()

    #To reject data not available in db(If user sends GET request from url)
    if data is None:
        # only initialized flash message
        flash("No Such Record Exists",'danger')
        return redirect(url_for('classify'))


    full_filename =  'img/no_image.PNG'
    # Execute if request is get
    if request.method == "GET":
        return render_template("classify_image.html", full_filename = full_filename)

    # Execute if reuqest is post
    if request.method == "POST":

         image_upload = request.files['image_upload']


         if not(image_upload):

             flash('No File Uploaded','danger')
             return render_template('classify_image.html',full_filename=full_filename)


         elif not(allowed_file(image_upload.filename)):

             flash('Only .png, .jpg, .jpeg file extensions allowed','danger')
             return render_template('classify_image.html',full_filename=full_filename)

         else:


             # Generating unique image name
             letters = string.ascii_lowercase
             name = ''.join(random.choice(letters) for i in range(10)) + '.png'
             full_filename =  'img/uploads/' + name

             # Reading, resizing, saving and preprocessing image for predicition
             imagename = image_upload.filename
             image = Image.open(image_upload)
             image = image.resize((32,32))
             img_path = os.path.join(app.config['INITIAL_FILE_UPLOADS'], name)
             image.save(img_path)
             pred = predict_label(img_path)

             #Execute
             cur.execute("INSERT INTO disease(patient_id,disease_name,image) VALUES(%s,%s,%s)", (id,pred,img_path))

             #commit to DB
             mysql.connection.commit()

             #get last row id (meaning the id of the record just inserted)
             disease_id = cur.lastrowid
             app.logger.info(disease_id)

             #close connection
             cur.close()


             # Returning template, filename, extracted text
             return render_template('classify_image.html', full_filename = full_filename, pred = pred,disease_id=disease_id)


#Classify Image Classification into PDF
@app.route('/gpdc_pdf/<string:id>')
@is_logged_in
def gpdc_pdf(id):

    user_id = session['id']
    # Create cursor
    cur = mysql.connection.cursor()

    # execute query
    result = cur.execute("SELECT * FROM disease WHERE disease_id=%s",[id])

    data = cur.fetchone()

    #To reject data not available in db(If user sends GET request from url)
    if data is None:
        # only initialized flash message
        flash("No Such Record Exists",'danger')
        return redirect(url_for('classify'))

    # execute query
    result = cur.execute("SELECT * FROM patients INNER JOIN disease ON patients.p_id=disease.patient_id WHERE disease.disease_id=%s AND patients.user_id=%s",(id,user_id))

    data = cur.fetchone()

    # keep in mind the code is not repeating it is necessary
    # for doctors to only select data of only their patients
    if data is None:
        # only initialized flash message
        flash("No Such Record Exists",'danger')
        return redirect(url_for('classify'))


    create_date = data['create_date']

    name=data['p_name']

    dob =  data['p_dob']

    age = data['p_age']

    gender = data['p_gender']

    disease_name = data['disease_name']

    #Close Connection
    cur.close()


    src = os.path.dirname(os.path.abspath(__file__))+'/'+data['image']#'/static/img/no_image.PNG'
    app.logger.info(src)
    rendered = render_template('gpdc_pdf.html',full_filename=src,name=name,dob=dob,age=age,gender=gender,time_added=create_date,pred=disease_name)
    options = {
  "enable-local-file-access": None
    }
    pdf = pdfkit.from_string(rendered,False,options=options)

    response = make_response(pdf)
    response.headers['Content-Type'] = 'application/pdf'
    response.headers['Content-Disposition'] = 'inline; output.pdf'

    return response



# Patient GPD Classification History
@app.route('/history/<string:id>')
@is_logged_in
def gpdc_history(id):

    user_id = session['id']
    # Create cursor
    cur = mysql.connection.cursor()

    # execute query
    result = cur.execute("SELECT * FROM patients WHERE p_id=%s AND user_id=%s",(id,user_id))

    data = cur.fetchone()

    #To reject data not available in db(If user sends GET request from url)
    if data is None:
        # only initialized flash message
        flash("No Such Record Exists",'danger')
        return redirect(url_for('classify'))

    #Get GPD History of a patient
    result = cur.execute("SELECT * FROM disease WHERE patient_id=%s ORDER BY create_date DESC",[id])

    history = cur.fetchall()

    if result > 0:
        #Close connection
        cur.close()
        return render_template('gpdc_history.html', history=history)

    else:
        #Close Connection
        cur.close()
        msg = "No History Found"
        return render_template('gpdc_history.html' , msg=msg)






if __name__ == '__main__':
    app.secret_key='secret123'
    app.run(debug=True)
