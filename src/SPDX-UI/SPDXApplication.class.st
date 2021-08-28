Class {
	#name : #SPDXApplication,
	#superclass : #SpApplication,
	#instVars : [
		'spdx'
	],
	#classVars : [
		'Licenses'
	],
	#category : #'SPDX-UI'
}

{ #category : #accessing }
SPDXApplication class >> licenses [ 
	" Answer a <SPDXObject> containing licenses "

	^ Licenses 
		ifNil: [ Licenses := SPDXLicenseReader fetchLicenseJSON ]
]

{ #category : #accessing }
SPDXApplication >> licenses [
	" Answer a <Collection> of <SPDXLicense> "

	^ self spdx licenses

]

{ #category : #accessing }
SPDXApplication >> spdx [
	" See comment in #licenses "

	^ self class licenses
]

{ #category : #accessing }
SPDXApplication >> start [
	" Private - See superimplementor's comment "

	(SpSPDXPresenter newApplication: self) openWithSpec.
]
