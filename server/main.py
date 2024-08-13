from flask import request, jsonify
from config import app, db
from model import Contact, Group

@app.route("/groups", methods=["GET"])
def get_groups():
    groups = Group.query.all()
    json_groups = list(map(lambda x: x.to_json(), groups))
    return jsonify({"groups": json_groups})


@app.route("/create_group", methods=["POST"])
def create_group():
    name = request.json.get("name")

    if not name:
        return jsonify({"message": "Group name is required"}), 400

    new_group = Group(name=name)

    try:
        db.session.add(new_group)
        db.session.commit()
    except Exception as e:
        return jsonify({"message": str(e)}), 400

    return jsonify({"message": "Group created!"}), 201


@app.route("/update_group/<int:group_id>", methods=["PATCH"])
def update_group(group_id):
    group = Group.query.get(group_id)

    if not group:
        return jsonify({"message": "Group not found"}), 404

    data = request.json
    group.name = data.get("name", group.name)

    db.session.commit()
    return jsonify({"message": "Group updated"}), 200


@app.route("/delete_group/<int:group_id>", methods=["DELETE"])
def delete_group(group_id):
    group = Group.query.get(group_id)

    if not group:
        return jsonify({"message": "Group not found"}), 404

    db.session.delete(group)
    db.session.commit()
    return jsonify({"message": "Group deleted!"}), 200


@app.route("/contacts", methods=["GET"])
def get_contacts():
    contacts = Contact.query.all()
    json_contacts = list(map(lambda x: x.to_json(), contacts))
    return jsonify({"contacts": json_contacts})


@app.route("/create_contact", methods=["POST"])
def create_contact():
    first_name = request.json.get("firstName")
    last_name = request.json.get("lastName")
    email = request.json.get("email")
    group_id = request.json.get("groupId")

    if not first_name or not last_name or not email or not group_id:
        return jsonify({"message": "First name, last name, email, and group ID are required"}), 400

    group = Group.query.get(group_id)
    if not group:
        return jsonify({"message": "Invalid group ID"}), 400

    new_contact = Contact(first_name=first_name, last_name=last_name, email=email, group_id=group_id)

    try:
        db.session.add(new_contact)
        db.session.commit()
    except Exception as e:
        return jsonify({"message": str(e)}), 400

    return jsonify({"message": "Contact created!"}), 201


@app.route("/update_contact/<int:user_id>", methods=["PATCH"])
def update_contact(user_id):
    contact = Contact.query.get(user_id)

    if not contact:
        return jsonify({"message": "Contact not found"}), 404

    data = request.json
    contact.first_name = data.get("firstName", contact.first_name)
    contact.last_name = data.get("lastName", contact.last_name)
    contact.email = data.get("email", contact.email)
    contact.group_id = data.get("groupId", contact.group_id)

    db.session.commit()
    return jsonify({"message": "Contact updated"}), 200


@app.route("/update_contact/<int:user_id>", methods=["DELETE"])
def delete_contact(user_id):
    contact = Contact.query.get(user_id)

    if not contact:
        return jsonify({"message": "Contact not found"}), 404

    db.session.delete(contact)
    db.session.commit()
    return jsonify({"message": "Contact deleted!"}), 200


if __name__ == "__main__":
    with app.app_context():
        db.create_all()

    app.run(debug=True)
