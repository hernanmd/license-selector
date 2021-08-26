Class {
	#name : #SPDXObject,
	#superclass : #Object,
	#instVars : [
		'licenseListVersion',
		'licenses',
		'releaseDate'
	],
	#category : #'SPDX-Core'
}

{ #category : #accessing }
SPDXObject >> licenseListVersion [
	^ licenseListVersion
]

{ #category : #accessing }
SPDXObject >> licenseListVersion: anObject [
	licenseListVersion := anObject
]

{ #category : #accessing }
SPDXObject >> licenseNames [

	^ self licenses collect: #licenseName
]

{ #category : #accessing }
SPDXObject >> licenses [
	" Answer a <Collection> of <CGSPDXLicense> "

	^ licenses
]

{ #category : #accessing }
SPDXObject >> licenses: anObject [
	licenses := anObject
]

{ #category : #accessing }
SPDXObject >> releaseDate [
	^ releaseDate
]

{ #category : #accessing }
SPDXObject >> releaseDate: anObject [
	releaseDate := anObject
]
