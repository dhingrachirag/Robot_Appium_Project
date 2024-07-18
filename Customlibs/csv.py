import csv


def read_csv(filename):
    data = []
    with open(filename, 'rb') as csvfile:
        reader1 = csv.reader1(csvfile)  # type: object 
        for row in reader1:
            data.append(row)
    return data
