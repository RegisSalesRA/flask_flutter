from flask import request, jsonify
from config import app, db
from model import Group, User

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


@app.route("/users", methods=["GET"])
def get_users():
    users = User.query.all()
    json_users = list(map(lambda x: x.to_json(), users))
    return jsonify({"users": json_users})


@app.route("/create_user", methods=["POST"])
def create_user():
    first_name = request.json.get("firstName") 
    email = request.json.get("email")
    group_id = request.json.get("groupId")

    if not first_name  or not email or not group_id:
        return jsonify({"message": "First name, last name, email, and group ID are required"}), 400

    group = Group.query.get(group_id)
    if not group:
        return jsonify({"message": "Invalid group ID"}), 400

    new_user = User(first_name=first_name,  email=email, group_id=group_id)

    try:
        db.session.add(new_user)
        db.session.commit()
    except Exception as e:
        return jsonify({"message": str(e)}), 400

    return jsonify({"message": "User created!"}), 201


@app.route("/update_user/<int:user_id>", methods=["PATCH"])
def update_user(user_id):
    user = User.query.get(user_id)

    if not user:
        return jsonify({"message": "User not found"}), 404

    data = request.json
    user.first_name = data.get("firstName", user.first_name) 
    user.email = data.get("email", user.email)
    user.group_id = data.get("groupId", user.group_id)
    db.session.commit()
    return jsonify({"message": "User updated"}), 200


@app.route("/delete_user/<int:user_id>", methods=["DELETE"])
def delete_user(user_id):
    user = User.query.get(user_id)

    if not user:
        return jsonify({"message": "User not found"}), 404

    db.session.delete(user)
    db.session.commit()
    return jsonify({"message": "User deleted!"}), 200


@app.route("/filter_users_by_group", methods=["GET"])
def filter_users_by_group():
    group_name = request.args.get("groupName")  
    
    if not group_name:
        return jsonify({"message": "Group name is required"}), 400
 
    group = Group.query.filter_by(name=group_name).first()

    if not group:
        return jsonify({"message": "Group not found"}), 404
 
    users = User.query.filter_by(group_id=group.id).all()

    json_users = list(map(lambda x: x.to_json(), users))
    return jsonify({"users": json_users}), 200

if __name__ == "__main__":
    with app.app_context():
        db.create_all()

    app.run(host="0.0.0.0", port=5000, debug=True)
