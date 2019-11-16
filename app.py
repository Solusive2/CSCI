from flask import Flask, request, Response, render_template
import requests
import itertools
from flask_wtf.csrf import CSRFProtect
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField
from wtforms.validators import*
import re
import sys

class WordForm(FlaskForm):
    avail_letters = StringField("Letters")#, validators= [
   #     Regexp(r'^[a-z]+$', message="must contain letters only")
    #])
    pattern = StringField("Pattern")
    wlen = SelectField(u'Word Length', choices=[('0', 'Unspecified'),('3', '3'), ('4', '4'), ('5', '5'), ('6', '6'), ('7', '7'), ('8', '8'), ('9', '9'), ('10', '10')])
    
    submit = SubmitField("Go")

csrf = CSRFProtect()
app = Flask(__name__)
app.config["SECRET_KEY"] = "row the boat"
csrf.init_app(app)

@app.route('/')
def index():
    wform = WordForm()
    reg = ""
    mins = 3
    maxs = None
    return render_template("index.html", wform=wform, mins=mins, maxs=maxs, reg=reg)


@app.route('/words', methods=['POST','GET'])
def letters_2_words():

    wform = WordForm()
    reg = ""
    mins = 3
    maxs = None
    if (wform.avail_letters.data == None or len(wform.avail_letters.data) == 0) and (wform.pattern.data == None or len(wform.pattern.data) == 0):
        reg = "Please fill out either the pattern or letters section, or both"
        return render_template("index.html", wform=wform, mins=mins, maxs=maxs, reg=reg)
    elif re.search(r'^[a-z]+$', wform.avail_letters.data) == None and (wform.pattern.data == None or len(wform.pattern.data) == 0):
        reg = "Letter field must contain letters only"
        return render_template("index.html", wform=wform, mins=mins, maxs=maxs, reg=reg)
    elif ((wform.pattern.data != None) and len(wform.pattern.data) != 0) and (int(wform.wlen.data) != 0) and (len(wform.pattern.data) != int(wform.wlen.data)):
        reg = "Pattern length is not equal to specified word length"
        return render_template("index.html", wform=wform, mins=mins, maxs=maxs, reg=reg)
    else:
        letters = wform.avail_letters.data
    with open('sowpods.txt') as f:
        good_words = set(x.strip().lower() for x in f.readlines())
    word_set = set()
    if wform.wlen.data == '0':
        if (wform.avail_letters.data == None or len(wform.avail_letters.data) == 0) and (wform.pattern.data != None and len(wform.pattern.data) != 0):
            for w in good_words:
                if re.search('^'+wform.pattern.data+'$', w) != None:
                    word_set.add(w)
        else:
            for l in range(3,len(letters)+1):
                for word in itertools.permutations(letters,l):
                    w = "".join(word)
                    #print('Url: ' + wform.pattern.data, file=sys.stdout)
                    if w in good_words and (re.search('^'+wform.pattern.data+'$', w) != None or len(wform.pattern.data) == 0):
                        word_set.add(w)
    else:
        if (wform.avail_letters.data == None or len(wform.avail_letters.data) == 0) and (wform.pattern.data != None and len(wform.pattern.data) != 0):
            for w in good_words:
                if re.search('^'+wform.pattern.data+'$', w) != None and len(w)== int(wform.wlen.data):
                    word_set.add(w)
        else:
            for word in itertools.permutations(letters,int(wform.wlen.data)):
                w = "".join(word)
               # print('Url: ' + wform.pattern.data, file=sys.stdout)
                if w in good_words and (re.search('^'+wform.pattern.data+'$', w) != None or len(wform.pattern.data) == 0):
                    word_set.add(w)

    return render_template('wordlist.html',
        wordlist=sorted(sorted(word_set), key = len),
        name="CS4131")




@app.route('/proxy/<dic>')
def proxy(dic):
    result = requests.get("https://www.dictionaryapi.com/api/v3/references/collegiate/json/"+dic+"?key=0ecd49d6-6fa8-4e24-a31a-d3295cadaac2")

    resp = Response(result.text)
    resp.headers['Content-Type'] = 'application/json'
    #print('Url: '+dic, file=sys.stdout)
    return resp


