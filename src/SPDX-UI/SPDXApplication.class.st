"
This is the main application object according to Spec2 UI library requirements. The UI application can be started with

```
SPDXApplication new start.
```

Licenses are stored in class side, and retrieved only on first launch. Licenses can be updated by user-request through the UI ""Update"" button.

Internal Representation and Key Implementation Points.

    Instance Variables
	spdx:		<Object>


    Implementation Points
"
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

{ #category : #'world menu' }
SPDXApplication class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'License Selection')
		parent: #Tools;
		action:[ self new run ]; 
		icon: self taskbarIcon.


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
