class_name ActionSerializer
extends Object

static func serialize_action(action : Action) -> String:
	var output : Dictionary = {}
	if action is HandAddCardAction:
		action = action as HandAddCardAction
		output["type"] = "HandAddCardAction"
		output["from_deck"] = action.from_deck
		output["specific_card"] = action.specific_card
		output["card_metadata_id"] = action.card_metadata_id
	return JSON.stringify(output)

static func deserialize_action(raw : String) -> Action:
	var data : Dictionary = JSON.parse_string(raw)
	match(data["type"]):
		"HandAddCardAction":
			return HandAddCardAction.new(
				data["from_deck"], 
				data["specific_card"], 
				data["card_metadata_id"]
			)
	return null