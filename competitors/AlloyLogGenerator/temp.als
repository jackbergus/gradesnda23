abstract sig Activity {}
abstract sig Payload {}

abstract sig Event{
	task: one Activity,
	data: set Payload,
	tokens: set Token
}

one sig DummyPayload extends Payload {}
fact { no te:Event | DummyPayload in te.data }

one sig DummyActivity extends Activity {}

abstract sig Token {}
abstract sig SameToken extends Token {}
abstract sig DiffToken extends Token {}
lone sig DummySToken extends SameToken{}
lone sig DummyDToken extends DiffToken{}
fact { 
	no DummySToken
	no DummyDToken
	all te:Event| no (te.tokens & SameToken) or no (te.tokens & DiffToken)
}

pred True[]{some TE0}

// lang templates

pred Init(taskA: Activity) { 
	taskA = TE0.task
}

pred Existence(taskA: Activity) { 
	some te: Event | te.task = taskA
}

pred Existence(taskA: Activity, n: Int) {
	#{ te: Event | taskA = te.task } >= n
}

pred Absence(taskA: Activity) { 
	no te: Event | te.task = taskA
}

pred Absence(taskA: Activity, n: Int) {
	#{ te: Event | taskA = te.task } <= n
}

pred Exactly(taskA: Activity, n: Int) {
	#{ te: Event | taskA = te.task } = n
}

pred Choice(taskA, taskB: Activity) { 
	some te: Event | te.task = taskA or te.task = taskB
}

pred ExclusiveChoice(taskA, taskB: Activity) { 
	some te: Event | te.task = taskA or te.task = taskB
	(no te: Event | taskA = te.task) or (no te: Event | taskB = te.task )
}

pred RespondedExistence(taskA, taskB: Activity) {
	(some te: Event | taskA = te.task) implies (some ote: Event | taskB = ote.task)
}

pred Response(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (some fte: Event | taskB = fte.task and After[te, fte])
}

pred AlternateResponse(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (some fte: Event | taskB = fte.task and After[te, fte] and (no ite: Event | taskA = ite.task and After[te, ite] and After[ite, fte]))
}

pred ChainResponse(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (some fte: Event | taskB = fte.task and Next[te, fte])
}

pred Precedence(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (some fte: Event | taskB = fte.task and After[fte, te])
}

pred AlternatePrecedence(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (some fte: Event | taskB = fte.task and After[fte, te] and (no ite: Event | taskA = ite.task and After[fte, ite] and After[ite, te]))
}

pred ChainPrecedence(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (some fte: Event | taskB = fte.task and Next[fte, te])
}

pred NotRespondedExistence(taskA, taskB: Activity) {
	(some te: Event | taskA = te.task) implies (no te: Event | taskB = te.task)
}

pred NotResponse(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (no fte: Event | taskB = fte.task and After[te, fte])
}

pred NotPrecedence(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (no fte: Event | taskB = fte.task and After[fte, te])
}

pred NotChainResponse(taskA, taskB: Activity) { 
	all te: Event | taskA = te.task implies (no fte: Event | (DummyActivity = fte.task or taskB = fte.task) and Next[te, fte])
}

pred NotChainPrecedence(taskA, taskB: Activity) {
	all te: Event | taskA = te.task implies (no fte: Event | (DummyActivity = fte.task or taskB = fte.task) and Next[fte, te])
}
//-

pred example { }
run example

---------------------- end of static code block ----------------------

--------------------- generated code starts here ---------------------

one sig K extends Activity {}
one sig D extends Activity {}
one sig O extends Activity {}
one sig T extends Activity {}
one sig J extends Activity {}
one sig A extends Activity {}
one sig B extends Activity {}
one sig P extends Activity {}
one sig R extends Activity {}
one sig Q extends Activity {}
one sig F extends Activity {}
one sig S extends Activity {}
one sig G extends Activity {}
one sig E extends Activity {}
one sig L extends Activity {}
one sig H extends Activity {}
one sig TE0 extends Event {}{not task=DummyActivity}
one sig TE1 extends Event {}{not task=DummyActivity}
one sig TE2 extends Event {}{not task=DummyActivity}
one sig TE3 extends Event {}{not task=DummyActivity}
one sig TE4 extends Event {}{not task=DummyActivity}
one sig TE5 extends Event {}{not task=DummyActivity}
one sig TE6 extends Event {}{not task=DummyActivity}
one sig TE7 extends Event {}{not task=DummyActivity}
one sig TE8 extends Event {}{not task=DummyActivity}
one sig TE9 extends Event {}{not task=DummyActivity}
one sig TE10 extends Event {}{not task=DummyActivity}
one sig TE11 extends Event {}{not task=DummyActivity}
one sig TE12 extends Event {}{not task=DummyActivity}
one sig TE13 extends Event {}{not task=DummyActivity}
one sig TE14 extends Event {}{not task=DummyActivity}
one sig TE15 extends Event {}{not task=DummyActivity}
one sig TE16 extends Event {}{not task=DummyActivity}
one sig TE17 extends Event {}{not task=DummyActivity}
one sig TE18 extends Event {}{not task=DummyActivity}
one sig TE19 extends Event {}{not task=DummyActivity}
one sig TE20 extends Event {}{not task=DummyActivity}
one sig TE21 extends Event {}{not task=DummyActivity}
one sig TE22 extends Event {}{not task=DummyActivity}
one sig TE23 extends Event {}{not task=DummyActivity}
one sig TE24 extends Event {}{not task=DummyActivity}
one sig TE25 extends Event {}{not task=DummyActivity}
one sig TE26 extends Event {}{not task=DummyActivity}
one sig TE27 extends Event {}{not task=DummyActivity}
one sig TE28 extends Event {}{not task=DummyActivity}
one sig TE29 extends Event {}{not task=DummyActivity}
one sig TE30 extends Event {}{not task=DummyActivity}
one sig TE31 extends Event {}{not task=DummyActivity}
one sig TE32 extends Event {}{not task=DummyActivity}
one sig TE33 extends Event {}{not task=DummyActivity}
one sig TE34 extends Event {}{not task=DummyActivity}
one sig TE35 extends Event {}{not task=DummyActivity}
one sig TE36 extends Event {}{not task=DummyActivity}
one sig TE37 extends Event {}{not task=DummyActivity}
one sig TE38 extends Event {}{not task=DummyActivity}
one sig TE39 extends Event {}{not task=DummyActivity}
one sig TE40 extends Event {}{not task=DummyActivity}
one sig TE41 extends Event {}{not task=DummyActivity}
one sig TE42 extends Event {}{not task=DummyActivity}
one sig TE43 extends Event {}{not task=DummyActivity}
one sig TE44 extends Event {}{not task=DummyActivity}
one sig TE45 extends Event {}{not task=DummyActivity}
one sig TE46 extends Event {}{not task=DummyActivity}
one sig TE47 extends Event {}{not task=DummyActivity}
one sig TE48 extends Event {}{not task=DummyActivity}
one sig TE49 extends Event {}{not task=DummyActivity}
one sig TE50 extends Event {}{not task=DummyActivity}
one sig TE51 extends Event {}{not task=DummyActivity}
one sig TE52 extends Event {}{not task=DummyActivity}
one sig TE53 extends Event {}{not task=DummyActivity}
one sig TE54 extends Event {}{not task=DummyActivity}
one sig TE55 extends Event {}{not task=DummyActivity}
one sig TE56 extends Event {}{not task=DummyActivity}
one sig TE57 extends Event {}{not task=DummyActivity}
one sig TE58 extends Event {}{not task=DummyActivity}
one sig TE59 extends Event {}{not task=DummyActivity}
one sig TE60 extends Event {}{not task=DummyActivity}
one sig TE61 extends Event {}{not task=DummyActivity}
one sig TE62 extends Event {}{not task=DummyActivity}
one sig TE63 extends Event {}{not task=DummyActivity}
one sig TE64 extends Event {}{not task=DummyActivity}
one sig TE65 extends Event {}{not task=DummyActivity}
one sig TE66 extends Event {}{not task=DummyActivity}
one sig TE67 extends Event {}{not task=DummyActivity}
one sig TE68 extends Event {}{not task=DummyActivity}
one sig TE69 extends Event {}{not task=DummyActivity}
one sig TE70 extends Event {}{not task=DummyActivity}
one sig TE71 extends Event {}{not task=DummyActivity}
one sig TE72 extends Event {}{not task=DummyActivity}
one sig TE73 extends Event {}{not task=DummyActivity}
one sig TE74 extends Event {}{not task=DummyActivity}
one sig TE75 extends Event {}{not task=DummyActivity}
one sig TE76 extends Event {}{not task=DummyActivity}
one sig TE77 extends Event {}{not task=DummyActivity}
one sig TE78 extends Event {}{not task=DummyActivity}
one sig TE79 extends Event {}{not task=DummyActivity}
one sig TE80 extends Event {}{not task=DummyActivity}
one sig TE81 extends Event {}{not task=DummyActivity}
one sig TE82 extends Event {}{not task=DummyActivity}
one sig TE83 extends Event {}{not task=DummyActivity}
one sig TE84 extends Event {}{not task=DummyActivity}
one sig TE85 extends Event {}{not task=DummyActivity}
one sig TE86 extends Event {}{not task=DummyActivity}
one sig TE87 extends Event {}{not task=DummyActivity}
one sig TE88 extends Event {}{not task=DummyActivity}
one sig TE89 extends Event {}{not task=DummyActivity}
one sig TE90 extends Event {}{not task=DummyActivity}
one sig TE91 extends Event {}{not task=DummyActivity}
one sig TE92 extends Event {}{not task=DummyActivity}
one sig TE93 extends Event {}{not task=DummyActivity}
one sig TE94 extends Event {}{not task=DummyActivity}
one sig TE95 extends Event {}{not task=DummyActivity}
one sig TE96 extends Event {}{not task=DummyActivity}
one sig TE97 extends Event {}{not task=DummyActivity}
one sig TE98 extends Event {}{not task=DummyActivity}
one sig TE99 extends Event {}{not task=DummyActivity}
pred Next(pre, next: Event){pre=TE0 and next=TE1 or pre=TE1 and next=TE2 or pre=TE2 and next=TE3 or pre=TE3 and next=TE4 or pre=TE4 and next=TE5 or pre=TE5 and next=TE6 or pre=TE6 and next=TE7 or pre=TE7 and next=TE8 or pre=TE8 and next=TE9 or pre=TE9 and next=TE10 or pre=TE10 and next=TE11 or pre=TE11 and next=TE12 or pre=TE12 and next=TE13 or pre=TE13 and next=TE14 or pre=TE14 and next=TE15 or pre=TE15 and next=TE16 or pre=TE16 and next=TE17 or pre=TE17 and next=TE18 or pre=TE18 and next=TE19 or pre=TE19 and next=TE20 or pre=TE20 and next=TE21 or pre=TE21 and next=TE22 or pre=TE22 and next=TE23 or pre=TE23 and next=TE24 or pre=TE24 and next=TE25 or pre=TE25 and next=TE26 or pre=TE26 and next=TE27 or pre=TE27 and next=TE28 or pre=TE28 and next=TE29 or pre=TE29 and next=TE30 or pre=TE30 and next=TE31 or pre=TE31 and next=TE32 or pre=TE32 and next=TE33 or pre=TE33 and next=TE34 or pre=TE34 and next=TE35 or pre=TE35 and next=TE36 or pre=TE36 and next=TE37 or pre=TE37 and next=TE38 or pre=TE38 and next=TE39 or pre=TE39 and next=TE40 or pre=TE40 and next=TE41 or pre=TE41 and next=TE42 or pre=TE42 and next=TE43 or pre=TE43 and next=TE44 or pre=TE44 and next=TE45 or pre=TE45 and next=TE46 or pre=TE46 and next=TE47 or pre=TE47 and next=TE48 or pre=TE48 and next=TE49 or pre=TE49 and next=TE50 or pre=TE50 and next=TE51 or pre=TE51 and next=TE52 or pre=TE52 and next=TE53 or pre=TE53 and next=TE54 or pre=TE54 and next=TE55 or pre=TE55 and next=TE56 or pre=TE56 and next=TE57 or pre=TE57 and next=TE58 or pre=TE58 and next=TE59 or pre=TE59 and next=TE60 or pre=TE60 and next=TE61 or pre=TE61 and next=TE62 or pre=TE62 and next=TE63 or pre=TE63 and next=TE64 or pre=TE64 and next=TE65 or pre=TE65 and next=TE66 or pre=TE66 and next=TE67 or pre=TE67 and next=TE68 or pre=TE68 and next=TE69 or pre=TE69 and next=TE70 or pre=TE70 and next=TE71 or pre=TE71 and next=TE72 or pre=TE72 and next=TE73 or pre=TE73 and next=TE74 or pre=TE74 and next=TE75 or pre=TE75 and next=TE76 or pre=TE76 and next=TE77 or pre=TE77 and next=TE78 or pre=TE78 and next=TE79 or pre=TE79 and next=TE80 or pre=TE80 and next=TE81 or pre=TE81 and next=TE82 or pre=TE82 and next=TE83 or pre=TE83 and next=TE84 or pre=TE84 and next=TE85 or pre=TE85 and next=TE86 or pre=TE86 and next=TE87 or pre=TE87 and next=TE88 or pre=TE88 and next=TE89 or pre=TE89 and next=TE90 or pre=TE90 and next=TE91 or pre=TE91 and next=TE92 or pre=TE92 and next=TE93 or pre=TE93 and next=TE94 or pre=TE94 and next=TE95 or pre=TE95 and next=TE96 or pre=TE96 and next=TE97 or pre=TE97 and next=TE98 or pre=TE98 and next=TE99}
pred After(b, a: Event){// b=before, a=after
b=TE0 or a=TE99 or b=TE1 and not (a=TE0) or b=TE2 and not (a=TE0 or a=TE1) or b=TE3 and not (a=TE0 or a=TE1 or a=TE2) or b=TE4 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3) or b=TE5 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4) or b=TE6 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5) or b=TE7 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6) or b=TE8 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7) or b=TE9 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8) or b=TE10 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9) or b=TE11 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10) or b=TE12 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11) or b=TE13 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12) or b=TE14 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13) or b=TE15 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14) or b=TE16 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15) or b=TE17 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16) or b=TE18 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17) or b=TE19 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18) or b=TE20 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19) or b=TE21 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20) or b=TE22 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21) or b=TE23 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22) or b=TE24 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23) or b=TE25 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24) or b=TE26 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25) or b=TE27 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26) or b=TE28 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27) or b=TE29 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28) or b=TE30 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29) or b=TE31 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30) or b=TE32 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31) or b=TE33 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32) or b=TE34 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33) or b=TE35 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34) or b=TE36 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35) or b=TE37 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36) or b=TE38 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37) or b=TE39 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38) or b=TE40 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39) or b=TE41 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40) or b=TE42 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40 or a=TE41) or b=TE43 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40 or a=TE41 or a=TE42) or b=TE44 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40 or a=TE41 or a=TE42 or a=TE43) or b=TE45 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40 or a=TE41 or a=TE42 or a=TE43 or a=TE44) or b=TE46 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40 or a=TE41 or a=TE42 or a=TE43 or a=TE44 or a=TE45) or b=TE47 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40 or a=TE41 or a=TE42 or a=TE43 or a=TE44 or a=TE45 or a=TE46) or b=TE48 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40 or a=TE41 or a=TE42 or a=TE43 or a=TE44 or a=TE45 or a=TE46 or a=TE47) or b=TE49 and not (a=TE0 or a=TE1 or a=TE2 or a=TE3 or a=TE4 or a=TE5 or a=TE6 or a=TE7 or a=TE8 or a=TE9 or a=TE10 or a=TE11 or a=TE12 or a=TE13 or a=TE14 or a=TE15 or a=TE16 or a=TE17 or a=TE18 or a=TE19 or a=TE20 or a=TE21 or a=TE22 or a=TE23 or a=TE24 or a=TE25 or a=TE26 or a=TE27 or a=TE28 or a=TE29 or a=TE30 or a=TE31 or a=TE32 or a=TE33 or a=TE34 or a=TE35 or a=TE36 or a=TE37 or a=TE38 or a=TE39 or a=TE40 or a=TE41 or a=TE42 or a=TE43 or a=TE44 or a=TE45 or a=TE46 or a=TE47 or a=TE48) or b=TE50 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59 or a=TE58 or a=TE57 or a=TE56 or a=TE55 or a=TE54 or a=TE53 or a=TE52 or a=TE51) or b=TE51 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59 or a=TE58 or a=TE57 or a=TE56 or a=TE55 or a=TE54 or a=TE53 or a=TE52) or b=TE52 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59 or a=TE58 or a=TE57 or a=TE56 or a=TE55 or a=TE54 or a=TE53) or b=TE53 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59 or a=TE58 or a=TE57 or a=TE56 or a=TE55 or a=TE54) or b=TE54 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59 or a=TE58 or a=TE57 or a=TE56 or a=TE55) or b=TE55 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59 or a=TE58 or a=TE57 or a=TE56) or b=TE56 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59 or a=TE58 or a=TE57) or b=TE57 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59 or a=TE58) or b=TE58 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60 or a=TE59) or b=TE59 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61 or a=TE60) or b=TE60 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62 or a=TE61) or b=TE61 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63 or a=TE62) or b=TE62 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64 or a=TE63) or b=TE63 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65 or a=TE64) or b=TE64 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66 or a=TE65) or b=TE65 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67 or a=TE66) or b=TE66 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68 or a=TE67) or b=TE67 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69 or a=TE68) or b=TE68 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70 or a=TE69) or b=TE69 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71 or a=TE70) or b=TE70 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72 or a=TE71) or b=TE71 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73 or a=TE72) or b=TE72 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74 or a=TE73) or b=TE73 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75 or a=TE74) or b=TE74 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76 or a=TE75) or b=TE75 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77 or a=TE76) or b=TE76 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78 or a=TE77) or b=TE77 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79 or a=TE78) or b=TE78 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80 or a=TE79) or b=TE79 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81 or a=TE80) or b=TE80 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82 or a=TE81) or b=TE81 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83 or a=TE82) or b=TE82 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84 or a=TE83) or b=TE83 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85 or a=TE84) or b=TE84 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86 or a=TE85) or b=TE85 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87 or a=TE86) or b=TE86 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88 or a=TE87) or b=TE87 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89 or a=TE88) or b=TE88 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90 or a=TE89) or b=TE89 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91 or a=TE90) or b=TE90 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92 or a=TE91) or b=TE91 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93 or a=TE92) or b=TE92 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94 or a=TE93) or b=TE93 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95 or a=TE94) or b=TE94 and (a=TE99 or a=TE98 or a=TE97 or a=TE96 or a=TE95) or b=TE95 and (a=TE99 or a=TE98 or a=TE97 or a=TE96) or b=TE96 and (a=TE99 or a=TE98 or a=TE97) or b=TE97 and (a=TE99 or a=TE98)}
fact { all te: Event | te.task = R implies (one a & te.data)}
fact { all te: Event | te.task = D implies (one a & te.data)}
fact { all te: Event | te.task = T implies (one e & te.data)}
fact { all te: Event | te.task = G implies (one a & te.data and one b & te.data and one d & te.data)}
fact { all te: Event | te.task = J implies (one b & te.data)}
fact { all te: Event | te.task = L implies (one d & te.data)}
fact { all te: Event | te.task = O implies (one d & te.data and one a & te.data)}
fact { all te: Event | lone(a & te.data) }
fact { all te: Event | some (a & te.data) implies te.task in (D + G + O + R) }
fact { all te: Event | lone(b & te.data) }
fact { all te: Event | some (b & te.data) implies te.task in (G + J) }
fact { all te: Event | lone(d & te.data) }
fact { all te: Event | some (d & te.data) implies te.task in (G + L + O) }
fact { all te: Event | lone(e & te.data) }
fact { all te: Event | some (e & te.data) implies te.task in (T) }
abstract sig e extends Payload {
amount: Int
}
fact { all te: Event | (lone e & te.data) }
pred Single(pl: e) {{pl.amount=1}}
fun Amount(pl: e): one Int {{pl.amount}}
one sig intBetween2and7r100000 extends e{}{amount=4}
one sig intBetween6and10r100001 extends e{}{amount=3}
abstract sig b extends Payload {
amount: Int
}
fact { all te: Event | (lone b & te.data) }
pred Single(pl: b) {{pl.amount=1}}
fun Amount(pl: b): one Int {{pl.amount}}
one sig intBetween59and94r100008 extends b{}{amount=15}
one sig intEqualsTo48r100006 extends b{}{amount=1}
one sig intBetween48and60r100007 extends b{}{amount=11}
one sig intEqualsTo17r100003 extends b{}{amount=1}
one sig intBetween17and36r100004 extends b{}{amount=15}
one sig intBetween35and48r100005 extends b{}{amount=12}
one sig intBetween13and17r100002 extends b{}{amount=3}
abstract sig d extends Payload {
amount: Int
}
fact { all te: Event | (lone d & te.data) }
pred Single(pl: d) {{pl.amount=1}}
fun Amount(pl: d): one Int {{pl.amount}}
one sig intEqualsTo20r100014 extends d{}{amount=1}
one sig intEqualsTo12r100009 extends d{}{amount=1}
one sig intEqualsTo13r100010 extends d{}{amount=1}
one sig intBetween14and19r100012 extends d{}{amount=4}
one sig intEqualsTo19r100013 extends d{}{amount=1}
one sig intEqualsTo14r100011 extends d{}{amount=1}
abstract sig a extends Payload {
amount: Int
}
fact { all te: Event | (lone a & te.data) }
pred Single(pl: a) {{pl.amount=1}}
fun Amount(pl: a): one Int {{pl.amount}}
one sig intEqualsTo31r100015 extends a{}{amount=1}
one sig intEqualsTo34r100018 extends a{}{amount=1}
one sig intBetween34and37r100019 extends a{}{amount=2}
one sig intEqualsTo32r100016 extends a{}{amount=1}
one sig intEqualsTo33r100017 extends a{}{amount=1}
one sig intBetween36and40r100020 extends a{}{amount=3}
pred p100021(A: Event) { { R.data&a in (intEqualsTo31r100015) } }
pred p100021c(A, B: Event) { { O.data&a in (intEqualsTo33r100017) } }
pred p100022(A: Event) { { L.data&d in (intEqualsTo19r100013) } }
pred p100022c(A, B: Event) { { True[] } }
pred p100023(A: Event) { { True[] } }
pred p100023c(A, B: Event) { { True[] } }
pred p100024(A: Event) { { G.data&b in (intBetween59and94r100008) } }
pred p100024c(A, B: Event) { { True[] } }
pred p100025(A: Event) { { True[] } }
pred p100025c(A, B: Event) { { J.data&b in (intEqualsTo17r100003) } }
pred p100026(A: Event) { { G.data&d in (intEqualsTo14r100011) } }
pred p100026c(A, B: Event) { { True[] } }
pred p100027(A: Event) { { J.data&b in (intEqualsTo48r100006) } }
pred p100027c(A, B: Event) { { G.data&a in (intEqualsTo31r100015 + intEqualsTo34r100018 + intEqualsTo32r100016 + intEqualsTo33r100017) } }
pred p100028(A: Event) { { J.data&b in (intEqualsTo17r100003 + intBetween17and36r100004 + intBetween13and17r100002) } }
pred p100028c(A, B: Event) { { D.data&a in (intBetween36and40r100020) } }
pred p100029(A: Event) { { True[] } }
pred p100029c(A, B: Event) { { O.data&d in (intEqualsTo20r100014 + intEqualsTo13r100010 + intBetween14and19r100012 + intEqualsTo19r100013 + intEqualsTo14r100011) } }
pred p100030(A: Event) { { T.data&e in (intBetween2and7r100000) } }
fact {
all te: Event | (A = te.task and p100029[te]) implies (some fte: Event | O = fte.task and Next[fte, te] and p100029c[te, fte])
all te: Event | (J = te.task and p100028[te]) implies (some fte: Event | D = fte.task and p100028c[te, fte] and After[fte, te] and (no ite: Event | J = ite.task and p100028[ite] and After[fte, ite] and After[ite, te]))
all te: Event | (E = te.task and p100025[te]) implies (some fte: Event | J = fte.task and Next[te, fte] and p100025c[te, fte])
all te: Event | (S = te.task and p100023[te]) implies (some fte: Event | F = fte.task and p100023c[te, fte] and After[fte, te] and (no ite: Event | S = ite.task and p100023[ite] and After[fte, ite] and After[ite, te]))
all te: Event | (G = te.task and p100026[te]) implies (some fte: Event | D = fte.task and p100026c[te, fte] and After[te, fte])
all te: Event | (L = te.task and p100022[te]) implies (some fte: Event | K = fte.task and Next[fte, te] and p100022c[te, fte])
all te: Event | (J = te.task and p100027[te]) implies (some fte: Event | G = fte.task and Next[te, fte] and p100027c[te, fte])
all te: Event | (R = te.task and p100021[te]) implies (some fte: Event | O = fte.task and p100021c[te, fte] and After[te, fte])
T = TE0.task and  p100030[TE0]
all te: Event | (G = te.task and p100024[te]) implies (some fte: Event | K = fte.task and Next[fte, te] and p100024c[te, fte])
}
