#!/bin/bash

# Set ups the database

PGPASSWORD=$PASSWORD psql -h localhost -p 5432 -U postgres -f "tests.sql" postgres
