"
Contains a list of mapped CGSPDXLicense

    Instance Variables
	licenses:		<Collection>

"
Class {
	#name : #SPDXLicenseList,
	#superclass : #Object,
	#instVars : [
		'licenses'
	],
	#category : #'SPDX-Core'
}

{ #category : #accessing }
SPDXLicenseList >> licenseNames [

	^ self licenses collect: #licenseName
]

{ #category : #accessing }
SPDXLicenseList >> licenses [
	^ licenses
]

{ #category : #accessing }
SPDXLicenseList >> licenses: anObject [
	licenses := anObject
]
