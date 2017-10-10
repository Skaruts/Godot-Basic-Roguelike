# AutoLoaded script
extends Node

var took_turn = true
var current_dungeon = null
var player = null
var world = null
var dungeon = null

#######################################################
# Global callback functions
# -----------------------------------------------------
var functions = {}

func addf(node, fname):
	functions[fname] = funcref(node, fname)

func callf(fname, args=null):
	if args != null: return getf(fname).call_func(args)
	else:		     return getf(fname).call_func()

func getf(fname):
	return functions[fname]


#######################################################
# Global nodes storage
# -----------------------------------------------------
var nodes = {}

func add(node, name):
	nodes[name] = node

func set(node, name):
	if nodes.has(name):
		nodes[name] = node
	else:
		print("ERROR: node doesn't exist in dict. To create a new one, use add().")

func get(name):
	return nodes[name]









