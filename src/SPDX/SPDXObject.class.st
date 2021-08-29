"
Helper object to be used as a ""Read object"" during NeoJSON parsing.

"
Class {
	#name : #SPDXObject,
	#superclass : #Object,
	#instVars : [
		'licenseListVersion',
		'licenses',
		'releaseDate'
	],
	#category : #'SPDX-Parsing'
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
	" Answer a <Collection> of <SPDXLicense> "

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
