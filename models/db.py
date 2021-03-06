# -*- coding: utf-8 -*-

#########################################################################
## This scaffolding model makes your app work on Google App Engine too
## File is released under public domain and you can use without limitations
#########################################################################

## if SSL/HTTPS is properly configured and you want all HTTP requests to
## be redirected to HTTPS, uncomment the line below:
# request.requires_https()

if not request.env.web2py_runtime_gae:
    ## if NOT running on Google App Engine use SQLite or other DB
    db = DAL('mysql://root:root@localhost/foodopedia')
else:
    ## connect to Google BigTable (optional 'google:datastore://namespace')
    db = DAL('google:datastore')
    ## store sessions and tickets there
    session.connect(request, response, db=db)
    ## or store session in Memcache, Redis, etc.
    ## from gluon.contrib.memdb import MEMDB
    ## from google.appengine.api.memcache import Client
    ## session.connect(request, response, db = MEMDB(Client()))

## by default give a view/generic.extension to all actions from localhost
## none otherwise. a pattern can be 'controller/function.extension'
response.generic_patterns = ['*'] if request.is_local else []
## (optional) optimize handling of static files
# response.optimize_css = 'concat,minify,inline'
# response.optimize_js = 'concat,minify,inline'

#########################################################################
## Here is sample code if you need for
## - email capabilities
## - authentication (registration, login, logout, ... )
## - authorization (role based authorization)
## - services (xml, csv, json, xmlrpc, jsonrpc, amf, rss)
## - old style crud actions
## (more options discussed in gluon/tools.py)
#########################################################################

from gluon.tools import Auth, Crud, Service, PluginManager, prettydate
auth = Auth(db)
auth.settings.extra_fields['auth_user']= [
  Field('profile_picture', 'upload',required=False),
  Field('gender', requires=IS_IN_SET(['Male', 'Female']),widget=SQLFORM.widgets.radio.widget),
  Field('country','string', length=512,required=False),
  Field('city','string', length=512,required=False),
  ]
crud, service, plugins = Crud(db), Service(), PluginManager()
auth.settings.formstyle='table3cols'
## create all tables needed by auth if not custom tables
auth.define_tables(username=False, signature=False)

## configure email
mail = auth.settings.mailer
mail.settings.server = 'smtp.gmail.com:587' 
mail.settings.sender = 'foodopediaac@gmail.com'
mail.settings.login = 'foodopediaac@gmail.com:psiloveyou'

## configure auth policy
auth.settings.registration_requires_verification = False
auth.settings.registration_requires_approval = False
auth.settings.reset_password_requires_verification = True
admin_email=['smita.kumari@students.iiit.ac.in','priyanka.rani@students.iiit.ac.in','kumarismita62@gmail.com']
## if you need to use OpenID, Facebook, MySpace, Twitter, Linkedin, etc.
## register with janrain.com, write your domain:api_key in private/janrain.key
from gluon.contrib.login_methods.rpx_account import use_janrain
use_janrain(auth, filename='private/janrain.key')
db.define_table('recepies',
                db.Field('category', 'string', length=128),
                db.Field('name', 'string', required=False,length=128),
                db.Field('slug', 'string', required=False, length=128),
                db.Field('image_loc', 'upload', required=False),
                db.Field('description','text'),
                db.Field('serves', 'string', length=512,required=True),
                db.Field('ingredients', 'string', length=2056,required=False),
                db.Field('cooking_time', 'string', length=128,required=True),
                db.Field('steps', 'text',required=True),
                db.Field('all_ingreds','string',length=1028,required=False),
                db.Field('added_by','integer',required=False),
                db.Field('approved','boolean',required=False),
                db.Field('avg_rating','integer',required=False,default=0),
                db.Field('fav_count','integer',required=False,default=0),
                migrate=False
                )
db.define_table('user_ratings',
                db.Field('id', 'integer'),
                db.Field('user_id','integer',required=True),
                db.Field('recipe_id','integer',required=True),
                db.Field('rating','integer',required=True,default=0),
                migrate=False
                )
db.define_table('user_favs',
                db.Field('id', 'integer'),
                db.Field('user_id','integer',required=True),
                db.Field('fav_list','text',required=True),
                migrate=False
                )
#########################################################################
## Define your tables below (or better in another model file) for example
##
## >>> db.define_table('mytable',Field('myfield','string'))
##
## Fields can be 'string','text','password','integer','double','boolean'
##       'date','time','datetime','blob','upload', 'reference TABLENAME'
## There is an implicit 'id integer autoincrement' field
## Consult manual for more options, validators, etc.
##
## More API examples for controllers:
##
## >>> db.mytable.insert(myfield='value')
## >>> rows=db(db.mytable.myfield=='value').select(db.mytable.ALL)
## >>> for row in rows: print row.id, row.myfield
#########################################################################

## after defining tables, uncomment below to enable auditing
# auth.enable_record_versioning(db)
import logging

logger = logging.getLogger(request.application)
logger.setLevel(logging.DEBUG)
# create file handler which logs even debug messages
fh = logging.FileHandler('spam.log')
fh.setLevel(logging.DEBUG)
# create console handler with a higher log level
ch = logging.StreamHandler()
ch.setLevel(logging.ERROR)
# create formatter and add it to the handlers
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
fh.setFormatter(formatter)
# add the handlers to logger
logger.addHandler(ch)
logger.addHandler(fh)

# 'application' code
#logger.debug('debug message')
#logger.info('info message')
#logger.warn('warn message')
#logger.error('error message')
#logger.critical('critical message')