extends Node

var functions = {}


func add(node, func_name):
	functions[func_name] = funcref(node, func_name)

func call(func_name, args=null):
	if args != null: return getf(func_name).call_func(args)
	else:		     return getf(func_name).call_func()

func getf(func_name):
	return functions[func_name]
