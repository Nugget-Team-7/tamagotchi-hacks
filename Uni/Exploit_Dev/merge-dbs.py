import sqlite3
import os


def merge_databases(db1, db2):
    con3 = sqlite3.connect(db1)

    con3.execute("ATTACH '" + db2 +  "' as dba")

    con3.execute("BEGIN")
    for row in con3.execute("SELECT * FROM dba.sqlite_master WHERE type='table'"):
        combine = "INSERT OR IGNORE INTO "+ row[1] + " SELECT * FROM dba." + row[1]
        print(combine)
        con3.execute(combine)
    con3.commit()
    con3.execute("detach database dba")


def read_files(directory):
    fname = []
    for root,d_names,f_names in os.walk(directory):
        for f in f_names:
            c_name = os.path.join(root, f)
            filename, file_extension = os.path.splitext(c_name)
            if (file_extension == '.sqlitedb' or file_extension == '.db'):
                fname.append(c_name)

    return fname

def batch_merge(directory):
    db_files = read_files(directory)
    for db_file in db_files[1:]:
        merge_databases(db_files[0], db_file)

if __name__ == '__main__':
    batch_merge('/home/kali/Tamas/boofuzz-results2')
