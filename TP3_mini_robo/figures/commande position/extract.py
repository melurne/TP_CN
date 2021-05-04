from os import listdir

files = listdir('matlab_fig/')

def extract(filename) :
    pass

import scipy.io as spio

def loadmat(filename):
    '''
    this function should be called instead of direct spio.loadmat
    as it cures the problem of not properly recovering python dictionaries
    from mat files. It calls the function check keys to cure all entries
    which are still mat-objects
    '''
    data = spio.loadmat(filename, struct_as_record=False, squeeze_me=True)
    return _check_keys(data)

def _check_keys(dict):
    '''
    checks if entries in dictionary are mat-objects. If yes
    todict is called to change them to nested dictionaries
    '''
    for key in dict:
        if isinstance(dict[key], spio.matlab.mio5_params.mat_struct):
            dict[key] = _todict(dict[key])
    return dict

def _todict(matobj):
    '''
    A recursive function which constructs from matobjects nested dictionaries
    '''
    dict = {}
    for strg in matobj._fieldnames:
        elem = matobj.__dict__[strg]
        if isinstance(elem, spio.matlab.mio5_params.mat_struct):
            dict[strg] = _todict(elem)
        else:
            dict[strg] = elem
    return dict


x = loadmat('matlab_fig/5_0_5.fig')
#print(x['hgS_070000'][0,0].children[0,0].children[0,0].properties[0,0].XData)
#print(type(x['hgS_070000']))
for i in [0, 2] :
    for j in [0, 1] :
        print(_todict(_todict(x['hgS_070000']['children'][i])['children'][j])['properties']['YData'])
