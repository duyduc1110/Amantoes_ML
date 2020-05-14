import pandas as pd


def read_data(path):
    data = pd.read_csv(path, header=0)
    return data


def filter_negative(data):
    return data > 0