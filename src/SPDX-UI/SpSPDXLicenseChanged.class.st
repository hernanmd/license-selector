Class {
	#name : #SpSPDXLicenseChanged,
	#superclass : #Announcement,
	#instVars : [
		'selectedLicense'
	],
	#category : #'SPDX-UI'
}

{ #category : #'instance creation' }
SpSPDXLicenseChanged class >> with: aLicense [

	^ self new selectedLicense: aLicense; yourself
]

{ #category : #accessing }
SpSPDXLicenseChanged >> selectedLicense [

	^ selectedLicense
]

{ #category : #accessing }
SpSPDXLicenseChanged >> selectedLicense: anObject [

	selectedLicense := anObject
]
