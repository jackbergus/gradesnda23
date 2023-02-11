# Generated from /home/giacomo/projects/loggen/convert_same/scratch.g4 by ANTLR 4.11.1
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .scratchParser import scratchParser
else:
    from scratchParser import scratchParser

# This class defines a complete generic visitor for a parse tree produced by scratchParser.

class scratchVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by scratchParser#lang.
    def visitLang(self, ctx:scratchParser.LangContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#gen.
    def visitGen(self, ctx:scratchParser.GenContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#sigma.
    def visitSigma(self, ctx:scratchParser.SigmaContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#event.
    def visitEvent(self, ctx:scratchParser.EventContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#global.
    def visitGlobal(self, ctx:scratchParser.GlobalContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#sglobal.
    def visitSglobal(self, ctx:scratchParser.SglobalContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#declare.
    def visitDeclare(self, ctx:scratchParser.DeclareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#declarative.
    def visitDeclarative(self, ctx:scratchParser.DeclarativeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#actualcond.
    def visitActualcond(self, ctx:scratchParser.ActualcondContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#true.
    def visitTrue(self, ctx:scratchParser.TrueContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#field.
    def visitField(self, ctx:scratchParser.FieldContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by scratchParser#var.
    def visitVar(self, ctx:scratchParser.VarContext):
        return self.visitChildren(ctx)



del scratchParser