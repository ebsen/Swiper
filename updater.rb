#!/usr/bin/env ruby -wKU
require "open-uri"
require "sqlite3"

# Set up some handy local variables.
db                 = SQLite3::Database.open "extension_data.db"
db.results_as_hash = true
dept_names = []

db.execute "SELECT _id FROM Departments"

db.execute "SELECT department, office_1, office_2, office_4, office_4 FROM people" do |row|
  department_id = db.get_first_value "SELECT _id FROM Departments WHERE name = %s" % row['department']
  db.execute "UPDATE People SET department = #{department_id} WHERE department = #{row['department']}" 
end
