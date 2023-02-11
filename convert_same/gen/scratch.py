from activities.Settings import Var, VarInteger, VarFloating, VarString, Activity
from activities.SimpleDeclare import VarCondTrue, SelectionCondition, CorrelationCondition, Declare, Op
from gen.scratchParser import scratchParser
from gen.scratchVisitor import scratchVisitor
from utils.Mersenne import Mersenne


class scratch(scratchVisitor):
    d_var:dict[str,Var]
    d_act_to_var:dict[str,set[str]]
    d_act:dict[str,Activity]
    sigma:list[str]
    ls:list[tuple[str,int]]

    def __init__(self):
        super().__init__()
        self.d_var = dict()
        self.d_act_to_var = dict()
        self.l = list()
        self.d_act = dict()
        self.sigma = list()
        self.ls = list()

    def generateSomeModel(self, seed=1, nClauses=1, density=0.4):
        self.finalise_common()
        sM = Mersenne(seed)
        sN = len(self.sigma)
        lsM = Mersenne(seed+1)
        lsN = len(self.ls)
        vM = Mersenne(seed+2)
        op = Mersenne(seed+3)
        opL = list(map(lambda x: x.name, Op))
        opN = len(opL)
        res = list()
        usevar = Mersenne(seed+4)
        for i in range(0, nClauses):
            name, args = self.ls[lsM.extract_integer(0, lsN-1)]
            args = max(args, 1)
            ls = list()
            for j in range(0, args):
                act = self.sigma[sM.extract_integer(0, sN-1)]
                if act in self.d_act_to_var:
                    vars = list(self.d_act_to_var[act])
                    if (usevar.extract_double()>density) and len(vars) > 0:
                        i = vM.extract_integer(0, len(vars)-1)
                        v = self.d_var[vars[i]]
                        val = v.getValue(vM)
                        if isinstance(v, VarString):
                            opS = ["=","!="][op.extract_integer(0, 1)]
                        else:
                            opS = opL[op.extract_integer(0, opN-1)]
                        ls.append(SelectionCondition(self.d_act[act], v, opS, val))
                    else:
                        ls.append(VarCondTrue(self.d_act[act]))
                else:
                    ls.append(VarCondTrue(self.d_act[act]))
            res.append(Declare(name, ls, None))
        return res, self.d_act

    def visitGen(self, ctx: scratchParser.GenContext):
        for x in ctx.global_():
            self.visitGlobal(x)
        for x in ctx.sglobal():
            self.visitSglobal(x)
        for x in ctx.event():
            self.visitEvent(x)
        self.ls = list()
        for x in ctx.declarative():
            self.ls.append(self.visitDeclarative(x))
        self.sigma = list(set(self.sigma))

    def visitSigma(self, ctx: scratchParser.SigmaContext):
        for x in ctx.STRING():
            x = eval(x.getText())
            if x not in self.d_act:
                self.d_act[x] = Activity(x)
            self.sigma.append(x)

    def visitEvent(self, ctx: scratchParser.EventContext):
        act = ctx.STRING().getText()
        if act is None:
            return
        act = eval(act)
        if act not in self.sigma:
            self.sigma.append(act)
        if act not in self.d_act_to_var:
            self.d_act_to_var[act] = set()
        for x in ctx.var():
            self.d_act_to_var[act].add(eval(x.STRING().getText()))
        return None

    def visitDeclarative(self, ctx: scratchParser.DeclarativeContext):
        return eval(ctx.STRING().getText()), int(ctx.INTNUMBER().getText())

    def visitVar(self, ctx: scratchParser.VarContext):
        return super().visitVar(ctx)

    def finalise_common(self):
        for act in self.d_act_to_var:
            if act not in self.d_act:
                self.d_act[act] = Activity(act)
            a = self.d_act[act]
            for x in self.d_act_to_var[act]:
                a.addVar(self.d_var[x])
            self.d_act[act] = a

    def finalise(self):
        self.finalise_common()
        ret = list()
        for name,ls,corr in self.l:
            seq = list()
            for label,obj in ls:
                if obj==True:
                    seq.append(VarCondTrue(self.d_act[label]))
                else:
                    var, op, val = obj
                    seq.append(SelectionCondition(self.d_act[label], var, op, val))
            if corr is not None:
                L, lvar, op, R, rvar = corr
                corr = CorrelationCondition(self.d_act[L], self.d_var[lvar], op, VarCondTrue(self.d_act[R], self.d_var[rvar]))
            ret.append(Declare(name, seq, corr))
        return ret, self.d_act

    def visitLang(self, ctx: scratchParser.LangContext):
        return super().visitLang(ctx)

    def visitGlobal(self, ctx: scratchParser.GlobalContext):
        ints = ctx.INTNUMBER()
        floats = ctx.NUMBER()
        if (len(ints) == 2):
            low = int(ints[0].getText())
            high = int(ints[1].getText())
            name = eval(ctx.var().STRING().getText())
            self.d_var[name] = VarInteger(name, low, high)
        else:
            l = list(ints)
            for x in floats:
                l.append(x)
            l = list(map(lambda x: float(x), l))
            low = min(l)
            high = max(l)
            name = eval(ctx.var().STRING().getText())
            self.d_var[name] = VarFloating(name, low, high)
        return None

    def visitSglobal(self, ctx: scratchParser.SglobalContext):
        name = eval(ctx.var().STRING().getText())
        self.d_var[name] = VarString(name, list(set(map(lambda x: eval(x.getText()), ctx.STRING()))))
        return None

    def visitDeclare(self, ctx: scratchParser.DeclareContext):
        ls = list()
        corr = None
        name = eval(ctx.STRING(0).getText())
        for label,cond in map(lambda x: self.visitField(x), ctx.field()):
            if isinstance(cond, tuple):
                labelX, var, op, val = cond
                if label != labelX:
                    raise Exception("ERROR: EXPECTED "+label+" == "+labelX)
                if label not in self.d_act_to_var:
                    self.d_act_to_var[label] = set()
                self.d_act_to_var[label].add(var)
                if var not in self.d_var:
                    self.d_var[var] = VarInteger(var, 0, 1000)
                ls.append(tuple([label, tuple([self.d_var[var], op, val])]))
            else:
                if label not in self.d_act_to_var:
                    self.d_act_to_var[label] = set()
                ls.append(tuple([label, True]))
        if (ctx.labelLHS is not None) and (ctx.op is not None) and (ctx.vLHS is not None) and (ctx.labelRHS is not None) and (ctx.vRHS is not None):
            if len(ls)>=2:
                L = eval(ctx.labelLHS.text)
                R = eval(ctx.labelLHS.text)
                if ls[0][0] != L:
                    raise Exception("ERROR: EXPECTED "+ls[0][0]+" == "+ctx.labelLHS.getText())
                if ls[1][0] != R:
                    raise Exception("ERROR: EXPECTED "+ls[1][0]+" == "+ctx.labelRHS.getText())
                lvar = eval(ctx.vLHS.STRING().getText())
                rvar = eval(ctx.vRHS.STRING().getText())
                if L not in self.d_act_to_var:
                    self.d_act_to_var[L] = set()
                self.d_act_to_var[L].add(lvar)
                if R not in self.d_act_to_var:
                    self.d_act_to_var[R] = set()
                self.d_act_to_var[R].add(rvar)
                if lvar not in self.d_var:
                    self.d_var[lvar] = VarInteger(lvar, 0, 1000)
                if rvar not in self.d_var:
                    self.d_var[rvar] = VarInteger(rvar, 0, 1000)
                corr = tuple([L, lvar, ctx.op.text, R, rvar])
        self.l.append(tuple([name, ls, corr]))
        return None

    def visitActualcond(self, ctx: scratchParser.ActualcondContext):
        label = eval(ctx.label.text)
        var = eval(ctx.var().STRING().getText())
        op = ctx.op.text
        val = ctx.val.text
        if val[0] == '"':
            val = eval(val)
        elif val.find('.')!=-1:
            val = int(val)
        else:
            val = float(val)
        return (label,var,op,val)

    def visitTrue(self, ctx: scratchParser.TrueContext):
        return True

    def visitField(self, ctx: scratchParser.FieldContext):
        return (eval(ctx.STRING().getText()), self.visit(ctx.cond()))