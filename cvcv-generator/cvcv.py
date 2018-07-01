import string


vowels = set("aeiou")
consonants = set(string.ascii_lowercase) - vowels

cvs = []
for c in consonants:
    for v in vowels:
        cvs.append(c + v)

cvcvs = set()
for cv1 in cvs:
    for cv2 in cvs:
        cvcvs.add(cv1 + cv2)

# for cvcv in cvcvs:
#     print cvcv

print cvcvs