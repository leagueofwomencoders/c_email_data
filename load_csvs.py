import csv

from project_globals import get_scoped_session
from models import Aliases, Persons, Emails, EmailReceivers

OBJ_MAP = {
    'Persons' : Persons,
    'Aliases' : Aliases,
    'Emails' : Emails,
    'EmailReceivers' : EmailReceivers
    }

local_db_session = get_scoped_session()

for obj in ['Persons','Emails','Aliases','EmailReceivers']:
    with open('./' + obj + '.csv') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            if obj == 'Emails':
                row['in_full'] = True if 'FULL' in row['in_full'] else False

            try:
                newobj = OBJ_MAP[obj](**row)
                local_db_session.add(newobj)
                local_db_session.commit()
                local_db_session.begin()
            except:
                import pdb;pdb.set_trace()
                print "Here..."
            
local_db_session.commit()
