extends Node

var functions = {}


func add(node, func_name):
	functions[func_name] = funcref(node, func_name)

func call(func_name, args):
	functions[func_name].call_func(args)
