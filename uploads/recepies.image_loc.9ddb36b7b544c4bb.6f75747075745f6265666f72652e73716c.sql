CREATE TABLE auth_user(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name CHAR(128),
    last_name CHAR(128),
    email CHAR(512),
    password CHAR(512),
    registration_key CHAR(512),
    reset_password_key CHAR(512),
    registration_id CHAR(512)
);
CREATE TABLE auth_group(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    role CHAR(512),
    description TEXT
);
CREATE TABLE auth_membership(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER REFERENCES auth_user (id) ON DELETE CASCADE,
    group_id INTEGER REFERENCES auth_group (id) ON DELETE CASCADE
);
CREATE TABLE auth_permission(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER REFERENCES auth_group (id) ON DELETE CASCADE,
    name CHAR(512),
    table_name CHAR(512),
    record_id INTEGER
);
CREATE TABLE auth_event(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    time_stamp TIMESTAMP,
    client_ip CHAR(512),
    user_id INTEGER REFERENCES auth_user (id) ON DELETE CASCADE,
    origin CHAR(512),
    description TEXT
);
CREATE TABLE auth_cas(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER REFERENCES auth_user (id) ON DELETE CASCADE,
    created_on TIMESTAMP,
    service CHAR(512),
    ticket CHAR(512),
    renew CHAR(1)
);
