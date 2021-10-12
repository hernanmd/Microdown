Class {
	#name : #MicHTMLWriter,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream'
	],
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicHTMLWriter >> contents [ 
	^ stream contents
]

{ #category : #initialization }
MicHTMLWriter >> initialize [ 
	super initialize.
	stream := MicOutputStream new setStream: (WriteStream on: (String new: 1000)).
	"canvas := self canvasClass on: stream."
	
]

{ #category : #initialization }
MicHTMLWriter >> usedNewLine [
	"Return the encoded new line. Useful for tests."
	
	^ stream usedNewLine
]

{ #category : #visiting }
MicHTMLWriter >> visitHeader: aHeader [
	stream newLine.
	stream
		nextPutAll: '<h';
		nextPutAll: aHeader level asString;
		nextPutAll: '>';
		nextPutAll: aHeader header;
		nextPutAll: '</h';
		nextPutAll: aHeader level asString;
		nextPutAll: '>'
]

{ #category : #visiting }
MicHTMLWriter >> visitUnorderedList: anUnorderedList [

	stream newLine.
	stream nextPutAll: '<ul>'.
	stream newLine.
	super visitUnorderedList: anUnorderedList.
	stream nextPutAll: '</ul>'.
]

{ #category : #visiting }
MicHTMLWriter >> visitUnorderedListItem: anUnorderedListItem [

	stream nextPutAll: '<li>'.
	stream nextPutAll: anUnorderedListItem text.
	"will not work with we have text decorators such as bold, italic, monospace"
	stream nextPutAll: '</li>'.
	stream newLine
]