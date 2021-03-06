# This file was automatically generated by SWIG (http://www.swig.org).
# Version 1.3.35
#
# Don't modify this file, modify the SWIG interface instead.
# This file is compatible with both classic and new-style classes.

import _SimxTxPower
import new
new_instancemethod = new.instancemethod
try:
    _swig_property = property
except NameError:
    pass # Python < 2.2 doesn't have 'property'.
def _swig_setattr_nondynamic(self,class_type,name,value,static=1):
    if (name == "thisown"): return self.this.own(value)
    if (name == "this"):
        if type(value).__name__ == 'PySwigObject':
            self.__dict__[name] = value
            return
    method = class_type.__swig_setmethods__.get(name,None)
    if method: return method(self,value)
    if (not static) or hasattr(self,name):
        self.__dict__[name] = value
    else:
        raise AttributeError("You cannot add attributes to %s" % self)

def _swig_setattr(self,class_type,name,value):
    return _swig_setattr_nondynamic(self,class_type,name,value,0)

def _swig_getattr(self,class_type,name):
    if (name == "thisown"): return self.this.own()
    method = class_type.__swig_getmethods__.get(name,None)
    if method: return method(self)
    raise AttributeError,name

def _swig_repr(self):
    try: strthis = "proxy of " + self.this.__repr__()
    except: strthis = ""
    return "<%s.%s; %s >" % (self.__class__.__module__, self.__class__.__name__, strthis,)

import types
try:
    _object = types.ObjectType
    _newclass = 1
except AttributeError:
    class _object : pass
    _newclass = 0
del types


class txpower_change_callback_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, txpower_change_callback_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, txpower_change_callback_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["fn"] = _SimxTxPower.txpower_change_callback_t_fn_set
    __swig_getmethods__["fn"] = _SimxTxPower.txpower_change_callback_t_fn_get
    if _newclass:fn = _swig_property(_SimxTxPower.txpower_change_callback_t_fn_get, _SimxTxPower.txpower_change_callback_t_fn_set)
    __swig_setmethods__["fn_data"] = _SimxTxPower.txpower_change_callback_t_fn_data_set
    __swig_getmethods__["fn_data"] = _SimxTxPower.txpower_change_callback_t_fn_data_get
    if _newclass:fn_data = _swig_property(_SimxTxPower.txpower_change_callback_t_fn_data_get, _SimxTxPower.txpower_change_callback_t_fn_data_set)
    def __init__(self, *args): 
        this = _SimxTxPower.new_txpower_change_callback_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _SimxTxPower.delete_txpower_change_callback_t
    __del__ = lambda self : None;
txpower_change_callback_t_swigregister = _SimxTxPower.txpower_change_callback_t_swigregister
txpower_change_callback_t_swigregister(txpower_change_callback_t)

class txpower_inspect_callback_t(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, txpower_inspect_callback_t, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, txpower_inspect_callback_t, name)
    __repr__ = _swig_repr
    __swig_setmethods__["fn"] = _SimxTxPower.txpower_inspect_callback_t_fn_set
    __swig_getmethods__["fn"] = _SimxTxPower.txpower_inspect_callback_t_fn_get
    if _newclass:fn = _swig_property(_SimxTxPower.txpower_inspect_callback_t_fn_get, _SimxTxPower.txpower_inspect_callback_t_fn_set)
    __swig_setmethods__["fn_data"] = _SimxTxPower.txpower_inspect_callback_t_fn_data_set
    __swig_getmethods__["fn_data"] = _SimxTxPower.txpower_inspect_callback_t_fn_data_get
    if _newclass:fn_data = _swig_property(_SimxTxPower.txpower_inspect_callback_t_fn_data_get, _SimxTxPower.txpower_inspect_callback_t_fn_data_set)
    def __init__(self, *args): 
        this = _SimxTxPower.new_txpower_inspect_callback_t(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _SimxTxPower.delete_txpower_inspect_callback_t
    __del__ = lambda self : None;
txpower_inspect_callback_t_swigregister = _SimxTxPower.txpower_inspect_callback_t_swigregister
txpower_inspect_callback_t_swigregister(txpower_inspect_callback_t)

simx_txpower_set_change_callback = _SimxTxPower.simx_txpower_set_change_callback
simx_txpower_set_inspect_callback = _SimxTxPower.simx_txpower_set_inspect_callback
simx_txpower_get_change_callback = _SimxTxPower.simx_txpower_get_change_callback
simx_txpower_get_inspect_callback = _SimxTxPower.simx_txpower_get_inspect_callback
class TxPower(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, TxPower, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, TxPower, name)
    __repr__ = _swig_repr
    def __init__(self, *args): 
        this = _SimxTxPower.new_TxPower(*args)
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _SimxTxPower.delete_TxPower
    __del__ = lambda self : None;
    def _setChangeFunction(*args): return _SimxTxPower.TxPower__setChangeFunction(*args)
    def _setInspectFunction(*args): return _SimxTxPower.TxPower__setInspectFunction(*args)
    def _getChangeFunction(*args): return _SimxTxPower.TxPower__getChangeFunction(*args)
    def _getInspectFunction(*args): return _SimxTxPower.TxPower__getInspectFunction(*args)
    def setChangeFunction(*args): return _SimxTxPower.TxPower_setChangeFunction(*args)
    def setInspectFunction(*args): return _SimxTxPower.TxPower_setInspectFunction(*args)
TxPower_swigregister = _SimxTxPower.TxPower_swigregister
TxPower_swigregister(TxPower)



