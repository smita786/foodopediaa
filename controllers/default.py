
# -*- coding: utf-8 -*-
# this file is released under public domain and you can use without limitations

#########################################################################
## This is a sample controller
## - index is the default action of any application
## - user is required for authentication and authorization
## - download is for downloading files uploaded in the db (does streaming)
## - call exposes all registered services (none by default)
#########################################################################
import json
import string
def index():
    """
    example action using the internationalization operator T and flash
    rendered by views/default/index.html or views/generic.html

    if you need a simple wiki simply replace the two lines below with:
    return auth.wiki()
    """
    #response.flash = T("Welcome to web2py!")
    h=sayhello()
    return dict(message=h)

def sayhello():
    return "Hello There!!";
@auth.requires_login()
def add_recipe():
    if request.vars:
        response.flash = T("Successfully Added!!")
        res=[]
        for ingred,quant,measure in zip(request.vars.ingredients,request.vars.quantity,request.vars.measure):
            tmp=[ingred,quant,measure]
            res.append(tmp)
        encoded_ingreds = json.dumps(res)
        all_ingreds=json.dumps(request.vars.ingredients)
        #filename=request.vars.pic
        image = db.recepies.image_loc.store(request.vars.pic.file, request.vars.pic.filename)
        db.recepies.insert(category=json.dumps(request.vars.category),name=request.vars.name,slug=request.vars.slug,description=request.vars.description,cooking_time=request.vars.c_time,serves=request.vars.serves,steps=request.vars.steps,ingredients=encoded_ingreds,image_loc=image,all_ingreds=all_ingreds,added_by=auth.user.id,approved=0)
        mail.send(admin_email[0],
            '[Approve] New recipe added',
            '<html>New recipe has been added by <b>'+auth.user.email+'</b>, Details are as follows<br>\
            <b>name</b>:'+request.vars.name+'<br><b>Description:</b>'+request.vars.description+'<br><b>Ingredients:</b>'+" , ".join(request.vars.ingredients)+'<br><b>Cooking method:</b>'+request.vars.steps+'<br><b>Image Url:</b><a href="'+URL('download',args=image,host=True)+'">'+URL('download',args=image,host=True)+'</a><br>\
            <br>Click this link <a href="'+URL('default',"approve/"+request.vars.slug,host=True)+'">'+URL('default',"approve/"+request.vars.slug,host=True)+'</a> to approve<br><br>Regards<br>Team foodopedia</html>',
            cc=admin_email
            )
    return dict()
def approve():
    if request.args:
        slug1=request.args[0]
        #logger.info(slug1)
        if auth.user.email in admin_email:
            db(db.recepies.slug == slug1).update(approved=1)
        else:
            raise HTTP(404, "You are not authorized!!") 
        return 1;
        
def search():
    if request.vars:
        res=[]
        res_extra=[]
        search_terms=[word.strip(string.punctuation) for word in request.vars.ingredients.split(",")]
        logger.info(search_terms)
        q = request.vars.category
        logger.info(q)
        if q:
            if not isinstance(q, basestring):
                query1 = ( # Start off with a default query
                              db.recepies.category.lower().like('%'+q[0]+'%') 
                )

                for category in q:
                    query1 = query1 | db.recepies.category.lower().like('%'+category+'%')
            else:
                query1 = ( 
                              db.recepies.category.lower().like('%'+q+'%')
                )
        # Then run through each element, and search for that specific word in the test.
        ingredients=[x.strip() for x in request.vars.ingredients.split(',')]
        if request.vars.ingredients:
            query=( # Start off with a default query
                          db.recepies.ingredients.lower().like('%'+ingredients[0]+'%') 
            )
        if len(ingredients)>1:
            for qs in filter(lambda a: a != '', ingredients):
                query = query | db.recepies.ingredients.lower().like('%'+qs.strip()+'%')
        if 'query1' in locals():
            if 'query' in locals():
                query=query1&query
            else:
                query=query1
        
        rows = db(query).select()
       # logger.info(rows)
        if request.vars.ingredients:
            for row in rows:
                logger.info(row.all_ingreds)
                if row.all_ingreds and set(json.loads(row.all_ingreds)) <= set(ingredients):
                    logger.info("got")
                    res.append(row)
                else:
                   res_extra.append(row)
            res_extra.sort(key = lambda row: row.cooking_time)
            res.sort(key = lambda row: row.cooking_time)
            return dict(primary_res=res,extra_res=res_extra,query=ingredients)
        return dict(primary_res=rows,extra_res=res_extra,query=ingredients)
    redirect(URL('default','index'))
    
def recipes():
    if request.args:
        slug=request.args[0]
        query=(
                          db.recepies.slug.lower().like(slug) 
            )
        rows = db(query).select()
        if rows:
            if auth.is_logged_in():
                rated=db(db.user_ratings.user_id==auth.user.id and db.user_ratings.recipe_id==rows[0].id).select(db.user_ratings.rating)
            rating_count=db(db.user_ratings.recipe_id==rows[0].id).select(db.user_ratings.id.count())
            if 'rated' in locals() and rated:
                rated=rated[0].rating
            else:
                rated=0
            return dict(slug=slug,res=rows[0],rated=rated,rating_count=rating_count[0]['COUNT(user_ratings.id)'])
        raise HTTP(404, "Page not found!!") 
    raise HTTP(404, "Page not found!!") 

def update_rating():
    if request.vars.value:
        db.user_ratings.insert(user_id=auth.user.id,recipe_id=request.vars.r_id,rating=request.vars.value)
        rows=db(db.user_ratings.recipe_id == request.vars.r_id).select(db.user_ratings.rating.sum(),db.user_ratings.rating.count())
        logger.info(rows)
        for row in rows:
            avg_rating=int(round(row['SUM(user_ratings.rating)']/float(row['COUNT(user_ratings.rating)'])))
            db(db.recepies.id==request.vars.r_id).update(avg_rating=avg_rating)
        logger.info("update rating func")
        return avg_rating
    raise HTTP(404, "Page not found!!") 

def feedback():
    if request.vars.email:
        mail.send(admin_email[0],
            '[Feedback] feedback from '+request.vars.email,
            '<html>'+request.vars.feedtext.replace('\n', '<br/>')+'</html>',
            cc=admin_email
            )
        return 1
    raise HTTP(404, "Page not found!!") 
def user():
    """
    exposes:
    http://..../[app]/default/user/login
    http://..../[app]/default/user/logout
    http://..../[app]/default/user/register
    http://..../[app]/default/user/profile
    http://..../[app]/default/user/retrieve_password
    http://..../[app]/default/user/change_password
    http://..../[app]/default/user/manage_users (requires membership in
    use @auth.requires_login()
        @auth.requires_membership('group name')
        @auth.requires_permission('read','table name',record_id)
    to decorate functions that need access control
    """
    db.auth_user.email.widget = lambda f,v: SQLFORM.widgets.string.widget(f, v,
    _placeholder='Enter your email address')
    if request.vars.signin:
        return dict(form=auth(),signin=True)
    return dict(form=auth(),signin=False)
        
@cache.action()
def download():
    """
    allows downloading of uploaded files
    http://..../[app]/default/download/[filename]
    """
    return response.download(request, db)


def call():
    """
    exposes services. for example:
    http://..../[app]/default/call/jsonrpc
    decorate with @services.jsonrpc the functions to expose
    supports xml, json, xmlrpc, jsonrpc, amfrpc, rss, csv
    """
    return service()


@auth.requires_signature()
def data():
    """
    http://..../[app]/default/data/tables
    http://..../[app]/default/data/create/[table]
    http://..../[app]/default/data/read/[table]/[id]
    http://..../[app]/default/data/update/[table]/[id]
    http://..../[app]/default/data/delete/[table]/[id]
    http://..../[app]/default/data/select/[table]
    http://..../[app]/default/data/search/[table]
    but URLs must be signed, i.e. linked with
      A('table',_href=URL('data/tables',user_signature=True))
    or with the signed load operator
      LOAD('default','data.load',args='tables',ajax=True,user_signature=True)
    """
    return dict(form=crud())
