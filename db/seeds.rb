#ZM: This could be dried up allooottttttttt

Room.create([{name: "Atlantis"},
             {name: "Thread"},
             {name: "String"},
             {name: "Kernel"},
             {name: "Object"}])

#ZM: try not to seed in groups like this
#zack = User.create({})
#
#Appoitment.create(user: zack)
#
User.create([{first_name: 'Hoa',
              last_name: 'Nguyen',
              email_address: 'hoathenguyen85@gmail.com',
              password: 'password123',
              position: 'Student'},
             {first_name: 'Tara',
              last_name: 'Frye',
              email_address: 'suprfrye@gmail.com',
              password: 'password123',
              position: 'Student'},
             {first_name: 'Eveanandi',
              last_name: 'Butler',
              email_address: 'ebutler90@gmail.com',
              password: 'password123',
              position: 'Student'},
             {first_name: 'Max',
              last_name: 'Rater',
              email_address: 'maxrater@gmail.com',
              password: 'password123',
              position: 'Student'}])

Group.create(name: 'METH',
              user_id: User.find_by(email_address: 'ebutler90@gmail.com').id,
              users: [User.find_by(email_address: 'hoathenguyen85@gmail.com'),
                     User.find_by(email_address: 'suprfrye@gmail.com'),
                     User.find_by(email_address: 'ebutler90@gmail.com'),
                     User.find_by(email_address: 'maxrater@gmail.com')])

Appointment.create([{room: Room.find_by(name: 'Atlantis'),
                     group: Group.find_by(name: 'METH'),
                     start_datetime: DateTime.parse('2015-03-25 10:10AM'),
                     end_datetime: DateTime.parse('2015-03-25 11:10AM')}])
