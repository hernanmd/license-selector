Class {
	#name : #SpSPDXLicensePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'licenseText',
		'licenseTextLabel',
		'licenseComments',
		'licenseCommentsLabel'
	],
	#category : #'SPDX-UI'
}

{ #category : #specs }
SpSPDXLicensePresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
			add: #licenseTextLabel height: self labelHeight;
			add: #licenseText;
			add: #licenseCommentsLabel height: self labelHeight;
			add: #licenseComments height: 60;
			yourself
]

{ #category : #initialization }
SpSPDXLicensePresenter >> initializePresenters [ 

	licenseText := self newText beNotEditable; beWrapWord; yourself.
	licenseTextLabel := self newLabel label: 'License'.
	
	licenseComments := self newText beNotEditable; beWrapWord; yourself.
	licenseCommentsLabel := self newLabel label: 'Comments'.
]

{ #category : #accessing }
SpSPDXLicensePresenter >> licenseComments [

	^ licenseComments
]

{ #category : #accessing }
SpSPDXLicensePresenter >> licenseComments: anObject [

	licenseComments := anObject
]

{ #category : #accessing }
SpSPDXLicensePresenter >> licenseCommentsLabel [

	^ licenseCommentsLabel
]

{ #category : #accessing }
SpSPDXLicensePresenter >> licenseCommentsLabel: anObject [

	licenseCommentsLabel := anObject
]

{ #category : #accessing }
SpSPDXLicensePresenter >> licenseText [

	^ licenseText
]

{ #category : #accessing }
SpSPDXLicensePresenter >> licenseText: anObject [

	licenseText := anObject
]

{ #category : #accessing }
SpSPDXLicensePresenter >> licenseTextLabel [

	^ licenseTextLabel
]

{ #category : #accessing }
SpSPDXLicensePresenter >> licenseTextLabel: anObject [

	licenseTextLabel := anObject
]

{ #category : #callbacks }
SpSPDXLicensePresenter >> updateWithLicense: aSPDXLicense [
	" Private - User has selected a new license or requested to sort the receiver's table. Update the text and comments section "

	aSPDXLicense selectedLicense 
		ifNotNil: [ : lic | 
			self licenseText text: lic licenseText.
			lic licenseComments 
				ifNotEmpty: [ : comm | self licenseComments text: comm ]
				ifEmpty: [ self licenseComments text: 'No comments' ] ]
		
]
