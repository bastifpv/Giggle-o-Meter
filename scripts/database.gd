extends Node

var db : SQLite = null

const verbosity_level : int = SQLite.VERBOSE

var db_name := "res://data/cards"

func sql_query(query):
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	
	# Do a normal query
	db.query(query)
	#print(db.query_result)

	# Close the current database
	db.close_db()
	
	return db.query_result
	
func get_card_info(cardID):
	var cardInfo = sql_query("SELECT * FROM cards WHERE cardID = " + str(cardID) + ";")
	#print(cardInfo)
	return cardInfo
	
func pick_random_cards():
	var cards = sql_query("SELECT * FROM cards ORDER BY RANDOM() LIMIT 3;")
	#print(cards)
	return cards

