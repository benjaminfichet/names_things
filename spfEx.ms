

-- Dummy struct
struct SPTFuncs (
    fn getMaxVersion = (20)
)



struct PersoName (

    _maxVer = undefined,
    _name   = undefined,
    _decli  = undefined,

    fn __parseArgs nde:undefined= (
        local nCls = classOf nde
        if (nCls == undefined) then () -- Find first perso in scene
        if (nCls == node)      then () -- Find by node
    ),

    fn __parseName n = (
        
    ),

    fn __getNode s = (),

    fn _getPersoName       nde:undefined = (),
    fn _getPersoDecli      nde:undefined = (),
    fn _getPersoIdentifier nde:undefined = (),

    fn getPersoName        node:undefined = (this._getPersoName       nde:node),
    fn getPersoDecli       node:undefined = (this._getPersoDecli      nde:node),
    fn getPersoIdentifier  node:undefined = (this._getPersoIdentifier nde:node),


    fn init initNode:undefined = (
        local ret = false
        if initNode == undefined then (
            
        ) else (

        )
        ret
    ),

    on create do (
        this._maxVer = spf.getMaxVersion()
    )
)


pname = PersoName()
pname.init node:

struct spfEx (





    fn getPersoName nde:undefined = (
        local ret = false
        local clsof = classof nde        
        case clsof of (
            Node:()
            Array:()
            undefined:()
        )
        ret
    )
)