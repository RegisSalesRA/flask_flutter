from config import db


class Group(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=True, nullable=False)

    def to_json(self):
        return {
            "id": self.id,
            "name": self.name
        }


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(80), unique=False, nullable=False) 
    email = db.Column(db.String(120), unique=True, nullable=False)
    group_id = db.Column(db.Integer, db.ForeignKey('group.id'), nullable=False) 
    group = db.relationship('Group', backref=db.backref('users', lazy=True))

    def to_json(self):
        return {
            "id": self.id,
            "firstName": self.first_name, 
            "email": self.email,
            "group": self.group.to_json()
        }