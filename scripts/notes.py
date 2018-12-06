import os, sys, getopt, argparse
from termcolor import colored

def build_arguments(): 
  parser = argparse.ArgumentParser()
  parser.add_argument('-g', '--grep', help="Pass a string to search the notes directory", type=str)
  parser.add_argument('-a', '--a', help="Pass the action you would like the run on your notes.", type=str)
  args = parser.parse_args()
  return args

if __name__ == '__main__':
  args = build_arguments() 
  os.chdir(os.path.expanduser("~/notes"))
  notes = os.listdir()
  menu_number = 1
  print(colored("Notes:", 'green'))
  for note in notes:
    menustring = str(str(menu_number) + ')').strip()
    if not note.startswith("."):
      if args.grep:
        if args.grep in note:
          print(menustring, note)
          menu_number += 1
      else:
        print(menustring, note)
        menu_number += 1
