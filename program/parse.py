import sys

def not_empty_string(string):
  return not string.strip() == ""

def is_2012(string):
  return "('12)" in string
  
def rm_comma(x):
  x = x.strip()
  if x[-1] == ",":
    if x[-2] == ",":
      return x[:-2]
    return x[:-1]
  return x

def parsed_student(string, i):
  email = string.split(" ")[-1].strip()
  if "." in email: email = "TODO"+str(i)
  def last_name_idx(name_list):
    for i,n in enumerate(name_list):
      if n[-1] == ",": return i
  def clean_first(name_list):
    #name_list = map(rm_comma, name_list)
    the_first = lambda x: x not in ["Jr.", "II", "III", "IV", "V", "VI", "VII", "VIII"]
    return filter(the_first, name_list)
  def clean_name(name_list):
    name_list.pop(-1)
    name_list.pop(0)
    name_list.pop(0)
    name_list = filter(not_empty_string, name_list)
    last = last_name_idx(name_list)
    name_list = map(rm_comma, name_list)
    return " ".join(clean_first(name_list[last+1:]))+" "+(" ".join(name_list[0:last+1]))
  return "{0},{1}\n".format(email, clean_name(string.split("(")[0].split(" ")[1:]))

if __name__ == "__main__":
  with open(sys.argv[1]) as f:
    students = filter(is_2012, filter(not_empty_string, f.read().split("\n")))
    out = open("out.csv", "w")
    for i,s in enumerate(students):
      out.write(parsed_student(s,i))
    out.close()
      
    