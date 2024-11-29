from flask import Flask, jsonify, request
import pyodbc

# Flask app setup
app = Flask(__name__)

# Database configuration
DATABASE_CONFIG = {
    'server': 'localhost',
    'database': 'SoccerDB',
    'driver': 'ODBC Driver 17 for SQL Server',
    'trusted_connection': 'yes'  # This enables Windows Authentication
}

# Function to create a database connection
def get_db_connection():
    conn_str = (
        f"Driver={{{DATABASE_CONFIG['driver']}}};"
        f"Server={DATABASE_CONFIG['server']};"
        f"Database={DATABASE_CONFIG['database']};"
        f"Trusted_Connection={DATABASE_CONFIG['trusted_connection']};"
    )
    return pyodbc.connect(conn_str)

# CRUD for Player
# GET
@app.route('/api/player', methods=['GET'])
def get_player():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM dbo.Player")
        rows = cursor.fetchall()
        players = []
        for row in rows:
            players.append({'player_id': row[0], 'name': row[1], 'age': row[2], 'nationality': row[3], 'position': row[4], 'overall_rating': row[5]})  # Adjust columns as per your table
        cursor.close()
        conn.close()

        return jsonify(players)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# POST
@app.route('/api/players', methods=['POST'])
def create_player():
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO dbo.Player (name, age, nationality, position, overall_rating) VALUES (?, ?, ?, ?, ?)",
        (data['name'], data['age'], data['nationality'], data['position'], data['overall_rating'])
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'Player created successfully'}), 201

# PUT
@app.route('/api/players/<int:player_id>', methods=['PUT'])
def update_player(player_id):
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE dbo.Player SET name = ?, age = ?, nationality = ?, position = ?, overall_rating = ? WHERE player_id = ?",
        (data['name'], data['age'], data['nationality'], data['position'], data['overall_rating'], player_id)
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'Player updated successfully'})

# DELETE
@app.route('/api/players/<int:player_id>', methods=['DELETE'])
def delete_player(player_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM dbo.Player WHERE player_id = ?", (player_id,))
    conn.commit()
    conn.close()
    return jsonify({'message': 'Player deleted successfully'})

# CRUD for GameMatch
# GET
@app.route('/api/gamematches', methods=['GET'])
def get_gamematches():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM dbo.GameMatch")
    matches = [
        {'match_id': row[0], 'date': row[1], 'home_team_id': row[2], 'away_team_id': row[3], 'home_score': row[4], 'away_score': row[5], 'attendance': row[6]}
        for row in cursor.fetchall()
    ]
    conn.close()
    return jsonify(matches)

# POST
@app.route('/api/gamematches', methods=['POST'])
def create_gamematch():
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO dbo.GameMatch (date, home_team_id, away_team_id, home_score, away_score, attendance) VALUES (?, ?, ?, ?, ?, ?)",
        (data['date'], data['home_team_id'], data['away_team_id'], data['home_score'], data['away_score'], data['attendance'])
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'GameMatch created successfully'}), 201

# PUT
@app.route('/api/gamematches/<int:match_id>', methods=['PUT'])
def update_gamematch(match_id):
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE dbo.GameMatch SET date = ?, home_team_id = ?, away_team_id = ?, home_score = ?, away_score = ?, attendance = ? WHERE match_id = ?",
        (data['date'], data['home_team_id'], data['away_team_id'], data['home_score'], data['away_score'], data['attendance'], match_id)
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'GameMatch updated successfully'})

# DELETE
@app.route('/api/gamematches/<int:match_id>', methods=['DELETE'])
def delete_gamematch(match_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM dbo.GameMatch WHERE match_id = ?", (match_id,))
    conn.commit()
    conn.close()
    return jsonify({'message': 'GameMatch deleted successfully'})

# CRUD for League
# GET
@app.route('/api/leagues', methods=['GET'])
def get_leagues():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM dbo.League")
    leagues = [{'league_id': row[0], 'league_name': row[1], 'country_id': row[2]} for row in cursor.fetchall()]
    conn.close()
    return jsonify(leagues)

# POST
@app.route('/api/leagues', methods=['POST'])
def create_league():
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO dbo.League (league_name, country_id) VALUES (?, ?)",
        (data['league_name'], data['country_id'])
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'League created successfully'}), 201

# PUT
@app.route('/api/leagues/<int:league_id>', methods=['PUT'])
def update_league(league_id):
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE dbo.League SET league_name = ?, country_id = ? WHERE league_id = ?",
        (data['league_name'], data['country_id'], league_id)
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'League updated successfully'})

# DELETE
@app.route('/api/leagues/<int:league_id>', methods=['DELETE'])
def delete_league(league_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM dbo.League WHERE league_id = ?", (league_id,))
    conn.commit()
    conn.close()
    return jsonify({'message': 'League deleted successfully'})

# CRUD for PlayerStatistics
# GET
@app.route('/api/playerstatistics', methods=['GET'])
def get_player_statistics():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM dbo.PlayerStatistics")
    stats = [
        {'player_stats_id': row[0], 'player_id': row[1], 'match_id': row[2], 'minutes_played': row[3], 'goals_scored': row[4], 'assists': row[5]}
        for row in cursor.fetchall()
    ]
    conn.close()
    return jsonify(stats)

# POST
@app.route('/api/playerstatistics', methods=['POST'])
def create_player_statistics():
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO dbo.PlayerStatistics (player_id, match_id, minutes_played, goals_scored, assists) VALUES (?, ?, ?, ?, ?)",
        (data['player_id'], data['match_id'], data['minutes_played'], data['goals_scored'], data['assists'])
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'PlayerStatistics created successfully'}), 201

# PUT
@app.route('/api/playerstatistics/<int:player_stats_id>', methods=['PUT'])
def update_player_statistics(player_stats_id):
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE dbo.PlayerStatistics SET player_id = ?, match_id = ?, minutes_played = ?, goals_scored = ?, assists = ? WHERE player_stats_id = ?",
        (data['player_id'], data['match_id'], data['minutes_played'], data['goals_scored'], data['assists'], player_stats_id)
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'PlayerStatistics updated successfully'})

# DELETE
@app.route('/api/playerstatistics/<int:player_stats_id>', methods=['DELETE'])
def delete_player_statistics(player_stats_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM dbo.PlayerStatistics WHERE player_stats_id = ?", (player_stats_id,))
    conn.commit()
    conn.close()
    return jsonify({'message': 'PlayerStatistics deleted successfully'})

# CRUD for Team
# GET
@app.route('/api/teams', methods=['GET'])
def get_teams():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM dbo.Team")
    teams = [
        {'team_id': row[0], 'team_name': row[1], 'league_id': row[2], 'manager_id': row[3], 'stadium_id': row[4]}
        for row in cursor.fetchall()
    ]
    conn.close()
    return jsonify(teams)

# POST
@app.route('/api/teams', methods=['POST'])
def create_team():
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO dbo.Team (team_name, league_id, manager_id, stadium_id) VALUES (?, ?, ?, ?)",
        (data['team_name'], data['league_id'], data['manager_id'], data['stadium_id'])
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'Team created successfully'}), 201

# PUT
@app.route('/api/teams/<int:team_id>', methods=['PUT'])
def update_team(team_id):
    data = request.json
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE dbo.Team SET team_name = ?, league_id = ?, manager_id = ?, stadium_id = ? WHERE team_id = ?",
        (data['team_name'], data['league_id'], data['manager_id'], data['stadium_id'], team_id)
    )
    conn.commit()
    conn.close()
    return jsonify({'message': 'Team updated successfully'})

# DELETE
@app.route('/api/teams/<int:team_id>', methods=['DELETE'])
def delete_team(team_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM dbo.Team WHERE team_id = ?", (team_id,))
    conn.commit()
    conn.close()
    return jsonify({'message': 'Team deleted successfully'})

# to run application
if __name__ == '__main__':
    app.run(debug=True)
