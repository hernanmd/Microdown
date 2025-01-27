"
I represent a paragraph with the title. My title can only contain a string and my body can contain formatted text.

I'm created with `!!paragraph` (such as `@@note` `@@important` in Pillar).

!!note This is important so I used exclamation marks.
 
### Known Limitations 
We should revisit the implementation because there is something unclear. 
For example, we cannot currently add lists inside an annotatedBlock.
See [https://github.com/pillar-markup/MicroDown/issues/54](https://github.com/pillar-markup/MicroDown/issues/54)
"
Class {
	#name : 'MicAnnotatedParagraphBlock',
	#superclass : 'MicAbstractAnnotatedBlock',
	#instVars : [
		'validLabels'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicAnnotatedParagraphBlock >> accept: aVisitor [
 	^ aVisitor visitAnnotated: self
]

{ #category : 'parse support' }
MicAnnotatedParagraphBlock >> closeMe [
	super closeMe.
	self verifyLabel.
	body := self inlineParse: body
]

{ #category : 'testing' }
MicAnnotatedParagraphBlock >> defaultLabel [ 
	
	^ #note
]

{ #category : 'testing' }
MicAnnotatedParagraphBlock >> initialize [

	super initialize.
	validLabels := { #note. #important. #todo }
]

{ #category : 'testing' }
MicAnnotatedParagraphBlock >> lineMarkup [
	
	^ AnnotatedParagraphMarkup
]

{ #category : 'accessing' }
MicAnnotatedParagraphBlock >> text [

	^ String streamContents: [ :s |
		  self textElements do: [ :each | s nextPutAll: each plainText ] ]
]

{ #category : 'accessing' }
MicAnnotatedParagraphBlock >> textElements [

	^ self body
]

{ #category : 'parse support' }
MicAnnotatedParagraphBlock >> verifyLabel [

	| isValid |
	isValid := validLabels includes: label asLowercase.
	isValid
		ifTrue: [ label := label asLowercase ]
		ifFalse: [
			body := label , String space , body.
			label := self defaultLabel ]
]
