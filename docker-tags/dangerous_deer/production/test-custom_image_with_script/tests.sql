-- Test some functionalities of the new image

\c postgres

create database ul;

\c ul

create extension postgis;

create extension postgis_topology;

-- create extension plpython2u;

create language plpython2u;

select version();

select postgis_full_version();

\i /postgis_test.sql

-- Test PL/Python

create function test_python()
returns void as
$$

    import sys
    plpy.warning("Python version:", sys.version_info)
    
$$
language plpython2u;

select test_python();