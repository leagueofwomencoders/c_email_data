# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
from datetime import datetime

from project_globals import Base,metadata,get_scoped_session

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship

class Persons(Base, db.Model):
    __tablename__ = 'persons'
    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String(100),default=None)

class Aliases(Base, db.Model):
    __tablename__ = 'aliases'
    id = Column(Integer, primary_key=True, nullable=False)
    alias = Column(String(100),default=None)
    person_id = Column(Integer,ForeignKey(Persons.id), nullable=False,default=0)

class Emails(Base, db.Model):
    __tablename__ = 'emails'
    id = Column(Integer, primary_key=True, nullable=False)
    doc_number = Column(String(100),default=None)
    metadata_subject = Column(String(400),default=None)
    metadata_to = Column(String(100),default=None)
    metadata_from = Column(String(100),default=None)
    sender_person_id = Column(Integer,ForeignKey(Persons.id), nullable=False,default=0)
    metadata_date_sent = Column(DateTime, nullable=True, default=None)
    metadata_date_released = Column(DateTime, nullable=True, default=None)
    metadata_pdf_link = Column(String(200),default=None)
    metadata_case_number = Column(String(100),default=None)
    metadata_document_class = Column(String(100),default=None)
    extracted_subject = Column(String(400),default=None)
    extracted_to = Column(String(100),default=None)
    extracted_from = Column(String(100),default=None)
    extracted_cc = Column(String(100),default=None)
    extracted_date_sent = Column(DateTime, nullable=True, default=None)
    extracted_case_number = Column(String(100),default=None)
    extracted_doc_number = Column(String(100),default=None)
    extracted_date_released = Column(DateTime, nullable=True, default=None)
    in_full = Column(Boolean, nullable=False, default=True) # False = in part
    extracted_body_text = Column(Text,default=None)
    raw_text = Column(Text,default=None)

class EmailReceiverss(Base, db.Model):
    __tablename__ = 'email_receivers'
    id = Column(Integer, primary_key=True, nullable=False)
    email_id = Column(Integer,ForeignKey(Emails.id), nullable=False,default=0)
    person_id = Column(Integer,ForeignKey(Persons.id), nullable=False,default=0)
