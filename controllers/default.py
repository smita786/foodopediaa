
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
    response.flash = T("Welcome to web2py!")
    h=sayhello()
    return dict(message=h)

def sayhello():
    return "Hello There!!";
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
        db.recepies.insert(category=json.dumps(request.vars.category),name=request.vars.name,slug=request.vars.slug,description=request.vars.description,cooking_time=request.vars.c_time,serves=request.vars.serves,steps=request.vars.steps,ingredients=encoded_ingreds,image_loc=image,all_ingreds=all_ingreds)
        #db.mytable.insert(myfield=request.vars.category)
        #return encoded_ingreds
    return dict()
    
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
    return dict()
    
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
    return dict(form=auth())

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
