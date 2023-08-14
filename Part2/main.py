import json
import os
import psycopg2
from google.cloud import compute_v1
from google.cloud.sql.connector import Connector, IPTypes
import pg8000
import sqlalchemy
from sqlalchemy import text


project_name = "devops-project-395513"
db_user = 'user'
db_password = 'password'
db_name = 'postgres'
db_instance_connection_name = 'db-connection-name'

def get_vpcs_networks(project_name):
    list_vpc_networks = []
    client = compute_v1.NetworksClient()
    # Project where the networks are located
    project = project_name
    # List the networks
    networks = client.list(project=project)
    # Print network details
    for network in networks:
      list_vpc_networks.append(network.name)

    return list_vpc_networks

def get_subnets(project_name):
    list_subnets = []
    client = compute_v1.NetworksClient()
# Project where the networks are located
    project = project_name
# List the networks
    networks = client.list(project=project)
# Print subnet names for each network
    for network in networks:
        for subnet in network.subnetworks:
            subnet_name = subnet.split('/')[-1]  # Extract the subnet name from the URL
            list_subnets.append(subnet_name)

    return list_subnets

def commit_to_db():
    db_user = 'user'
    db_password = 'password'
    db_name = 'postgres'
    db_instance_connection_name = 'db-connection-name'

    # Construct the connection string
    conn_string = f"host=/cloudsql/{db_instance_connection_name} dbname={db_name} user={db_user} password={db_password}"

    # Connect to the database
    conn = psycopg2.connect(conn_string)

    # Perform your database operations here

    # conn.commit()
    # Don't forget to close the connection when done
    conn.close()


# def connect_with_connector():
# initialize Cloud SQL Connector
# SQLAlchemy database connection creator function


# create SQLAlchemy connection pool
connector = Connector()

def getconn():
    conn = connector.connect(
        db_instance_connection_name, # Cloud SQL Instance Connection Name
        "pg8000",
        user=db_user,
        password=db_password,
        db=db_name,
        ip_type=IPTypes.PUBLIC # IPTypes.PRIVATE for private IP
    )
    return conn

def insert_into_psql(table_name, values):
    pool = sqlalchemy.create_engine(
        "postgresql+pg8000://",
        creator=getconn,
    )

    with pool.connect() as db_conn:
        for value in values:
            insert_statement = "INSERT INTO " + table_name + "(name) VALUES (" + "'" + value + "'" +")"
            insert = db_conn.execute(text(insert_statement))
            db_conn.commit()
    # close Cloud SQL Connector

vpc_list = get_vpcs_networks(project_name)
subnet_list = get_subnets(project_name)

insert_into_psql("vpc", vpc_list) 
insert_into_psql("subnet", subnet_list)
connector.close()

